//
//  HotelDetailsModel.swift
//  KuwaitWays
//
//  Created by FCI on 03/05/23.
//

import Foundation


struct HotelDetailsModel : Codable {
    let session_expiry_details : Session_expiry_details?
    let msg : String?
    let status : Bool?
    let hotel_search_params : Hotel_search_params?
    let hotel_details : Hotel_details?
    let roomDetails : String?
    let hotel_details_key : String?
    let params : Params?
    let price_change : Int?
    
    

    enum CodingKeys: String, CodingKey {

        case session_expiry_details = "session_expiry_details"
        case msg = "msg"
        case status = "status"
        case hotel_search_params = "hotel_search_params"
        case hotel_details = "hotel_details"
        case roomDetails = "RoomDetails"
        case hotel_details_key = "hotel_details_key"
        case params = "params"
        case price_change = "price_change"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        session_expiry_details = try values.decodeIfPresent(Session_expiry_details.self, forKey: .session_expiry_details)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        hotel_search_params = try values.decodeIfPresent(Hotel_search_params.self, forKey: .hotel_search_params)
        hotel_details = try values.decodeIfPresent(Hotel_details.self, forKey: .hotel_details)
        roomDetails = try values.decodeIfPresent(String.self, forKey: .roomDetails)
        hotel_details_key = try values.decodeIfPresent(String.self, forKey: .hotel_details_key)
        params = try values.decodeIfPresent(Params.self, forKey: .params)
        price_change = try values.decodeIfPresent(Int.self, forKey: .price_change)

    }

}
