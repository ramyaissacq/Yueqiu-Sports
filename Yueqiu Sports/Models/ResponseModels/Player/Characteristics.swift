//
//  Characteristics.swift
//  Excellence Sports
//
//  Created by KHADER on 23/01/2023.
//

import Foundation
import SwiftyJSON

struct Characteristics {

    let positive: [Positive]?

    init(_ json: JSON) {
        positive = json["positive"].arrayValue.map { Positive($0) }
    }

}
