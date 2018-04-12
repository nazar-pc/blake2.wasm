/**
 * @package blake2.wasm
 * @author  Nazar Mokrynskyi <nazar@mokrynskyi.com>
 * @license 0BSD
 */
lib		= require('..')
test	= require('tape')
vectors	= require('../vendor/testvectors/blake2-kat.json')

function hex2bin (hex)
	Buffer.from(hex, 'hex')
function bin2hex (bin)
	Buffer.from(bin).toString('hex')

<-! lib.ready
test('Running test vectors', (t) !->
	for vector in vectors
		switch vector.hash
			case 'blake2b'
				input	= hex2bin(vector.in)
				key		= hex2bin(vector.key)
				output	= lib.Blake2b(64, key)
					.update(input)
					.final()
				t.equal(bin2hex(output), vector.out)
			case 'blake2s'
				input	= hex2bin(vector.in)
				key		= hex2bin(vector.key)
				output	= lib.Blake2s(32, key)
					.update(input)
					.final()
				t.equal(bin2hex(output), vector.out)
			default
				void
	t.end()
)
