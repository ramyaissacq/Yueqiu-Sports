//
//  Medias.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on January 14, 2023
//
import Foundation
import SwiftyJSON

struct Medias {

	let preview: String?
	let video: String?
	let title: String?
	let subtitle: String?
	let date: String?

	init(_ json: JSON) {
		preview = json["preview"].stringValue
		video = json["video"].stringValue
		title = json["title"].stringValue
		subtitle = json["subtitle"].stringValue
		date = json["date"].stringValue
	}

}