//
//  Data.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on January 14, 2023
//
import Foundation
import SwiftyJSON

struct SeasonData {

	let id: String?
	let leagueId: String?
	let slug: String?
	let name: String?
	let yearStart: String?
	let yearEnd: String?
	let sportId: String?
	let sectionId: String?
	let leagueSlug: String?
	let leagueName: String?
	let leagueNameTranslations: LeagueNameTranslations?
	let leagueLogo: String?
	let updated: String?

	init(_ json: JSON) {
		id = json["id"].stringValue
		leagueId = json["league_id"].stringValue
		slug = json["slug"].stringValue
		name = json["name"].stringValue
		yearStart = json["year_start"].stringValue
		yearEnd = json["year_end"].stringValue
		sportId = json["sport_id"].stringValue
		sectionId = json["section_id"].stringValue
		leagueSlug = json["league_slug"].stringValue
		leagueName = json["league_name"].stringValue
		leagueNameTranslations = LeagueNameTranslations(json["league_name_translations"])
		leagueLogo = json["league_logo"].stringValue
		updated = json["updated"].stringValue
	}

}
