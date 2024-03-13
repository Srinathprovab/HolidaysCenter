//
//  HotelMBModel.swift
//  KuwaitWays
//
//  Created by FCI on 04/05/23.
//

import Foundation


struct HotelMBModel : Codable {
    let status : Int?
    let msg : String?
    let data : HotelMBData?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case msg = "msg"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        data = try values.decodeIfPresent(HotelMBData.self, forKey: .data)
    }
    
}



struct HotelMBData : Codable {
    // let active_payment_options : [String]?
    //    let user_country_code : String?
    //    let booking_source : String?
    //  let pre_booking_params : HBPre_booking_params?
    //    let total_price : Int?
    //    let convenience_fees : Int?
    //    let tax_service_sum : Int?
    //    let traveller_details : [String]?
    //    let country_code : Country_code?
    let search_data : HBSearch_data?
    let token : String?
    let token_key : String?
    let special_request : [String]?
    
    enum CodingKeys: String, CodingKey {
        
        //    case active_payment_options = "active_payment_options"
        //        case user_country_code = "user_country_code"
        //        case booking_source = "booking_source"
        //  case pre_booking_params = "pre_booking_params"
        //        case total_price = "total_price"
        //        case convenience_fees = "convenience_fees"
        //        case tax_service_sum = "tax_service_sum"
        //        case traveller_details = "traveller_details"
        //        case country_code = "country_code"
        case search_data = "search_data"
        case token = "token"
        case token_key = "token_key"
        case special_request = "special_request"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //    active_payment_options = try values.decodeIfPresent([String].self, forKey: .active_payment_options)
        //        user_country_code = try values.decodeIfPresent(String.self, forKey: .user_country_code)
        //        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        //  pre_booking_params = try values.decodeIfPresent(HBPre_booking_params.self, forKey: .pre_booking_params)
        //        total_price = try values.decodeIfPresent(Int.self, forKey: .total_price)
        //        convenience_fees = try values.decodeIfPresent(Int.self, forKey: .convenience_fees)
        //        tax_service_sum = try values.decodeIfPresent(Int.self, forKey: .tax_service_sum)
        //        traveller_details = try values.decodeIfPresent([String].self, forKey: .traveller_details)
        //     country_code = try values.decodeIfPresent(Country_code.self, forKey: .country_code)
        search_data = try values.decodeIfPresent(HBSearch_data.self, forKey: .search_data)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        token_key = try values.decodeIfPresent(String.self, forKey: .token_key)
        special_request = try values.decodeIfPresent([String].self, forKey: .special_request)
    }
    
}
