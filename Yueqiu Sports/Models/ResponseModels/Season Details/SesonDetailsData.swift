//
//  SesonDetailsData.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on January 14, 2023
//
import Foundation
import SwiftyJSON

struct SesonDetailsData {

	let slug: String?
	let photo: String?
	let name: String?
	let id: String?
	let hostCountry: String?
	let season: String?
	let seasonOptions: [String]?
	let seasonStartDate: String?
	let seasonEndDate: String?
	let tournamentPerformance: [TournamentPerformance]?
	let seasonPerformance: [SeasonPerformance]?
	let champions: [Champions]?
	let standings: [Standings]?
	let about: String?
	let events: [Events]?
	let medias: [Medias]?

	init(_ json: JSON) {
		slug = json["slug"].stringValue
		photo = json["photo"].stringValue
		name = json["name"].stringValue
		id = json["id"].stringValue
		hostCountry = json["host_country"].stringValue
		season = json["season"].stringValue
		seasonOptions = json["season_options"].arrayValue.map { $0.stringValue }
		seasonStartDate = json["season_start_date"].stringValue
		seasonEndDate = json["season_end_date"].stringValue
		tournamentPerformance = json["tournament_performance"].arrayValue.map { TournamentPerformance($0) }
		seasonPerformance = json["season_performance"].arrayValue.map { SeasonPerformance($0) }
		champions = json["champions"].arrayValue.map { Champions($0) }
		standings = json["standings"].arrayValue.map { Standings($0) }
		about = json["about"].stringValue
		events = json["events"].arrayValue.map { Events($0) }
		medias = json["medias"].arrayValue.map { Medias($0) }
	}

}
