//
//  NameTranslations.swift
//  Excellence Sports
//
//  Created by KHADER on 23/01/2023.
//

import Foundation
import SwiftyJSON

struct NameTranslations {

    let en: String?

    init(_ json: JSON) {
        en = json["en"].stringValue
    }

}
