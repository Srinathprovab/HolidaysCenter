

import Foundation
struct Airline_list : Codable {
	let code : String?
	let name : String?
	let value : String?

	enum CodingKeys: String, CodingKey {

		case code = "code"
		case name = "name"
		case value = "value"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		code = try values.decodeIfPresent(String.self, forKey: .code)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		value = try values.decodeIfPresent(String.self, forKey: .value)
	}

}
