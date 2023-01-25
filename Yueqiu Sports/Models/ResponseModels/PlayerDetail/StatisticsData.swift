//
//  StatisticsData.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on January 18, 2023
//
import Foundation
import SwiftyJSON

struct StatisticsData {

	let section: String?
	let data: [Rating]?

	init(_ json: JSON) {
		section = json["section"].stringValue
		data = json["data"].arrayValue.map { Rating($0) }
	}

}
