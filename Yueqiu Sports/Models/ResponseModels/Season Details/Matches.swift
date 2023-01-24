//
//  Matches.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on January 14, 2023
//
import Foundation
import SwiftyJSON

struct Matches {

	let date: String?
	let homeScore: String?
	let awayScore: String?
	let homeName: String?
	let awayName: String?
	let slug: String?
	let round: String?

	init(_ json: JSON) {
		date = json["date"].stringValue
		homeScore = json["home_score"].stringValue
		awayScore = json["away_score"].stringValue
		homeName = json["home_name"].stringValue
		awayName = json["away_name"].stringValue
		slug = json["slug"].stringValue
		round = json["round"].stringValue
	}

}