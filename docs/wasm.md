# WASM

## Use wasm-opt

### Installing

```sh
brew install binaryen
```

### Optimize

```sh
wasm-opt --enable-threads --enable-bulk-memory -Oz --output web/optimized.wasm web/index.wasm
mv web/optimized.wasm web/index.wasm
```
