

import Foundation
struct Price_summary : Codable {
	let roomID : String?
	let room_name : String?
	let board_type : String?
	let room_type : String?
	let occupancy : String?
	let max_occupancy : String?
	let availrooms : String?
	let cancelPenalties : String?
	let cancelAttributes : String?
	let ratePlanCode : String?
	let tax : String?
	let roomPriceBeforeTax : String?
	let roomPrice : String?
	let publishedPriceRoundedOff : String?
	let offeredPriceRoundedOff : String?
	let agentCommission : String?
	let netCommission : String?
	let percent : String?
	let taxOnCommission : String?
	let _GST : Int?
	let publishedPrice : Int?
	let offeredPrice : Int?
	let _Markup : Int?

	enum CodingKeys: String, CodingKey {

		case roomID = "RoomID"
		case room_name = "room_name"
		case board_type = "board_type"
		case room_type = "room_type"
		case occupancy = "occupancy"
		case max_occupancy = "max_occupancy"
		case availrooms = "availrooms"
		case cancelPenalties = "CancelPenalties"
		case cancelAttributes = "CancelAttributes"
		case ratePlanCode = "RatePlanCode"
		case tax = "tax"
		case roomPriceBeforeTax = "RoomPriceBeforeTax"
		case roomPrice = "RoomPrice"
		case publishedPriceRoundedOff = "PublishedPriceRoundedOff"
		case offeredPriceRoundedOff = "OfferedPriceRoundedOff"
		case agentCommission = "AgentCommission"
		case netCommission = "NetCommission"
		case percent = "Percent"
		case taxOnCommission = "TaxOnCommission"
		case _GST = "_GST"
		case publishedPrice = "PublishedPrice"
		case offeredPrice = "OfferedPrice"
		case _Markup = "_Markup"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		roomID = try values.decodeIfPresent(String.self, forKey: .roomID)
		room_name = try values.decodeIfPresent(String.self, forKey: .room_name)
		board_type = try values.decodeIfPresent(String.self, forKey: .board_type)
		room_type = try values.decodeIfPresent(String.self, forKey: .room_type)
		occupancy = try values.decodeIfPresent(String.self, forKey: .occupancy)
		max_occupancy = try values.decodeIfPresent(String.self, forKey: .max_occupancy)
		availrooms = try values.decodeIfPresent(String.self, forKey: .availrooms)
		cancelPenalties = try values.decodeIfPresent(String.self, forKey: .cancelPenalties)
		cancelAttributes = try values.decodeIfPresent(String.self, forKey: .cancelAttributes)
		ratePlanCode = try values.decodeIfPresent(String.self, forKey: .ratePlanCode)
		tax = try values.decodeIfPresent(String.self, forKey: .tax)
		roomPriceBeforeTax = try values.decodeIfPresent(String.self, forKey: .roomPriceBeforeTax)
		roomPrice = try values.decodeIfPresent(String.self, forKey: .roomPrice)
		publishedPriceRoundedOff = try values.decodeIfPresent(String.self, forKey: .publishedPriceRoundedOff)
		offeredPriceRoundedOff = try values.decodeIfPresent(String.self, forKey: .offeredPriceRoundedOff)
		agentCommission = try values.decodeIfPresent(String.self, forKey: .agentCommission)
		netCommission = try values.decodeIfPresent(String.self, forKey: .netCommission)
		percent = try values.decodeIfPresent(String.self, forKey: .percent)
		taxOnCommission = try values.decodeIfPresent(String.self, forKey: .taxOnCommission)
		_GST = try values.decodeIfPresent(Int.self, forKey: ._GST)
		publishedPrice = try values.decodeIfPresent(Int.self, forKey: .publishedPrice)
		offeredPrice = try values.decodeIfPresent(Int.self, forKey: .offeredPrice)
		_Markup = try values.decodeIfPresent(Int.self, forKey: ._Markup)
	}

}
