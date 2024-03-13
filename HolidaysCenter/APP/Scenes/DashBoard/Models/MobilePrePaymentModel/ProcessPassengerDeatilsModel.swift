//
//  ProcessPassengerDeatilsModel.swift
//  HolidaysCenter
//
//  Created by FCI on 15/06/23.
//

import Foundation

struct ProcessPassengerDeatilsModel : Codable {
    let form_url : String?
    let status : Bool?
    let form_params : Form_params5?

    enum CodingKeys: String, CodingKey {

        case form_url = "form_url"
        case status = "status"
        case form_params = "form_params"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        form_url = try values.decodeIfPresent(String.self, forKey: .form_url)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        form_params = try values.decodeIfPresent(Form_params5.self, forKey: .form_params)
    }

}




struct Form_params5 : Codable {
    
    let app_reference : String?
    let promocode_val : String?
    let search_id : String?

    enum CodingKeys: String, CodingKey {

        case app_reference = "app_reference"
        case promocode_val = "promocode_val"
        case search_id = "search_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        promocode_val = try values.decodeIfPresent(String.self, forKey: .promocode_val)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
    }

}
