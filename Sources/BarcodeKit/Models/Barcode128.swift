//
//  Models/Barcode128.swift
//  
//
//  Created by Charlie on 6/2/21.
//

import Foundation

public struct BKPixel_128 {

	let a: UInt8
	let r: UInt8
	let g: UInt8
	let b: UInt8
	
	public init(value: Character) {
	
		if value == "0" {
		
			self.a = 255
			self.r = 255
			self.g = 255
			self.b = 255
			
		} else {
		
			self.a = 255
			self.r = 0
			self.g = 0
			self.b = 0
			
		}
	
	}
	
	public init(a: UInt8, r: UInt8, g: UInt8, b: UInt8) {
	
		self.a = a
		self.r = r
		self.g = g
		self.b = b
		
	}
	
}

public struct BKSegment_128 {

	var value: Int
	var charachter: String
	var pattern: String
	
}

public enum BKSpecial_128: String {

    case StartCode_A, StartCode_B, StartCode_C, Stop

}
