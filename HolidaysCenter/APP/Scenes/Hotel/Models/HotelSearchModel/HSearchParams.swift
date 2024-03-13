//
//  HSearchParams.swift
//  HolidaysCenter
//
//  Created by FCI on 31/10/23.
//

import Foundation

struct HSearchParams : Codable {
    let city : String?
    let adult : [String]?
    let hotel_checkin : String?
    let hotel_checkout : String?
    let child : [String]?
    let user_id : String?
    let hotel_destination : String?
    let nationality : String?
    let rooms : String?

    enum CodingKeys: String, CodingKey {

        case city = "city"
        case adult = "adult"
        case hotel_checkin = "hotel_checkin"
        case hotel_checkout = "hotel_checkout"
        case child = "child"
        case user_id = "user_id"
        case hotel_destination = "hotel_destination"
        case nationality = "nationality"
        case rooms = "rooms"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        adult = try values.decodeIfPresent([String].self, forKey: .adult)
        hotel_checkin = try values.decodeIfPresent(String.self, forKey: .hotel_checkin)
        hotel_checkout = try values.decodeIfPresent(String.self, forKey: .hotel_checkout)
        child = try values.decodeIfPresent([String].self, forKey: .child)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        hotel_destination = try values.decodeIfPresent(String.self, forKey: .hotel_destination)
        nationality = try values.decodeIfPresent(String.self, forKey: .nationality)
        rooms = try values.decodeIfPresent(String.self, forKey: .rooms)
    }

}
