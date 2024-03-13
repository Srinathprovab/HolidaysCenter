//
//  AboutusModel.swift
//  QBBYTravelApp
//
//  Created by FCI on 05/04/23.
//

import Foundation

struct AboutusModel : Codable {
    let data : [AboutusData]?
    let status : Bool?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case status = "status"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([AboutusData].self, forKey: .data)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}



struct AboutusData : Codable {
    
    
    let page_description : String?
    let page_title : String?
    let page_seo_description : String?
    let page_seo_title : String?
    let page_seo_keyword : String?

    enum CodingKeys: String, CodingKey {

        case page_description = "page_description"
        case page_title = "page_title"
        case page_seo_description = "page_seo_description"
        case page_seo_title = "page_seo_title"
        case page_seo_keyword = "page_seo_keyword"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page_description = try values.decodeIfPresent(String.self, forKey: .page_description)
        page_title = try values.decodeIfPresent(String.self, forKey: .page_title)
        page_seo_description = try values.decodeIfPresent(String.self, forKey: .page_seo_description)
        page_seo_title = try values.decodeIfPresent(String.self, forKey: .page_seo_title)
        page_seo_keyword = try values.decodeIfPresent(String.self, forKey: .page_seo_keyword)
    }

}
