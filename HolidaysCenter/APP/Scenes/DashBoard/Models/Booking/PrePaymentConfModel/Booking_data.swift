/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Booking_data : Codable {
	let booking_details : [Booking_details]?
	let booking_itinerary_details : [Booking_itinerary_details]?
	let booking_transaction_details : [Booking_transaction_details]?
	let booking_customer_details : [Booking_customer_details]?
	let cancellation_details : String?

	enum CodingKeys: String, CodingKey {

		case booking_details = "booking_details"
		case booking_itinerary_details = "booking_itinerary_details"
		case booking_transaction_details = "booking_transaction_details"
		case booking_customer_details = "booking_customer_details"
		case cancellation_details = "cancellation_details"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		booking_details = try values.decodeIfPresent([Booking_details].self, forKey: .booking_details)
		booking_itinerary_details = try values.decodeIfPresent([Booking_itinerary_details].self, forKey: .booking_itinerary_details)
		booking_transaction_details = try values.decodeIfPresent([Booking_transaction_details].self, forKey: .booking_transaction_details)
		booking_customer_details = try values.decodeIfPresent([Booking_customer_details].self, forKey: .booking_customer_details)
		cancellation_details = try values.decodeIfPresent(String.self, forKey: .cancellation_details)
	}

}