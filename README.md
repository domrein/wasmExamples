This is just a collection of simple examples of hand written wast compiled to wasm.

## Compiling
To compile examples, get wabt (wabbit):

`brew install wabt`

`wast2wasm examples.wast -o examples.wasm`

The repository for wabt can be found here: https://github.com/WebAssembly/wabt

NOTE: Currently you must compile wabt from source to run in Chrome 58 or above.

## Running
#### Browser
Load `index.html` from a web server to see usage and output of examples.

A great local webserver is `http-server`.

`npm install -g http-server`

`http-server -c-1` (serve files in current directy no cache)

#### Node.js
To use web assembly in Node.js, you need to use the `--expose-wasm` flag. As of 7.10.0, Node.js supports an old version of wasm and won't work with the binaries in the repository.
