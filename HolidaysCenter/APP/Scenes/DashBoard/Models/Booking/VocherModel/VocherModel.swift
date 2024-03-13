//
//  VocherModel.swift
//  BabSafar
//
//  Created by FCI on 08/12/22.
//

import Foundation


struct VocherModel : Codable {
    
    let data : VoucherData?
    let cancelltion_policy : String?
    let item : String?
    let flight_details : Flight_details?
    let price : Price?
    
    enum CodingKeys: String, CodingKey {
        
        case data = "data"
        case cancelltion_policy = "cancelltion_policy"
        case item = "item"
        case flight_details = "flight_details"
        case price = "price"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(VoucherData.self, forKey: .data)
        cancelltion_policy = try values.decodeIfPresent(String.self, forKey: .cancelltion_policy)
        item = try values.decodeIfPresent(String.self, forKey: .item)
        flight_details = try values.decodeIfPresent(Flight_details.self, forKey: .flight_details)
        price = try values.decodeIfPresent(Price.self, forKey: .price)
    }
    
}

struct VoucherData : Codable {
    let booking_details : [Booking_details]?
    let v_class : String?
    let insurance : String?
    let insurance_totalprice : [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case booking_details = "booking_details"
        case v_class = "v_class"
        case insurance = "insurance"
        case insurance_totalprice = "insurance_totalprice"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking_details = try values.decodeIfPresent([Booking_details].self, forKey: .booking_details)
        v_class = try values.decodeIfPresent(String.self, forKey: .v_class)
        insurance = try values.decodeIfPresent(String.self, forKey: .insurance)
        insurance_totalprice = try values.decodeIfPresent([String].self, forKey: .insurance_totalprice)
    }
    
}


