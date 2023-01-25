//
//  Statistics.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on January 18, 2023
//
import Foundation
import SwiftyJSON

struct Statistics {

	let league: String?
	let statisticsData: [StatisticsData]?

	init(_ json: JSON) {
		league = json["league"].stringValue
        statisticsData = json["data"].arrayValue.map { StatisticsData($0) }
	}

}
