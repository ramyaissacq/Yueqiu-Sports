//
//  Events.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on January 18, 2023
//
import Foundation
import SwiftyJSON

struct PlayerDetailsEvents {

	let leagueName: String?
	let leagueLogo: String?
	let leagueSlug: String?
	let matches: [PlayerMatches]?

	init(_ json: JSON) {
		leagueName = json["league_name"].stringValue
		leagueLogo = json["league_logo"].stringValue
		leagueSlug = json["league_slug"].stringValue
		matches = json["matches"].arrayValue.map { PlayerMatches($0) }
	}

}
