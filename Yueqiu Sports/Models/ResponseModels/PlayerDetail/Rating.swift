//
//  Rating.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on January 18, 2023
//
import Foundation
import SwiftyJSON

struct Rating {

	let key: String?
	let value: String?

	init(_ json: JSON) {
		key = json["key"].stringValue
		value = json["value"].stringValue
	}

}