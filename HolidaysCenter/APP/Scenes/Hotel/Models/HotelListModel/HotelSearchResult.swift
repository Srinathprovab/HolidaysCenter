

import Foundation
struct HotelSearchResult : Codable {
    let aPI_Cancel_date : String?
    let free_cancel_date : String?
    let search_hash : String?
    let hotelPromotionContent : String?
    let booking_source : String?
    let resultToken : String?
    let hotel_desc : String?
    let currency : String?
    let city_code : String?
    let address : String?
    //   let latitude : Int?
    let hotelMap : String?
    let hotelAmenities : String?
    let dest_code : String?
    let supplierPrice : String?
    //   let longitude : Int?
    let hotelAddress : String?
    let refundable : String?
    let hotelCategory : String?
    let trip_adv_url : String?
    let hotelPolicy : String?
    let image : String?
   // let resultIndex : Int?
    let countryname : String?
    let hotelLocation : String?
    let no_of_nights : Int?
    let name : String?
    let longitude : String?
    let ratePlanCode : String?
    let trip_rating : String?
    let hotelPromotion : Int?
    let star_rating : Int?
    let price : Double?
    let promoOffer : PromoOffer?
    let hotel_code : String?
    let api_name : String?
    let country_code : String?
    let hotel_shortdesc : String?
    let facility : [HFacility]?
    let hotelContactNo : String?
    let refund : String?
    let latitude : String?
    
    enum CodingKeys: String, CodingKey {
        
        case aPI_Cancel_date = "API_Cancel_date"
        case free_cancel_date = "Free_cancel_date"
        case search_hash = "search_hash"
        case hotelPromotionContent = "HotelPromotionContent"
        case booking_source = "booking_source"
        case resultToken = "ResultToken"
        case hotel_desc = "hotel_desc"
        case currency = "currency"
        case city_code = "city_code"
        case address = "address"
        //       case latitude = "Latitude"
        case hotelMap = "hotelMap"
        case hotelAmenities = "HotelAmenities"
        case dest_code = "dest_code"
        case supplierPrice = "SupplierPrice"
        //       case longitude = "Longitude"
        case hotelAddress = "hotelAddress"
        case refundable = "Refundable"
        case hotelCategory = "HotelCategory"
        case trip_adv_url = "trip_adv_url"
        case hotelPolicy = "HotelPolicy"
        case image = "image"
     //   case resultIndex = "ResultIndex"
        case countryname = "Countryname"
        case hotelLocation = "HotelLocation"
        case no_of_nights = "no_of_nights"
        case name = "name"
        case longitude = "longitude"
        case ratePlanCode = "RatePlanCode"
        case trip_rating = "trip_rating"
        case hotelPromotion = "HotelPromotion"
        case star_rating = "star_rating"
        case price = "price"
        case promoOffer = "PromoOffer"
        case hotel_code = "hotel_code"
        case api_name = "api_name"
        case country_code = "country_code"
        case hotel_shortdesc = "hotel_shortdesc"
        case facility = "facility"
        case hotelContactNo = "hotelContactNo"
        case refund = "refund"
        case latitude = "latitude"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        aPI_Cancel_date = try values.decodeIfPresent(String.self, forKey: .aPI_Cancel_date)
        free_cancel_date = try values.decodeIfPresent(String.self, forKey: .free_cancel_date)
        search_hash = try values.decodeIfPresent(String.self, forKey: .search_hash)
        hotelPromotionContent = try values.decodeIfPresent(String.self, forKey: .hotelPromotionContent)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        resultToken = try values.decodeIfPresent(String.self, forKey: .resultToken)
        hotel_desc = try values.decodeIfPresent(String.self, forKey: .hotel_desc)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        city_code = try values.decodeIfPresent(String.self, forKey: .city_code)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        //      latitude = try values.decodeIfPresent(Int.self, forKey: .latitude)
        hotelMap = try values.decodeIfPresent(String.self, forKey: .hotelMap)
        hotelAmenities = try values.decodeIfPresent(String.self, forKey: .hotelAmenities)
        dest_code = try values.decodeIfPresent(String.self, forKey: .dest_code)
        supplierPrice = try values.decodeIfPresent(String.self, forKey: .supplierPrice)
        //     longitude = try values.decodeIfPresent(Int.self, forKey: .longitude)
        hotelAddress = try values.decodeIfPresent(String.self, forKey: .hotelAddress)
        refundable = try values.decodeIfPresent(String.self, forKey: .refundable)
        hotelCategory = try values.decodeIfPresent(String.self, forKey: .hotelCategory)
        trip_adv_url = try values.decodeIfPresent(String.self, forKey: .trip_adv_url)
        hotelPolicy = try values.decodeIfPresent(String.self, forKey: .hotelPolicy)
        image = try values.decodeIfPresent(String.self, forKey: .image)
   //     resultIndex = try values.decodeIfPresent(Int.self, forKey: .resultIndex)
        countryname = try values.decodeIfPresent(String.self, forKey: .countryname)
        hotelLocation = try values.decodeIfPresent(String.self, forKey: .hotelLocation)
        no_of_nights = try values.decodeIfPresent(Int.self, forKey: .no_of_nights)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        ratePlanCode = try values.decodeIfPresent(String.self, forKey: .ratePlanCode)
        trip_rating = try values.decodeIfPresent(String.self, forKey: .trip_rating)
        hotelPromotion = try values.decodeIfPresent(Int.self, forKey: .hotelPromotion)
        star_rating = try values.decodeIfPresent(Int.self, forKey: .star_rating)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        promoOffer = try values.decodeIfPresent(PromoOffer.self, forKey: .promoOffer)
        hotel_code = try values.decodeIfPresent(String.self, forKey: .hotel_code)
        api_name = try values.decodeIfPresent(String.self, forKey: .api_name)
        country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
        hotel_shortdesc = try values.decodeIfPresent(String.self, forKey: .hotel_shortdesc)
        facility = try values.decodeIfPresent([HFacility].self, forKey: .facility)
        hotelContactNo = try values.decodeIfPresent(String.self, forKey: .hotelContactNo)
        refund = try values.decodeIfPresent(String.self, forKey: .refund)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
    }
    
}
