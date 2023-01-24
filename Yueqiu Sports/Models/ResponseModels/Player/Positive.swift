//
//  Positive.swift
//  Excellence Sports
//
//  Created by KHADER on 23/01/2023.
//

import Foundation
import SwiftyJSON

struct Positive {

    let feature: String?
    let value: Int?

    init(_ json: JSON) {
        feature = json["feature"].stringValue
        value = json["value"].intValue
    }

}
