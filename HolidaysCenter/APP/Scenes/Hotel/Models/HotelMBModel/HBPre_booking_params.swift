//
//  HBPre_booking_params.swift
//  HolidaysCenter
//
//  Created by FCI on 06/11/23.
//

import Foundation

struct HBPre_booking_params : Codable {
    let search_id : String?
    let booking_source : String?
    let token : Token?
    let user_id : String?
    let room_selected : String?
    let read_token : String?
    let price_token : [String]?
    let hotelCode : String?
    let roomTypeName : String?
    let boarding_details : [String]?
    let lastCancellationDate : String?
    let cancellationPolicy_API : [String]?
    let tM_Cancellation_Charge : [String]?
    let surcharge_total : String?
    let sur_Charge_exclude : String?
    let surCharge_exclude_name : String?
    let price_summary : Price_summary?
    let nEWRatePlanCode : String?
    let booking_code : String?
    let price_range : String?
    let firstDayCostCancellation : String?
    let cancellation_Description : String?
    let policyRules : String?
    let markup_price_summary : Markup_price_summary?
    let default_currency : String?

    enum CodingKeys: String, CodingKey {

        case search_id = "search_id"
        case booking_source = "booking_source"
        case token = "token"
        case user_id = "user_id"
        case room_selected = "room_selected"
        case read_token = "read_token"
        case price_token = "price_token"
        case hotelCode = "HotelCode"
        case roomTypeName = "RoomTypeName"
        case boarding_details = "Boarding_details"
        case lastCancellationDate = "LastCancellationDate"
        case cancellationPolicy_API = "CancellationPolicy_API"
        case tM_Cancellation_Charge = "TM_Cancellation_Charge"
        case surcharge_total = "Surcharge_total"
        case sur_Charge_exclude = "sur_Charge_exclude"
        case surCharge_exclude_name = "surCharge_exclude_name"
        case price_summary = "price_summary"
        case nEWRatePlanCode = "NEWRatePlanCode"
        case booking_code = "booking_code"
        case price_range = "price_range"
        case firstDayCostCancellation = "FirstDayCostCancellation"
        case cancellation_Description = "Cancellation_Description"
        case policyRules = "PolicyRules"
        case markup_price_summary = "markup_price_summary"
        case default_currency = "default_currency"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        token = try values.decodeIfPresent(Token.self, forKey: .token)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        room_selected = try values.decodeIfPresent(String.self, forKey: .room_selected)
        read_token = try values.decodeIfPresent(String.self, forKey: .read_token)
        price_token = try values.decodeIfPresent([String].self, forKey: .price_token)
        hotelCode = try values.decodeIfPresent(String.self, forKey: .hotelCode)
        roomTypeName = try values.decodeIfPresent(String.self, forKey: .roomTypeName)
        boarding_details = try values.decodeIfPresent([String].self, forKey: .boarding_details)
        lastCancellationDate = try values.decodeIfPresent(String.self, forKey: .lastCancellationDate)
        cancellationPolicy_API = try values.decodeIfPresent([String].self, forKey: .cancellationPolicy_API)
        tM_Cancellation_Charge = try values.decodeIfPresent([String].self, forKey: .tM_Cancellation_Charge)
        surcharge_total = try values.decodeIfPresent(String.self, forKey: .surcharge_total)
        sur_Charge_exclude = try values.decodeIfPresent(String.self, forKey: .sur_Charge_exclude)
        surCharge_exclude_name = try values.decodeIfPresent(String.self, forKey: .surCharge_exclude_name)
        price_summary = try values.decodeIfPresent(Price_summary.self, forKey: .price_summary)
        nEWRatePlanCode = try values.decodeIfPresent(String.self, forKey: .nEWRatePlanCode)
        booking_code = try values.decodeIfPresent(String.self, forKey: .booking_code)
        price_range = try values.decodeIfPresent(String.self, forKey: .price_range)
        firstDayCostCancellation = try values.decodeIfPresent(String.self, forKey: .firstDayCostCancellation)
        cancellation_Description = try values.decodeIfPresent(String.self, forKey: .cancellation_Description)
        policyRules = try values.decodeIfPresent(String.self, forKey: .policyRules)
        markup_price_summary = try values.decodeIfPresent(Markup_price_summary.self, forKey: .markup_price_summary)
        default_currency = try values.decodeIfPresent(String.self, forKey: .default_currency)
    }

}
