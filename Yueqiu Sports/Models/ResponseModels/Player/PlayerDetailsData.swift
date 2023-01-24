
import Foundation
import SwiftyJSON

struct PlayerDetailsData {

    let id: String?
    let sportId: String?
    let slug: String?
    let name: String?
    let nameTranslations: NameTranslations?
    let nameShort: String?
    let photo: String?
    let position: String?
    let positionName: String?
    let weight: String?
    let age: String?
    let dateBirthAt: String?
    let height: String?
    let shirtNumber: String?
    let preferredFoot: String?
    let nationalityCode: String?
    let flag: String?
    let marketCurrency: String?
    let marketValue: String?
    let contractUntil: String?
    let rating: String?
    let characteristics: Characteristics?
    let ability: [Ability]?
    let teamId: String?
    let teamCategoryId: String?
    let teamVenueId: String?
    let teamManagerId: String?
    let teamSlug: String?
    let teamName: String?
    let teamLogo: String?
    let teamNameTranslations: TeamNameTranslations?
    let teamNameShort: String?
    let teamNameFull: String?
    let teamNameCode: String?
    let teamHasSub: String?
    let teamGender: String?
    let teamIsNationality: String?
    let teamCountryCode: String?
    let teamCountry: String?
    let teamFlag: String?
    let teamFoundation: String?
    let updated: String?

    init(_ json: JSON) {
        id = json["id"].stringValue
        sportId = json["sport_id"].stringValue
        slug = json["slug"].stringValue
        name = json["name"].stringValue
        nameTranslations = NameTranslations(json["name_translations"])
        nameShort = json["name_short"].stringValue
        photo = json["photo"].stringValue
        position = json["position"].stringValue
        positionName = json["position_name"].stringValue
        weight = json["weight"].stringValue
        age = json["age"].stringValue
        dateBirthAt = json["date_birth_at"].stringValue
        height = json["height"].stringValue
        shirtNumber = json["shirt_number"].stringValue
        preferredFoot = json["preferred_foot"].stringValue
        nationalityCode = json["nationality_code"].stringValue
        flag = json["flag"].stringValue
        marketCurrency = json["market_currency"].stringValue
        marketValue = json["market_value"].stringValue
        contractUntil = json["contract_until"].stringValue
        rating = json["rating"].stringValue
        characteristics = Characteristics(json["characteristics"])
        ability = json["ability"].arrayValue.map { Ability($0) }
        teamId = json["team_id"].stringValue
        teamCategoryId = json["team_category_id"].stringValue
        teamVenueId = json["team_venue_id"].stringValue
        teamManagerId = json["team_manager_id"].stringValue
        teamSlug = json["team_slug"].stringValue
        teamName = json["team_name"].stringValue
        teamLogo = json["team_logo"].stringValue
        teamNameTranslations = TeamNameTranslations(json["team_name_translations"])
        teamNameShort = json["team_name_short"].stringValue
        teamNameFull = json["team_name_full"].stringValue
        teamNameCode = json["team_name_code"].stringValue
        teamHasSub = json["team_has_sub"].stringValue
        teamGender = json["team_gender"].stringValue
        teamIsNationality = json["team_is_nationality"].stringValue
        teamCountryCode = json["team_country_code"].stringValue
        teamCountry = json["team_country"].stringValue
        teamFlag = json["team_flag"].stringValue
        teamFoundation = json["team_foundation"].stringValue
        updated = json["updated"].stringValue
    }

}
