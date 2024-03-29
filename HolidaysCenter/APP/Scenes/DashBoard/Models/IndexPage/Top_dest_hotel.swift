

import Foundation
struct Top_dest_hotel : Codable {
	let id : String?
	let title : String?
	let city_name : String?
	let city : String?
	let check_in : String?
	let check_out : String?
	let image : String?
	let voucher_status : String?
	let voucher : String?
	let price : String?
	let status : String?
	let created_at : String?
	let updated_at : String?
	let country_name : String?
    let hotel_destination : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case title = "title"
		case city_name = "city_name"
		case city = "city"
		case check_in = "check_in"
		case check_out = "check_out"
		case image = "image"
		case voucher_status = "voucher_status"
		case voucher = "voucher"
		case price = "price"
		case status = "status"
		case created_at = "created_at"
		case updated_at = "updated_at"
		case country_name = "country_name"
        case hotel_destination = "hotel_destination"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		check_in = try values.decodeIfPresent(String.self, forKey: .check_in)
		check_out = try values.decodeIfPresent(String.self, forKey: .check_out)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		voucher_status = try values.decodeIfPresent(String.self, forKey: .voucher_status)
		voucher = try values.decodeIfPresent(String.self, forKey: .voucher)
		price = try values.decodeIfPresent(String.self, forKey: .price)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        hotel_destination = try values.decodeIfPresent(String.self, forKey: .hotel_destination)
	}

}
