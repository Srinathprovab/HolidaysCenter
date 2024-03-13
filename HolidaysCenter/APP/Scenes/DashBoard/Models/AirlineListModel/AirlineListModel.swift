//
//  AirlineListModel.swift
//  HolidaysCenter
//
//  Created by FCI on 07/06/23.
//

import Foundation

import Foundation
struct AirlineListModel : Codable {
    let airline_list : [Airline_list]?

    enum CodingKeys: String, CodingKey {

        case airline_list = "airline_list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        airline_list = try values.decodeIfPresent([Airline_list].self, forKey: .airline_list)
    }

}
