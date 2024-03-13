

import Foundation
struct Rooms : Codable {
    let room_type : String?
    let tax : Int?
    let offeredPriceRoundedOff : Int?
    let boardName : String?
    let publishedPriceRoundedOff : Int?
    let availrooms : String?
    let netCommission : Int?
    let roomID : String?
    let max_occupancy : String?
    let name : String?
    let occupancy : String?
    let token : String?
    let room_selected : Int?
    let cancelPenalties : String?
    let roomPriceBeforeTax : String?
    let taxOnCommission : Int?
    let ratePlanCode : String?
    let refund : Bool?
    let roomPrice : String?
    let percent : Int?
    let agentCommission : Int?
    let currency : String?
    let cancellationPolicies : [String]?
    let rooms : Int?
    let rateKey : String?
    
    enum CodingKeys: String, CodingKey {
        
        case room_type = "room_type"
        case tax = "tax"
        case offeredPriceRoundedOff = "OfferedPriceRoundedOff"
        case boardName = "boardName"
        case publishedPriceRoundedOff = "PublishedPriceRoundedOff"
        case availrooms = "availrooms"
        case netCommission = "NetCommission"
        case roomID = "RoomID"
        case max_occupancy = "max_occupancy"
        case name = "name"
        case occupancy = "occupancy"
        case token = "token"
        case room_selected = "room_selected"
        case cancelPenalties = "CancelPenalties"
        case roomPriceBeforeTax = "RoomPriceBeforeTax"
        case taxOnCommission = "TaxOnCommission"
        case ratePlanCode = "RatePlanCode"
        case refund = "refund"
        case roomPrice = "roomPrice"
        case percent = "Percent"
        case agentCommission = "AgentCommission"
        case currency = "currency"
        case cancellationPolicies = "cancellationPolicies"
        case rooms = "rooms"
        case rateKey = "rateKey"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        room_type = try values.decodeIfPresent(String.self, forKey: .room_type)
        tax = try values.decodeIfPresent(Int.self, forKey: .tax)
        offeredPriceRoundedOff = try values.decodeIfPresent(Int.self, forKey: .offeredPriceRoundedOff)
        boardName = try values.decodeIfPresent(String.self, forKey: .boardName)
        publishedPriceRoundedOff = try values.decodeIfPresent(Int.self, forKey: .publishedPriceRoundedOff)
        availrooms = try values.decodeIfPresent(String.self, forKey: .availrooms)
        netCommission = try values.decodeIfPresent(Int.self, forKey: .netCommission)
        roomID = try values.decodeIfPresent(String.self, forKey: .roomID)
        max_occupancy = try values.decodeIfPresent(String.self, forKey: .max_occupancy)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        occupancy = try values.decodeIfPresent(String.self, forKey: .occupancy)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        room_selected = try values.decodeIfPresent(Int.self, forKey: .room_selected)
        cancelPenalties = try values.decodeIfPresent(String.self, forKey: .cancelPenalties)
        roomPriceBeforeTax = try values.decodeIfPresent(String.self, forKey: .roomPriceBeforeTax)
        taxOnCommission = try values.decodeIfPresent(Int.self, forKey: .taxOnCommission)
        ratePlanCode = try values.decodeIfPresent(String.self, forKey: .ratePlanCode)
        refund = try values.decodeIfPresent(Bool.self, forKey: .refund)
        roomPrice = try values.decodeIfPresent(String.self, forKey: .roomPrice)
        percent = try values.decodeIfPresent(Int.self, forKey: .percent)
        agentCommission = try values.decodeIfPresent(Int.self, forKey: .agentCommission)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        cancellationPolicies = try values.decodeIfPresent([String].self, forKey: .cancellationPolicies)
        rooms = try values.decodeIfPresent(Int.self, forKey: .rooms)
        rateKey = try values.decodeIfPresent(String.self, forKey: .rateKey)
    }
    
}
