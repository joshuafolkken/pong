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

## Run

Then serve `wasm` directory to browser. i.e.

```sh
python3 -m http.server
ngrok http 8000
# cargo install basic-http-server
# basic-http-server wasm
```
