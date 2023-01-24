//
//  SeasonPerformance.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on January 14, 2023
//
import Foundation
import SwiftyJSON

struct SeasonPerformance {

	let name: String?
	let header: [String]?
	let subheader: [String]?
	let data: [[String]]?

	init(_ json: JSON) {
		name = json["name"].stringValue
		header = json["header"].arrayValue.map { $0.stringValue }
		subheader = json["subheader"].arrayValue.map { $0.stringValue }
        data = json["data"].arrayValue.map { $0.arrayValue.map{$0.stringValue} }
	}

}
