//
//  CountryListModel.swift
//  KuwaitWays
//
//  Created by FCI on 25/04/23.
//

import Foundation





struct CountryListModel : Codable {
    let data : CountryListData?
    let status : Bool?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case status = "status"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(CountryListData.self, forKey: .data)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}



struct CountryListData : Codable {
    let country_list : [Country_list]?

    enum CodingKeys: String, CodingKey {

        case country_list = "country_list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        country_list = try values.decodeIfPresent([Country_list].self, forKey: .country_list)
    }

}
