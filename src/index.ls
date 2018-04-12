/**
 * @package blake2.wasm
 * @author  Nazar Mokrynskyi <nazar@mokrynskyi.com>
 * @license 0BSD
 */

function Wrapper (lib)
	lib			= lib()
	allocate	= lib.allocateBytes
	free		= lib.freeBytes

	/**
	 * @constructor
	 *
	 * @param {number}		output_length	In bytes
	 * @param {Uint8Array}	key
	 *
	 * @return {!Uint8Array}
	 *
	 * @throws {Error} If input is incorrect
	 */
	function Blake2b (output_length = 64, key = null)
		if !(@ instanceof Blake2b)
			return new Blake2b(output_length, key)
		@_output_length	= output_length
		@_state			= allocate(240)
		if key && key.length
			key	= allocate(0, key)
			lib._blake2b_init_key(@_state, output_length, key, key.length)
			key.free()
		else
			lib._blake2b_init(@_state, output_length)


	Blake2b:: =
		/**
		 * @param {!Uint8Array} input
		 *
		 * @return {!Blake2b}
		 */
		update : (input) ->
			input	= allocate(0, input)
			lib._blake2b_update(@_state, input, input.length)
			input.free()
			@
		/**
		 * @return {!Uint8Array}
		 */
		final : ->
			output	= allocate(@_output_length)
			lib._blake2b_final(@_state, output, output.length)
			result	= output.get()
			output.free()
			@_state.free()
			result

	Object.defineProperty(Blake2b::, 'constructor', {value: Blake2b})
	/**
	 * @constructor
	 *
	 * @param {number}		output_length	In bytes
	 * @param {Uint8Array}	key
	 *
	 * @return {!Uint8Array}
	 *
	 * @throws {Error} If input is incorrect
	 */
	function Blake2s (output_length = 32, key = null)
		if !(@ instanceof Blake2s)
			return new Blake2s(output_length, key)
		@_output_length	= output_length
		@_state			= allocate(176)
		if key && key.length
			key	= allocate(0, key)
			lib._blake2s_init_key(@_state, output_length, key, key.length)
			key.free()
		else
			lib._blake2s_init(@_state, output_length)


	Blake2s:: =
		/**
		 * @param {!Uint8Array} input
		 *
		 * @return {!Blake2s}
		 */
		update : (input) ->
			input	= allocate(0, input)
			lib._blake2s_update(@_state, input, input.length)
			input.free()
			@
		/**
		 * @return {!Uint8Array}
		 */
		final : ->
			output	= allocate(@_output_length)
			lib._blake2s_final(@_state, output, output.length)
			result	= output.get()
			output.free()
			@_state.free()
			result

	Object.defineProperty(Blake2s::, 'constructor', {value: Blake2s})

	{
		ready	: lib.then
		Blake2b	: Blake2b
		Blake2s	: Blake2s
	}

if typeof define == 'function' && define['amd']
	# AMD
	define(['./blake2'], Wrapper)
else if typeof exports == 'object'
	# CommonJS
	module.exports = Wrapper(require('./blake2'))
else
	# Browser globals
	@'blake2_wasm' = Wrapper(@'__blake2_wasm')
