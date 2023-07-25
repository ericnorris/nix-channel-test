#!/bin/bash


main() {
    uncached=$(nix-eval-jobs --check-cache-status "$@" ./default.nix | jq --slurp 'map(select(.isCached == false))')

    if [[ "$uncached" == "[]" ]]; then
        echo "Nothing to be built, exiting."
        exit 0
    fi

    echo "# The following packages are uncached and need to be built:"
    names <<<"$uncached"

    echo
    echo "# Building via nix-build..."

    derivations <<<"$uncached" | xargs nix-build "$@"

    echo
    echo "# Copying outputs to the binary cache..."

    outputs <<<"$uncached" | xargs nix copy --verbose --to "s3://muck-intromit-lizard?endpoint=https://storage.googleapis.com"

    echo "# Finished"
}

names() {
    jq --raw-output 'map(.name) | join("\n")'
}

derivations() {
    jq --raw-output '.[].drvPath'
}

outputs() {
    jq --raw-output '.[].outputs.out'
}

main "$@"
