//
//  RootClass.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on January 18, 2023
//
import Foundation
import SwiftyJSON

struct PlayerDetailResponse {

	let status: Int?
	let message: String?
	let playerData: PlayerData?

	init(_ json: JSON) {
		status = json["status"].intValue
		message = json["message"].stringValue
        playerData = PlayerData(json["data"])
	}

}
