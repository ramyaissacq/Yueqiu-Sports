//
//  PlyearDetailsResponse.swift
//  Excellence Sports
//
//  Created by KHADER on 23/01/2023.
//

import Foundation
import SwiftyJSON

struct PlayerDetailsResponse {
    
        let status: Int?
        let message: String?
        var data: [PlayerDetailsData]?
        let total: Int?
        let perPage: Int?

        init(_ json: JSON) {
            status = json["status"].intValue
            message = json["message"].stringValue
            data = json["data"].arrayValue.map { PlayerDetailsData($0) }
            total = json["total"].intValue
            perPage = json["per_page"].intValue
        }

}
