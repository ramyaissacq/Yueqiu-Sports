//
//  SeasonDetailsResponse.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on January 14, 2023
//
import Foundation
import SwiftyJSON

struct SeasonDetailsResponse {

	let status: Int?
	let message: String?
	let data: SesonDetailsData?

	init(_ json: JSON) {
		status = json["status"].intValue
		message = json["message"].stringValue
		data = SesonDetailsData(json["data"])
	}

}
