//
//  Region.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on November 04, 2022
//
import Foundation
import SwiftyJSON

struct Region {

	let code: String?
	let ip: String?
	let isBanned: Int?

	init(_ json: JSON) {
		code = json["code"].stringValue
		ip = json["ip"].stringValue
		isBanned = json["is_banned"].intValue
	}

}