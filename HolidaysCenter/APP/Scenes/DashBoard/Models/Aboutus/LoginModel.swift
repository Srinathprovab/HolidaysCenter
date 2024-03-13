//
//  LoginModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 05/04/23.
//

import Foundation


struct LoginModel : Codable {
    let status : Bool?
    let user_id : String?
    let first_name : String?
    let last_name : String?
    let image : String?
    let data : String?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case user_id = "user_id"
        case first_name = "first_name"
        case last_name = "last_name"
        case image = "image"
        case data = "data"
        case msg = "msg"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        data = try values.decodeIfPresent(String.self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}


