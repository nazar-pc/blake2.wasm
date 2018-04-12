# blake2.wasm [![Travis CI](https://img.shields.io/travis/nazar-pc/blake2.wasm/master.svg?label=Travis%20CI)](https://travis-ci.org/nazar-pc/blake2.wasm)
[BLAKE2b and BLAKE2s hash functions](https://blake2.net/) compiled to WebAssembly using Emscripten and optimized for small size

## How to install
```
npm install blake2.wasm
```

## How to use
Node.js:
```javascript
var blake2 = require('blake2.wasm')

blake2.ready(function () {
    // Do stuff
});
```
Browser:
```javascript
requirejs(['blake2.wasm'], function (blake2) {
    blake2.ready(function () {
        // Do stuff
    });
})
```

# API
### blake2.ready(callback)
* `callback` - Callback function that is called when WebAssembly is loaded and library is ready for use

### blake2.Blake2b(output_length = 64 : number, key = null  Uint8Array) : Blake2b
Create Blake2b object that can later be updated with data

* `output_length` - Length of output hash in bytes, defaults to full 512-bit hash (64 bytes)
* `key` - Secret key

### blake2.Blake2b.update(input : Uint8Array) : Blake2b
Update instance with data

### blake2.Blake2b.final() : Uint8Array
Get hash

### blake2.Blake2s(output_length = 32 : number, key = null  Uint8Array) : Blake2s
Create Blake2s object that can later be updated with data

* `output_length` - Length of output hash in bytes, defaults to full 256-bit hash (32 bytes)
* `key` - Secret key

### blake2.Blake2s.update(input : Uint8Array) : Blake2s
Update instance with data

### blake2.Blake2s.final() : Uint8Array
Get hash

Take a look at `src/index.ls` for JsDoc sections with arguments and return types as well as methods description, look at `tests/index.ls` for usage examples.

## Contribution
Feel free to create issues and send pull requests (for big changes create an issue first and link it from the PR), they are highly appreciated!

When reading LiveScript code make sure to configure 1 tab to be 4 spaces (GitHub uses 8 by default), otherwise code might be hard to read.

## License
Free Public License 1.0.0 / Zero Clause BSD License

https://opensource.org/licenses/FPL-1.0.0

https://tldrlegal.com/license/bsd-0-clause-license
