# pre-commit-buf

This is a pre-comit hook for buf.

For pre-commit: see `https://github.com/pre-commit/pre-commit`

For buf: see `https://github.com/bufbuild/buf`

## Using buf with pre-commit

Add this to your `.pre-commit-config.yaml`:

```yaml
- repo: https://github.com/johnor/pre-commit-buf
  rev: '' # Use the tag you want to point at
  hooks:
    - id: buf-lint
    - id: buf-breaking-master
```

## Available Hooks

### `buf-lint`

Run buf lint on proto files.

### `buf-lint`

_New in v1.3.1_

Run buf format on proto files.

### `buf-breaking`

Run buf breaking on proto files. Add `args: ["--agsinst", BRANCH]` where BRANCH
could for example be `".git#branch=origin/master"` to your
.pre-commit-config.yaml file.

### `buf-breaking-master`

Run buf breaking on proto files against the master branch.
