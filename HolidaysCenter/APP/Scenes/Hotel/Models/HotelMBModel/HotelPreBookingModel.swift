//
//  HotelPreBookingModel.swift
//  HolidaysCenter
//
//  Created by FCI on 06/11/23.
//

import Foundation

struct HotelPreBookingModel : Codable {
    let status : Int?
    let msg : String?
    let data : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        data = try values.decodeIfPresent(String.self, forKey: .data)
    }

}
