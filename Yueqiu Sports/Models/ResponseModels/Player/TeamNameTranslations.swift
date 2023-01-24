//
//  TeamNameTranslations.swift
//  Excellence Sports
//
//  Created by KHADER on 23/01/2023.
//

import Foundation
import SwiftyJSON

struct TeamNameTranslations {

    let en: String?
    let ru: String?
    let de: String?
    let es: String?
    let fr: String?
    let zh: String?
    let tr: String?
    let el: String?
    let it: String?
    let nl: String?
    let pt: String?

    init(_ json: JSON) {
        en = json["en"].stringValue
        ru = json["ru"].stringValue
        de = json["de"].stringValue
        es = json["es"].stringValue
        fr = json["fr"].stringValue
        zh = json["zh"].stringValue
        tr = json["tr"].stringValue
        el = json["el"].stringValue
        it = json["it"].stringValue
        nl = json["nl"].stringValue
        pt = json["pt"].stringValue
    }

}
