//
//  MapLocationModel.swift
//  HolidaysCenter
//
//  Created by Admin on 30/08/24.
//

import Foundation



struct MapLocationModel : Codable {
    let latitude : String?
    let longitude : String?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case latitude = "latitude"
        case longitude = "longitude"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
