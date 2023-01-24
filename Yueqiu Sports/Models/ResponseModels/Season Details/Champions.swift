//
//  Champions.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on January 14, 2023
//
import Foundation
import SwiftyJSON

struct Champions {

	let slug: String?
	let logo: String?
	let teamName: String?
	let title: String?

	init(_ json: JSON) {
		slug = json["slug"].stringValue
		logo = json["logo"].stringValue
		teamName = json["team_name"].stringValue
		title = json["title"].stringValue
	}

}