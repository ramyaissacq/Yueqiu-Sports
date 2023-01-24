//
//  RootClass.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on January 14, 2023
//
import Foundation
import SwiftyJSON

struct SeasonsResponse {

	let status: Int?
	let message: String?
	let data: [SeasonData]?
	let total: Int?
	let perPage: Int?

	init(_ json: JSON) {
		status = json["status"].intValue
		message = json["message"].stringValue
		data = json["data"].arrayValue.map { SeasonData($0) }
		total = json["total"].intValue
		perPage = json["per_page"].intValue
	}

}
