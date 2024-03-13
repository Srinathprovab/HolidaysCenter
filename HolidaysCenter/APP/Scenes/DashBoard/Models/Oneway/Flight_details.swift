

import Foundation
struct Flight_details : Codable {
    let summary : [Summary]?
    let details : [[Summary]]?

    enum CodingKeys: String, CodingKey {

        case summary = "summary"
        case details = "details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        summary = try values.decodeIfPresent([Summary].self, forKey: .summary)
        details = try values.decodeIfPresent([[Summary]].self, forKey: .details)
    }

}
