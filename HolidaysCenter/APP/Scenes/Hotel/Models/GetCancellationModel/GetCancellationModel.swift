//
//  GetCancellationModel.swift
//  HolidaysCenterApp
//
//  Created by FCI on 11/03/24.
//

import Foundation
struct GetCancellationModel : Codable {
    let data : [String]?
    let msg : String?
    let status : Bool?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case msg = "msg"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([String].self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }

}
