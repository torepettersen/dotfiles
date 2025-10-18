# dotlink

`dotlink` reads `dotlink.toml` and creates the configured symlinks so your dotfiles land in the right places.

Build the binary and drop it in the parent `dotfiles` directory:

```sh
cargo build --release
install -Dm755 target/release/dotlink ../install
```
