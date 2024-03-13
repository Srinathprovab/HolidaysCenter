
import Foundation

struct Params : Codable {
    let booking_source : String?
    let hotel_id : String?
    let search_id : String?
    let user_id : String?
    let resultToken : String?
    let resultIndex : String?
    let op : String?

    enum CodingKeys: String, CodingKey {

        case booking_source = "booking_source"
        case hotel_id = "hotel_id"
        case search_id = "search_id"
        case user_id = "user_id"
        case resultToken = "ResultToken"
        case resultIndex = "ResultIndex"
        case op = "op"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        hotel_id = try values.decodeIfPresent(String.self, forKey: .hotel_id)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        resultToken = try values.decodeIfPresent(String.self, forKey: .resultToken)
        resultIndex = try values.decodeIfPresent(String.self, forKey: .resultIndex)
        op = try values.decodeIfPresent(String.self, forKey: .op)
    }

}
