//
//  Constants.swift
//  DoorcastRebase
//
//  Created by U Dinesh Kumar Reddy on 04/05/22.
//

import Foundation
import UIKit
import CoreData




/*SETTING USER DEFAULTS*/
let defaults = UserDefaults.standard

let loginResponseDefaultKey = "LoginResponse"
let KPlatform = "Platform"
let KPlatformValue = "iOS"
let KContentType = "Content-Type"
let KContentTypeValue = "application/x-www-form-urlencoded"
let KAccept = "Accept"
let KAcceptValue = "application/json"
let KAuthorization = "Authorization"
//let KDEVICE_ID = "DEVICE_ID"
let KAccesstoken = "Accesstoken"
let KAccesstokenValue = ""
var key = ""
let screenHeight = UIScreen.main.bounds.size.height
//var data : Data?


var BASE_URL = "https://holidayscenter.com/android_ios_webservices/index.php/"
var BASE_URL1 = "https://holidayscenter.com/android_ios_webservices/index.php/"
var loderBool = "normal"
var ExecuteOnceBool = true
let phoneNumber = "61437214457"

var currencyListArray = [SelectCurrencyData]()
var countrylist = [Country_list]()
var isvcfrom1 = String()
var profildata:ProfileUpdateData?
var menubool = Bool()
var mobilenoMaxLengthBool = false

//MARK: - COREDATE SAVE PASSENGER DETAILS
let appDelegate = UIApplication.shared.delegate as! AppDelegate
//let context = appDelegate.persistentContainer.viewContext
var sliderimagesflight = [Flight_top_destinations1]()
var sliderimageshotel = [Top_dest_hotel]()
var perfectholidays = [Perfect_holidays]()
var imgPath = String()
var currencyType = String()
var callapibool = Bool()
var countryCode = String()
var mobilenoMaxLength = Int()
var ageCategory: AgeCategory = .adult
var totalRooms = 0



//MARK: - Multicity
var fromCityCodeArray = ["Origen","Origen"]
var fromlocidArray = ["",""]
var toCitycodeArray = ["Destination","Destination"]
var tolocidArray = ["",""]
var depatureDatesArray = ["Date","Date"]
var fromCityNameArray = ["",""]
var toCityNameArray = ["",""]

//MARK: - FLIGHT RESULT
var searchid = String()
var bookingsource = String()
var bookingsourcekey = String()
var accesskey = String()
var oneWayFlights = [[J_flight_list]]()
var roundTripFlights = [[J_flight_list]]()
var multicityFlights = [MJ_flight_list]()
var fd = [[FlightDetails]]()
var travelerArray: [Traveler] = []
//var frequent_flyersArray = [Frequent_flyers]()


//MARK: - FILTERS
var prices = [String]()
var noofStopsA = [String]()
var fareTypeA = [String]()
var airlinesA = [String]()
var cancellationsTypeA = [String]()
var connectingFlightsA = [String]()
var connectingAirportA = [String]()
var departureTimeA = [String]()
var arrivalTimeA = [String]()
var startRatingArray = [String]()
var isFirstCheckinSelection = true
var totalNoofNights = String()

//Price Syummery
var AdultsTotalPrice = String()
var ChildTotalPrice = String()
var InfantTotalPrice = String()
var sub_total_adult : String?
var sub_total_child : String?
var sub_total_infant : String?

var Adults_Base_Price = String()
var Adults_Tax_Price = String()
var Childs_Base_Price = String()
var Childs_Tax_Price = String()
var Infants_Base_Price = String()
var Infants_Tax_Price = String()
var TotalPrice_API = String()
var grandTotal = String()
var promoGrandAmount = String()
var subtotal = String()
var checkTermsAndCondationStatus = false
var meallist = [Meal]()
var specialAssistancelist1 = [Meal]()
var promoinfoArray = [Promo_info]()
var promocodeDiscountValue = String()
var newGrandTotal = String()
var newGrandTotal1 = String()
var newGrandDicountTotal = String()
var totalTripCost = String()


//Booking confirmed
var bookedDate = String()
var pnrNo = String()
var bookingRefrence = String()
var bookingId = String()
var bookingStatus = String()
var voucherSummery = [Summary]()
var voucherCurrency = String()
var voucherPrice = String()
var voucherCustomerDetails = [Customer_details]()
var farepricedetails:PriceDetails?
var totalBaseFare = String()
var totaltax = String()
var hotelPromocodeBool = Bool()

//MARK: - Travellers Details

var checkOptionCountArray = [String]()
var passengertypeArray = [String]()
var genderArray = [String]()
var leadPassengerArray = [String]()
var middleNameArray = [String]()
var arrayOf_SelectedCellsAdult = [IndexPath]()
var arrayOf_SelectedCellsChild = [IndexPath]()
var arrayOf_SelectedCellsInfanta = [IndexPath]()
var totalNoOfTravellers = String()
var passportExpireDateBool = false


//HOTEL
var adtArray = [String]()
var chArray = [String]()
var hbooking_source = String()
var hsearch_id = String()
var hotelcode = String()
var rateplanecode = String()
var hotelid = String()
var isFromVCBool = Bool()
var ratekeyArray = [String]()
var htoken = String()
var htokenkey = String()
var hd:HotelDetailsModel?
var mapModelArray: [MapModel] = []
var latitudeArray: [String] = []
var longitudeArray: [String] = []
var roomPrice = String()
var room_selected = String()
var childAgesArray: [[String]] = []
var childAgesArray2: [[String]] = []
var childAgesArray3: [[String]] = []
var specialReq = [String()]
var selectedSpecialReqArray = [String()]
var hCommentsString = String()



//Filters
var filterModel = FlightFilterModel()
var sortBy: SortParameter = .nothing
var hotelfiltermodel = HotelFilterModel()
var facilityArray = [String]()
var faretypeArray = [String]()
var neighbourwoodArray = [String]()
var amenitiesArray = [String]()
var nearBylocationsArray = [String]()
var isfilterApplied = false
var starRatingFilter = String()
var starRatingInputArray = [String]()



/* URL endpoints */
struct ApiEndpoints {
    
    static let indexpage = "general/index"
    static let general_contactus_email = "general/contactus/email"
    static let general_mobile_cruise_enquiry = "general/mobile_cruise_enquiry"
    static let countrylist1 = "general/getCountrylist"
    static let mobilePreFlightSearch = "mobile_pre_flight_search"
    static let mobilelogin = "auth/mobile_login"
    static let mobileregister = "auth/mobile_register_on_light_box"
    static let mobilelogout = "auth/ajax_logout"
    static let auth_deleteuser = "auth/deleteuser"
    static let mobileforgotpassword = "auth/mobile_forgot_password"
    static let updatemobileprofile = "user/mobile_profile"
    static let getCurrencyList = "general/getCurrencyList"
    static let getairportcodelist = "ajax/get_airport_code_list"
    static let getAirlineList = "general/getAirlineList"
    static let mobilepreflightsearch = "general/mobile_pre_flight_search"
    static let getFlightDetails = "flight/getFlightDetails"
    static let preprocessbooking = "flight/pre_process_booking"
    static let mobilebooking = "flight/booking"
    static let processpassengerdetail = "flight/process_passenger_detail"
    static let prebooking = "flight/pre_booking/"
    static let prepaymentconfirmation = "flight/pre_payment_confirmation/"
    static let sendtopayment = "flight/send_to_payment/"
    static let securebooking = "flight/secure_booking/"
    
    static let upcomingbookingmobile = "flight/upcoming_booking_mobile"
    static let completedbookingmobile = "flight/completed_booking_mobile"
    static let cancelledbookingmobile = "flight/cancelled_booking_mobile"
    static let getSpecialAssistancelist = "general/getSpecialAssistance_list"
    static let getMeals_list = "general/getMeals_list"
    
    static let applypromocode = "management/promocode"
    
    //HOTEL
    static let gethotelcitylist = "ajax/get_hotel_city_list"
    static let hotel_getActiveBookingSource = "hotel/getActiveBookingSource"
    static let mobileprehotelsearch = "general/mobile_pre_hotel_search"
    static let general_ajaxHotelSearch_pagination = "general/ajaxHotelSearch_pagination"
    static let general_mobileHotelSearch = "general/mobileHotelSearch"
    static let hoteldetails = "hotel/hotel_details_gte/"
    static let hotel_get_Cancellation_new = "hotel/get_Cancellation_new"
    static let general_search_by_hotel = "general/search_by_hotel"
    
    static let hotelmobilebooking = "hotel/booking"
    static let mobilehotelprebooking = "hotel/pre_booking"
    static let hotelsecurebooking = "hotel/secure_booking"
    static let hotel_mobile_hotel_booking_details = "hotel/mobile_hotel_booking_details"
    static let general_all_map_location = "general/all_map_location"
    
    
}

/*App messages*/
struct Message {
    static let internetConnectionError = "Please check your connection and try reconnecting to internet"
    static let sessionExpired = "Your session has been expired, please login again"
}


/*USER ENTERED DETAILS DEFAULTS*/

struct UserDefaultsKeys {
    
    static var mobilecountrycode = "mobilecountrycode"
    static var tabselect = "tabselect"
    static var userLoggedIn = "userLoggedIn"
    static var loggedInStatus = "loggedInStatus"
    static var userid = "userid"
    static var username = "username"
    static var userimg = "userimg"
    static var useremail = "useremail"
    static var usermobile = "usermobile"
    static var usermobilecode = "usermobilecode"
    static var journeyType = "Journey_Type"
    static var itinerarySelectedIndex = "ItinerarySelectedIndex"
    static var selectedCurrency = "selectedCurrency"
    static var selectedCurrencyType = "selectedCurrencyType"
    static var selectedCurrencyImg = "selectedCurrencyImg"
    static var totalTravellerCount = "totalTravellerCount"
    static var select_classIndex = "select_classIndex"
    static var rselect_classIndex = "rselect_classIndex"
    static var mselect_classIndex = "mselect_classIndex"
    static var journeyCitys = "journeyCitys"
    static var journeyDates = "journeyDates"
    static var cellTag = "cellTag"
    static var flightrefundtype = "flightrefundtype"
    
    
    //ONE WAY
    static var fromCity = "fromCity"
    static var toCity = "toCity"
    static var calDepDate = "calDepDate"
    static var calRetDate = "calRetDate"
    static var adultCount = "Adult_Count"
    static var childCount = "Child_Count"
    static var hadultCount = "HAdult_Count"
    static var hchildCount = "HChild_Count"
    static var infantsCount = "Infants_Count"
    static var selectClass = "select_class"
    static var fromlocid = "from_loc_id"
    static var tolocid = "to_loc_id"
    static var fromcityname = "fromcityname"
    static var tocityname = "tocityname"
    static var nationality = "nationality"
    static var nationalitycode = "nationalitycode"
    
    
    //ROUND TRIP
//    static var rlocationcity = "rlocation_city"
//    static var rfromCity = "rfromCity"
//    static var rtoCity = "rtoCity"
//    static var rcalDepDate = "rcalDepDate"
//    static var rcalRetDate = "rcalRetDate"
//    static var radultCount = "rAdult_Count"
//    static var rchildCount = "rChild_Count"
//    static var rhadultCount = "rHAdult_Count"
//    static var rhchildCount = "rHChild_Count"
//    static var rinfantsCount = "rInfants_Count"
//    static var rselectClass = "rselect_class"
//    static var rfromlocid = "rfrom_loc_id"
//    static var rtolocid = "rto_loc_id"
//    static var rfromcityname = "rfromcityname"
//    static var rtocityname = "rtocityname"
//    static var rnationality = "rnationality"
    
    
    //MULTICITY TRIP
    static var mlocationcity = "mlocation_city"
    static var mfromCity = "mfromCity"
    static var mtoCity = "mtoCity"
    static var mcalDepDate = "mcalDepDate"
    static var mcalRetDate = "mcalRetDate"
    static var madultCount = "mAdult_Count"
    static var mchildCount = "mChild_Count"
    static var mhadultCount = "mHAdult_Count"
    static var mhchildCount = "mHChild_Count"
    static var minfantsCount = "mInfants_Count"
    static var mselectClass = "mselect_class"
    static var mfromlocid = "mfrom_loc_id"
    static var mtolocid = "mto_loc_id"
    static var mfromcityname = "mfromcityname"
    static var mtocityname = "mtocityname"
    static var mnationality = "mnationality"
    
    
    //Hotel
    static var locationcity = "location_city"
    static var locationid = "location_id"
    static var hoteladultCount = "HotelAdult_Count"
    static var hotelchildCount = "HotelChild_Count"
    static var cityid = "cityid"
    static var htravellerDetails = "htraveller_Details"
    static var roomType = "Room_Type"
    static var refundtype = "refundtype"
    static var starRatingInputArray = "starRatingInputArray"
    
    
    
    static var select = "select"
    static var checkin = "check_in"
    static var checkout = "check _out"
    static var addTarvellerDetails = "addTarvellerDetails"
    static var travellerDetails = "traveller_Details"
    static var rtravellerDetails = "rtraveller_Details"
    static var mtravellerDetails = "mtraveller_Details"
    static var roomcount = "room_count"
    static var hnationality = "hnationality"
    static var hnationalitycode = "hnationalitycode"
    static var hoteladultscount = "hotel_adults_count"
    static var hotelchildcount = "hotel_child_count"
    static var guestcount = "guestcount"
    static var selectPersons = "selectPersons"
    static var kwdprice = "kwdprice"
    static var starInputString = "starinputstring"
    
}


struct sessionMgrDefaults {
    
    static var userLoggedIn = "username"
    static var loggedInStatus = "email"
    static var globalAT = "mobile_no"
    static var Base_url = "accesstoken"
}



/*LOCAL JSON FILES*/
struct LocalJsonFiles {
    
}
