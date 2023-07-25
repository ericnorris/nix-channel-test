# nix-channel-test

TODO: repeat this, but with flakes.

Steps taken:

- [x] Create public github repository (this)
- [x] Set up GCS bucket
- [x] Set up service account w/ rw access to bucket
- [x] Set up service account w/ ro access to the bucket
- [x] Create an HMAC key for the rw service account
- [x] Create an HMAC key for the ro service account
- [x] Write a nix expression that creates an example binary
- [x] Write GitHub actions code to publish the built nix files to GCS (as an S3 bucket)
- [x] Install nix somewhere
  ```
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  ```
- [x] Add the public github repository as a channel

  ```
  nix-channel --add https://github.com/ericnorris/nix-channel-test/archive/main.tar.gz etsypkgs
  nix-channel --update
  ```
- [x] Set up ro S3 credentials for `root` at `/root/.aws/credentials`
- [x] Install the example binary
  ```
  nix profile install --builders '' --extra-substituters 's3://<bucket>?endpoint=https://storage.googleapis.com&trusted=true' --debug --impure --expr 'import <etsypkgs>' 'hello'
  ```

Result:

```
ubuntu-2204-f87ea0:~# hello
Hello world from a custom Nix channel
```
