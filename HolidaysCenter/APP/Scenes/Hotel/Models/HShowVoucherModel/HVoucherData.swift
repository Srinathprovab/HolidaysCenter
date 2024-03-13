//
//  HVoucherData.swift
//  HolidaysCenter
//
//  Created by FCI on 07/11/23.
//

import Foundation

struct HVoucherData : Codable {
    let booking_details : [HVBooking_details]?
    let agent_details : String?

    enum CodingKeys: String, CodingKey {

        case booking_details = "booking_details"
        case agent_details = "agent_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking_details = try values.decodeIfPresent([HVBooking_details].self, forKey: .booking_details)
        agent_details = try values.decodeIfPresent(String.self, forKey: .agent_details)
    }

}
