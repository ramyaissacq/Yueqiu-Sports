//
//  PlayerData.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on January 18, 2023
//
import Foundation
import SwiftyJSON

struct PlayerData {

	let playerId: String?
	let playerPhoto: String?
	let playerName: String?
	let playerCountry: String?
	let teamPhoto: String?
	let teamName: String?
	let teamSlug: String?
	let indicators: [Rating]?
	let rating: [Rating]?
	let statistics: [Statistics]?
	let about: String?
	let events: [PlayerDetailsEvents]?
	let medias: [PlayerMedias]?

	init(_ json: JSON) {
		playerId = json["player_id"].stringValue
		playerPhoto = json["player_photo"].stringValue
		playerName = json["player_name"].stringValue
		playerCountry = json["player_country"].stringValue
		teamPhoto = json["team_photo"].stringValue
		teamName = json["team_name"].stringValue
		teamSlug = json["team_slug"].stringValue
		indicators = json["indicators"].arrayValue.map { Rating($0) }
		rating = json["rating"].arrayValue.map { Rating($0) }
		statistics = json["statistics"].arrayValue.map { Statistics($0) }
		about = json["about"].stringValue
		events = json["events"].arrayValue.map { PlayerDetailsEvents($0) }
		medias = json["medias"].arrayValue.map { PlayerMedias($0) }
	}

}
