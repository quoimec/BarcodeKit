//
//  Barcodes/Barcode128.swift
//  BarcodeKit
//
//  Created by Charlie on 31/1/21.
//

import Foundation
import CoreGraphics

public class BKGenerator_128 {

	var segments: Array<BKSegment_128>
	var checksum: Int

	private let lookup: Array<BKSegment_128> = [
		BKSegment_128(value: 0, charachter: " ", pattern: "11011001100"),
		BKSegment_128(value: 1, charachter: "!", pattern: "11001101100"),
		BKSegment_128(value: 2, charachter: "\"", pattern: "11001100110"),
		BKSegment_128(value: 3, charachter: "#", pattern: "10010011000"),
		BKSegment_128(value: 4, charachter: "$", pattern: "10010001100"),
		BKSegment_128(value: 5, charachter: "%", pattern: "10001001100"),
		BKSegment_128(value: 6, charachter: "&", pattern: "10011001000"),
		BKSegment_128(value: 7, charachter: "'", pattern: "10011000100"),
		BKSegment_128(value: 8, charachter: "(", pattern: "10001100100"),
		BKSegment_128(value: 9, charachter: ")", pattern: "11001001000"),
		BKSegment_128(value: 10, charachter: "*", pattern: "11001000100"),
		BKSegment_128(value: 11, charachter: "+", pattern: "11000100100"),
		BKSegment_128(value: 12, charachter: ",", pattern: "10110011100"),
		BKSegment_128(value: 13, charachter: "-", pattern: "10011011100"),
		BKSegment_128(value: 14, charachter: ".", pattern: "10011001110"),
		BKSegment_128(value: 15, charachter: "/", pattern: "10111001100"),
		BKSegment_128(value: 16, charachter: "0", pattern: "10011101100"),
		BKSegment_128(value: 17, charachter: "1", pattern: "10011100110"),
		BKSegment_128(value: 18, charachter: "2", pattern: "11001110010"),
		BKSegment_128(value: 19, charachter: "3", pattern: "11001011100"),
		BKSegment_128(value: 20, charachter: "4", pattern: "11001001110"),
		BKSegment_128(value: 21, charachter: "5", pattern: "11011100100"),
		BKSegment_128(value: 22, charachter: "6", pattern: "11001110100"),
		BKSegment_128(value: 23, charachter: "7", pattern: "11101101110"),
		BKSegment_128(value: 24, charachter: "8", pattern: "11101001100"),
		BKSegment_128(value: 25, charachter: "9", pattern: "11100101100"),
		BKSegment_128(value: 26, charachter: ":", pattern: "11100100110"),
		BKSegment_128(value: 27, charachter: ";", pattern: "11101100100"),
		BKSegment_128(value: 28, charachter: "<", pattern: "11100110100"),
		BKSegment_128(value: 29, charachter: "=", pattern: "11100110010"),
		BKSegment_128(value: 30, charachter: ">", pattern: "11011011000"),
		BKSegment_128(value: 31, charachter: "?", pattern: "11011000110"),
		BKSegment_128(value: 32, charachter: "@", pattern: "11000110110"),
		BKSegment_128(value: 33, charachter: "A", pattern: "10100011000"),
		BKSegment_128(value: 34, charachter: "B", pattern: "10001011000"),
		BKSegment_128(value: 35, charachter: "C", pattern: "10001000110"),
		BKSegment_128(value: 36, charachter: "D", pattern: "10110001000"),
		BKSegment_128(value: 37, charachter: "E", pattern: "10001101000"),
		BKSegment_128(value: 38, charachter: "F", pattern: "10001100010"),
		BKSegment_128(value: 39, charachter: "G", pattern: "11010001000"),
		BKSegment_128(value: 40, charachter: "H", pattern: "11000101000"),
		BKSegment_128(value: 41, charachter: "I", pattern: "11000100010"),
		BKSegment_128(value: 42, charachter: "J", pattern: "10110111000"),
		BKSegment_128(value: 43, charachter: "K", pattern: "10110001110"),
		BKSegment_128(value: 44, charachter: "L", pattern: "10001101110"),
		BKSegment_128(value: 45, charachter: "M", pattern: "10111011000"),
		BKSegment_128(value: 46, charachter: "N", pattern: "10111000110"),
		BKSegment_128(value: 47, charachter: "O", pattern: "10001110110"),
		BKSegment_128(value: 48, charachter: "P", pattern: "11101110110"),
		BKSegment_128(value: 49, charachter: "Q", pattern: "11010001110"),
		BKSegment_128(value: 50, charachter: "R", pattern: "11000101110"),
		BKSegment_128(value: 51, charachter: "S", pattern: "11011101000"),
		BKSegment_128(value: 52, charachter: "T", pattern: "11011100010"),
		BKSegment_128(value: 53, charachter: "U", pattern: "11011101110"),
		BKSegment_128(value: 54, charachter: "V", pattern: "11101011000"),
		BKSegment_128(value: 55, charachter: "W", pattern: "11101000110"),
		BKSegment_128(value: 56, charachter: "X", pattern: "11100010110"),
		BKSegment_128(value: 57, charachter: "Y", pattern: "11101101000"),
		BKSegment_128(value: 58, charachter: "Z", pattern: "11101100010"),
		BKSegment_128(value: 59, charachter: "[", pattern: "11100011010"),
		BKSegment_128(value: 60, charachter: "\\", pattern: "11101111010"),
		BKSegment_128(value: 61, charachter: "]", pattern: "11001000010"),
		BKSegment_128(value: 62, charachter: "^", pattern: "11110001010"),
		BKSegment_128(value: 63, charachter: "_", pattern: "10100110000"),
		BKSegment_128(value: 64, charachter: "`", pattern: "10100001100"),
		BKSegment_128(value: 65, charachter: "a", pattern: "10010110000"),
		BKSegment_128(value: 66, charachter: "b", pattern: "10010000110"),
		BKSegment_128(value: 67, charachter: "c", pattern: "10000101100"),
		BKSegment_128(value: 68, charachter: "d", pattern: "10000100110"),
		BKSegment_128(value: 69, charachter: "e", pattern: "10110010000"),
		BKSegment_128(value: 70, charachter: "f", pattern: "10110000100"),
		BKSegment_128(value: 71, charachter: "g", pattern: "10011010000"),
		BKSegment_128(value: 72, charachter: "h", pattern: "10011000010"),
		BKSegment_128(value: 73, charachter: "i", pattern: "10000110100"),
		BKSegment_128(value: 74, charachter: "j", pattern: "10000110010"),
		BKSegment_128(value: 75, charachter: "k", pattern: "11000010010"),
		BKSegment_128(value: 76, charachter: "l", pattern: "11001010000"),
		BKSegment_128(value: 77, charachter: "m", pattern: "11110111010"),
		BKSegment_128(value: 78, charachter: "n", pattern: "11000010100"),
		BKSegment_128(value: 79, charachter: "o", pattern: "10001111010"),
		BKSegment_128(value: 80, charachter: "p", pattern: "10100111100"),
		BKSegment_128(value: 81, charachter: "q", pattern: "10010111100"),
		BKSegment_128(value: 82, charachter: "r", pattern: "10010011110"),
		BKSegment_128(value: 83, charachter: "s", pattern: "10111100100"),
		BKSegment_128(value: 84, charachter: "t", pattern: "10011110100"),
		BKSegment_128(value: 85, charachter: "u", pattern: "10011110010"),
		BKSegment_128(value: 86, charachter: "v", pattern: "11110100100"),
		BKSegment_128(value: 87, charachter: "w", pattern: "11110010100"),
		BKSegment_128(value: 88, charachter: "x", pattern: "11110010010"),
		BKSegment_128(value: 89, charachter: "y", pattern: "11011011110"),
		BKSegment_128(value: 90, charachter: "z", pattern: "11011110110"),
		BKSegment_128(value: 91, charachter: "{", pattern: "11110110110"),
		BKSegment_128(value: 92, charachter: "|", pattern: "10101111000"),
		BKSegment_128(value: 93, charachter: "}", pattern: "10100011110"),
		BKSegment_128(value: 94, charachter: "~", pattern: "10001011110"),
		BKSegment_128(value: 95, charachter: "DEL", pattern: "10111101000"),
		BKSegment_128(value: 96, charachter: "FNC3", pattern: "10111100010"),
		BKSegment_128(value: 97, charachter: "FNC2", pattern: "11110101000"),
		BKSegment_128(value: 98, charachter: "ShiftA", pattern: "11110100010"),
		BKSegment_128(value: 99, charachter: "CodeC", pattern: "10111011110"),
		BKSegment_128(value: 100, charachter: "FNC4", pattern: "10111101110"),
		BKSegment_128(value: 101, charachter: "CodeA", pattern: "11101011110"),
		BKSegment_128(value: 102, charachter: "FNC1", pattern: "11110101110"),
		BKSegment_128(value: 103, charachter: BKSpecial_128.StartCode_A.rawValue, pattern: "11010000100"),
		BKSegment_128(value: 104, charachter: BKSpecial_128.StartCode_B.rawValue, pattern: "11010010000"),
		BKSegment_128(value: 105, charachter: BKSpecial_128.StartCode_C.rawValue, pattern: "11010011100"),
		BKSegment_128(value: 106, charachter: BKSpecial_128.Stop.rawValue, pattern: "1100011101011")
	]
	
	public init?(data: String) {
	
		self.segments = []
		self.checksum = 0
		
		do {
		
			self.segments.append(try self.lookup(charachter: BKSpecial_128.StartCode_A.rawValue))
		
			for charachter in data {
				self.segments.append(try self.lookup(charachter: String(charachter)))
			}
			
			let indexes = [Int](1...data.count)
			self.checksum = (self.segments[0].value + indexes.map({ $0 * self.segments[$0].value }).reduce(0, { $0 + $1 })) % 103
			
			self.segments.append(self.lookup[self.checksum])
			self.segments.append(try self.lookup(charachter: BKSpecial_128.Stop.rawValue))
			
		} catch {
			return nil
		}
		
	}
	
	private func lookup(charachter: String) throws -> BKSegment_128 {
	
		guard let segment = self.lookup.first(where: { $0.charachter == charachter }) else {
			print("BKGenerator_128 was passed an invalid charachter: \(charachter)")
			throw BKError.InvalidBarcodeCharachter
		}
	
		return segment
	
	}
	
	public func image(width: Int) -> CGImage? {
		
		// 	LinesCount -> Charachter count + start code & check sum + stop code
		let lines = self.segments.reduce(0, { $0 + $1.pattern.count })
		let count = Int(ceil(Float(width) / Float(lines)))
		let pattern = Array(self.segments.reduce("", { $0 + $1.pattern }))
		
		let row = pattern.map({ [BKPixel_128](repeating: BKPixel_128(value: $0), count: count) }).reduce([], { $0 + $1 })
		
		var pixels = Array<BKPixel_128>()

		for _ in 0 ..< row.count { pixels += row }

		let size = Int(Double(pixels.count).squareRoot())

		guard let provider = CGDataProvider(data: NSData(bytes: &pixels, length: pixels.count * MemoryLayout<BKPixel_128>.size)) else { return nil }

		return CGImage(width: size, height: size, bitsPerComponent: 8, bitsPerPixel: 32, bytesPerRow: size * MemoryLayout<BKPixel_128>.size, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue), provider: provider, decode: nil, shouldInterpolate: true, intent: .defaultIntent)
	
	}
	
}

var barcode = BKGenerator_128(data: "A5470914")
var barcode_image = barcode?.image(width: 200)

