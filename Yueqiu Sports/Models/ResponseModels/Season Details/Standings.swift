//
//  Standings.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on January 14, 2023
//
import Foundation
import SwiftyJSON

struct Standings {

	let name: String?
	let tableHeader: [String]?
	let tableData: [[String]]?

	init(_ json: JSON) {
		name = json["name"].stringValue
		tableHeader = json["table_header"].arrayValue.map { $0.stringValue }
        tableData = json["table_data"].arrayValue.map { $0.arrayValue.map{$0.stringValue}}
	}

}
