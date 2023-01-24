//
//  Ability.swift
//  Excellence Sports
//
//  Created by KHADER on 23/01/2023.
//

import Foundation
import SwiftyJSON

struct Ability {

    let name: String?
    let value: Int?
    let fullAverage: Int?

    init(_ json: JSON) {
        name = json["name"].stringValue
        value = json["value"].intValue
        fullAverage = json["full_average"].intValue
    }

}
