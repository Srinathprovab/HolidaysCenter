//
//  HotelSearchModel.swift
//  HolidaysCenter
//
//  Created by FCI on 31/10/23.
//

import Foundation


struct HotelSearchModel : Codable {
    let status : Bool?
    let msg : String?
    let search_id : Int?
    let search_params : HSearchParams?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case search_id = "search_id"
        case search_params = "search_params"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
        search_params = try values.decodeIfPresent(HSearchParams.self, forKey: .search_params)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}
