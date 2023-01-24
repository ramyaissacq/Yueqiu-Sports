//
//  LeagueNameTranslations.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on January 14, 2023
//
import Foundation
import SwiftyJSON

struct LeagueNameTranslations {

	let en: String?
	let ru: String?

	init(_ json: JSON) {
		en = json["en"].stringValue
		ru = json["ru"].stringValue
	}

}