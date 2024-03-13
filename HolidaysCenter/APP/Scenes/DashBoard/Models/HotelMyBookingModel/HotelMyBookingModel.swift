//
//  HotelMyBookingModel.swift
//  HolidaysCenter
//
//  Created by FCI on 18/12/23.
//

import Foundation

struct HotelMyBookingModel : Codable {
    let confirmed_booking_details : [Confirmed_booking_details]?
    let cancelled_booking_details : [Cancelled_booking_details]?
    let upcoming_booking_details : [Upcoming_booking_details]?
    let msg : String?
    let status : Bool?

    enum CodingKeys: String, CodingKey {

        case confirmed_booking_details = "confirmed_booking_details"
        case cancelled_booking_details = "cancelled_booking_details"
        case upcoming_booking_details = "upcoming_booking_details"
        case msg = "msg"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        confirmed_booking_details = try values.decodeIfPresent([Confirmed_booking_details].self, forKey: .confirmed_booking_details)
        cancelled_booking_details = try values.decodeIfPresent([Cancelled_booking_details].self, forKey: .cancelled_booking_details)
        upcoming_booking_details = try values.decodeIfPresent([Upcoming_booking_details].self, forKey: .upcoming_booking_details)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }

}
