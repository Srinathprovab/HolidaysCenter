

import Foundation
struct Token : Codable {
	let roomID : String?
	let room_name : String?
	let price : Price?
	let status : Int?

	enum CodingKeys: String, CodingKey {

		case roomID = "RoomID"
		case room_name = "room_name"
		case price = "Price"
		case status = "status"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		roomID = try values.decodeIfPresent(String.self, forKey: .roomID)
		room_name = try values.decodeIfPresent(String.self, forKey: .room_name)
		price = try values.decodeIfPresent(Price.self, forKey: .price)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
	}

}
