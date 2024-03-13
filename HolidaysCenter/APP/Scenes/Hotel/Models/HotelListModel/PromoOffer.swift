
import Foundation
struct PromoOffer : Codable {
    let status : Int?

    enum CodingKeys: String, CodingKey {

        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }

}
