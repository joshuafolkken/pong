#!/bin/bash
# chmod +x ./export-web.sh

echo "Exporting Godot project to Web..."
godot --no-window --export-release "Web" web/index.html
echo "Done."

echo "Optimizing WebAssembly..."
wasm-opt --enable-threads --enable-bulk-memory -Oz --output web/optimized.wasm web/index.wasm
echo "Done."

echo "Replacing WebAssembly..."
mv web/optimized.wasm web/index.wasm
echo "Done."

echo "Web export completed successfully!"
