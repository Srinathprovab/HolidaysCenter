//
//  HotelSearchResultVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 22/08/22.
//

import UIKit

class HotelSearchResultVC: BaseTableVC {
    
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var mapImg: UIImageView!
    @IBOutlet weak var mapBtn: UIButton!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterImg: UIImageView!
    @IBOutlet weak var filterpBtn: UIButton!
    
    var bookingSourceDataArrayCount = Int()
    var bookingSourceDataArray = [BookingSourceData]()
    var isFetchingData = false
    var isSearchBool = false
    var filtered = [HotelSearchResult]()
    var nationalityCode = String()
    var viewModel:HotelListViewModel?
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var hotelSearchResultArray = [HotelSearchResult]()
    var isVcFrom = String()
    var tablerow = [TableRow]()
    let refreshControl = UIRefreshControl()
    
    
    static var newInstance: HotelSearchResultVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? HotelSearchResultVC
        return vc
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        viewModel = HotelListViewModel(self)
    }
    
    func setupUI() {
        
        self.holderView.backgroundColor = .AppHolderViewColor
        nav.titlelbl.text = "Search Result"
        nav.backBtn.addTarget(self, action: #selector(backbtnAction(_:)), for: .touchUpInside)
        nav.citylbl.isHidden = false
        nav.datelbl.isHidden = false
        nav.travellerlbl.isHidden = false
        nav.editView.isHidden = false
        nav.editBtn.addTarget(self, action: #selector(modifySearchHotel(_:)), for: .touchUpInside)
        
        if screenHeight > 835 {
            navHeight.constant = 190
        }else {
            navHeight.constant = 160
        }
        
        setupLabels(lbl: titlelbl, text: "Your Session Expires In: 14:15", textcolor: .BtnTitleColor, font: .OpenSansRegular(size: 12))
        setupViews(v: mapView, radius: 4, color: .WhiteColor.withAlphaComponent(0.40))
        setupViews(v: filterView, radius: 4, color: .WhiteColor.withAlphaComponent(0.40))
        //  mapImg.image = UIImage(named: "loc1")
        // filterImg.image = UIImage(named: "filter")
        mapBtn.setTitle("", for: .normal)
        filterpBtn.setTitle("", for: .normal)
        mapBtn.addTarget(self, action: #selector(didTapOnMapviewBtn(_:)), for: .touchUpInside)
        filterpBtn.addTarget(self, action: #selector(didTapOnFilterwBtn(_:)), for: .touchUpInside)
        
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "HotelSearchResultTVCell"])
        
        
    }
    
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.2
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    @objc func modifySearchHotel(_ sender:UIButton) {
        guard let vc = ModifyHotelSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    
    @objc func backbtnAction(_ sender:UIButton) {
        guard let vc = BookHotelVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        isFromVCBool = false
        self.present(vc, animated: false)
    }
    
    @objc func didTapOnMapviewBtn(_ sender:UIButton) {
        guard let vc = MapViewVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    @objc func didTapOnFilterwBtn(_ sender:UIButton) {
        guard let vc = FilterSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        vc.filterTapKey = "sort"
        self.present(vc, animated: false)
    }
    
    
    override func didTapOnDetailsBtn(cell: HotelSearchResultTVCell) {
        callapibool = true
        hbooking_source = cell.hotelbookingsource
        guard let vc = SelectedHotelInfoVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.hotelid = cell.hotel_code
        hotelcode = cell.hotel_code
        rateplanecode = cell.rateplanecode
        vc.token = cell.resultToken
        self.present(vc, animated: false)
    }
    
}

extension HotelSearchResultVC: HotelListViewModelDelegate{
    
    func callGetActiveSourceBookingSourchAPI() {
        loderBool = "hide"
        showLoadera()
        viewModel?.CALL_GET_ACTIVE_BOOKINGSOURCE_API(dictParam: [:])
    }
    
    func getActiveBookingSourceResponse(response: ActiveBookingSourceModel) {
        // hbooking_source = response.data?[0].source_id ?? ""
        bookingSourceDataArray = response.data ?? []
        bookingSourceDataArrayCount = bookingSourceDataArray.count
        
        
        DispatchQueue.main.async {
            self.CallAPI()
        }
    }
    
    
    func CallAPI() {
        holderView.isHidden = true
        
        do {
            
            let arrJson = try JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
            let theJSONText = NSString(data: arrJson, encoding: String.Encoding.utf8.rawValue)
            print(theJSONText ?? "")
            payload1["search_params"] = theJSONText
            viewModel?.CALL_HOTEL_SEARCH_API(dictParam: payload1)
            
        }catch let error as NSError{
            print(error.description)
        }
        
    }
    
    
    func hotelSearchresponse(response: HotelSearchModel) {
        
        
        // hbooking_source = response.boo ?? ""
        hsearch_id = String(response.search_id ?? 0)
       
        
        nav.citylbl.text = response.search_params?.city
        nav.datelbl.text = "CheckIn - \(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "" , f1: "dd-MM-yyyy", f2: "dd MMM")) & CheckOut - \(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "", f1: "dd-MM-yyyy", f2: "dd MMM"))"
        nav.travellerlbl.text = "Guests- \(defaults.string(forKey: UserDefaultsKeys.guestcount) ?? "1") / Room - \(response.search_params?.rooms ?? "")"
        
        
        DispatchQueue.main.async {
            self.callGetHotelListAPI()
        }
        
    }
    
    
    
    func callGetHotelListAPI() {
        
        
        bookingSourceDataArray.forEach { i in
            
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                callgetHotelListAPI(bs: i.source_id ?? "")
            }
        }
        
        
       // callgetHotelListAPI(bs: "PTBSID0000000089")
        
    }
    
    
    func callgetHotelListAPI(bs:String) {
        payload.removeAll()
        payload["offset"] = "0"
        payload["limit"] = "10"
        payload["booking_source"] = bs
        payload["search_id"] = hsearch_id
        payload["currency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency)
    
        viewModel?.CALL_GET_HOTEL_LIST_API(dictParam: payload)
    }
    
    func hotelList(response: HotelListModel) {
        
        bookingSourceDataArrayCount -= 1
        
        
        isfilterApplied = false
        //    hotelSearchResultArray = response.data?.hotelSearchResult ?? []
        
        
        // Stop the timer if it's running
        TimerManager.shared.stopTimer()
        TimerManager.shared.startTimer(time: 900) // Set your desired total time
        
        
        
        if let newResults = response.data?.hotelSearchResult, !newResults.isEmpty {
            // Append the new data to the existing data
            hotelSearchResultArray.append(contentsOf: newResults)
            
        } else {
            // No more items to load, update UI accordingly
            print("No more items to load.")
            // You can show a message or hide a loading indicator here
        }
        
        
        if bookingSourceDataArrayCount == 0 {
            
            holderView.isHidden = true
            if hotelSearchResultArray.count <= 0 {
                gotoNoInternetScreen(keystr: "noresult")
                // holderView.isHidden = true
            }else {
                DispatchQueue.main.async {
                    self.appendValues(list: self.hotelSearchResultArray)
                }
            }
        
        }
        
    }
    
    
    
    func appendValues(list:[HotelSearchResult]) {
        
        holderView.isHidden = false
        loderBool = "hotel"
        hideLoadera()
        
        prices.removeAll()
        nearBylocationsArray.removeAll()
        faretypeArray .removeAll()
        facilityArray.removeAll()
        mapModelArray.removeAll()
        
        
        list.forEach { i in
            if let price = i.price, price > 0 {
                prices.append("\(price)")
            }
            
            if let hotelLocation = i.hotelLocation, !hotelLocation.isEmpty {
                nearBylocationsArray.append(hotelLocation)
            }
            
            if let refund = i.refund, !refund.isEmpty {
                faretypeArray.append(refund)
            }
            
            i.facility?.forEach { j in
                if let facilityName = j.name, !facilityName.isEmpty {
                    facilityArray.append(facilityName)
                }
            }
        }
        
        prices = Array(Set(prices))
        nearBylocationsArray = Array(Set(nearBylocationsArray))
        faretypeArray = Array(Set(faretypeArray))
        facilityArray = Array(Set(facilityArray))
        
        
        list.forEach { i in
            let mapModel = MapModel(
                longitude: i.longitude ?? "",
                latitude: i.latitude ?? "",
                hotelname: i.name ?? "",
                hotelimg: i.image ?? ""
            )
            mapModelArray.append(mapModel)
        }
        
        
        DispatchQueue.main.async {
            self.setupTVCells(hotelList: list)
        }
        
    }
    
    
    func setupTVCells(hotelList:[HotelSearchResult]) {
        
        
        if hotelList.count == 0 {
            tablerow.removeAll()
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
            commonTVData = tablerow
            commonTableView.reloadData()
        }else {
            
            tablerow.removeAll()
            setupLabels(lbl: subtitlelbl, text: "\(hotelList.count) Hotels Found", textcolor: .BtnTitleColor, font: .OpenSansRegular(size: 12))
            
            
            hotelList.forEach { i in
                tablerow.append(TableRow(title:i.name,
                                         subTitle: "\(i.address ?? "")",
                                         kwdprice: "\(i.currency ?? "") \(String(format: "%.2f", i.price ?? 0.0))",
                                         text: "\(i.hotel_code ?? "0")", 
                                         headerText:i.ratePlanCode,
                                         buttonTitle: i.resultToken ?? "",
                                         image: i.image,
                                         tempText: i.hotel_code ?? "",
                                         characterLimit: i.star_rating,
                                         cellType:.HotelSearchResultTVCell,
                                         questionBase: i.booking_source ?? ""))
                
            }
            
            tablerow.append(TableRow(height:50,
                                     bgColor: .AppHolderViewColor,
                                     cellType:.EmptyTVCell))
            
            
            
            commonTVData = tablerow
            commonTableView.reloadData()
        }
        
    }
    
    
}


extension HotelSearchResultVC {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        
        if indexPath.row == lastRowIndex && !isFetchingData && isfilterApplied == false {
            
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.callHotelSearchPaginationAPI()
            }
        }
        
    }
    
    
    func callHotelSearchPaginationAPI() {
        
        guard !isFetchingData else {
            return // Don't make another API call if one is already in progress
        }
        
        print("You've reached the last cell, trigger the API call.")
        isFetchingData = true
        loderBool = "normal"
        
        payload.removeAll()
        payload["search_id"] = hsearch_id
        payload["no_of_nights"] = "1"
        payload["offset"] = "\((hotelSearchResultArray.count + 10))"
        payload["limit"] = "10"
        payload["currency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency)
        
        viewModel?.CALL_HOTEL_SEARCH_PAGENATION_API(dictParam: payload)
        
    }
    
    
    func hotelPaginationList(response: HotelListModel) {
        
        isFetchingData = false // Reset the flag after API response
        loderBool = "hotel"
        
        
        
        if let newResults = response.data?.hotelSearchResult, !newResults.isEmpty {
            // Append the new data to the existing data
            hotelSearchResultArray.append(contentsOf: newResults)
            
            DispatchQueue.main.async {
                self.appendValues(list: self.hotelSearchResultArray)
            }
        } else {
            // No more items to load, update UI accordingly
            print("No more items to load.")
            // You can show a message or hide a loading indicator here
        }
    }
    
}



//MARK: - Hotel Filter By Applied
extension HotelSearchResultVC:AppliedFilters {
    func hotelFilterByApplied(minpricerange: Double, maxpricerange: Double, starRating: String, starRatingNew: [String], refundableTypeArray: [String], nearByLocA: [String], niberhoodA: [String], aminitiesA: [String]) {
        
        isSearchBool = true
        isfilterApplied = true
        
        print("====minpricerange ==== \(minpricerange)")
        print("====maxpricerange ==== \(maxpricerange)")
        print(" ==== starRating === \(starRating)")
        print(" ==== refundableTypeArray === \n\(refundableTypeArray)")
        print(" ==== nearByLocA === \n\(nearByLocA)")
        print(" ==== aminitiesA === \n\(aminitiesA)")
        
        
        let filteredArray = hotelSearchResultArray.filter { hotel in
            guard let netPrice = (hotel.price) else { return false }
            
           // let ratingMatches = hotel.star_rating == Int(starRating) || starRating.isEmpty
            let starRatingNewMatch = starRatingNew.isEmpty || starRatingNew.contains("\(hotel.star_rating ?? 0)")
            let refundableMatch = refundableTypeArray.isEmpty || refundableTypeArray.contains(hotel.refund ?? "")
            let nearByLocMatch = nearByLocA.isEmpty || nearByLocA.contains(hotel.hotelLocation ?? "")
            
            
            let facilityMatch = aminitiesA.isEmpty || aminitiesA.allSatisfy { desiredAmenity in
                hotel.facility?.contains { facility in
                    let facilityName = facility.name?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""
                    return facilityName == desiredAmenity.lowercased()
                } ?? false
            }
            
            
            return starRatingNewMatch && netPrice >= minpricerange && netPrice <= maxpricerange && refundableMatch && nearByLocMatch && facilityMatch
            
            
        }
        
        
        filtered = filteredArray
        if filtered.count == 0{
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
        }else {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
        }
        
        DispatchQueue.main.async {[self] in
            setupTVCells(hotelList: filtered)
        }
    }
    
    
    
    func filtersSortByApplied(sortBy: SortParameter) {
        
        switch sortBy {
        case .PriceLow:
            
            let sortedByPriceLowToHigh = hotelSearchResultArray.sorted { hotel1, hotel2 in
                return (Double(hotel1.price ?? 0.0) ) < (Double(hotel2.price ?? 0.0) )
            }
            
            setupTVCells(hotelList: sortedByPriceLowToHigh)
            break
            
        case .PriceHigh:
            
            let sortedByPriceLowToHigh = hotelSearchResultArray.sorted { hotel1, hotel2 in
                return (hotel1.price ?? 0.0) > (hotel2.price ?? 0.0)
            }
            setupTVCells(hotelList: sortedByPriceLowToHigh)
            break
            
        case .hotelaz:
            // Sort hotel names alphabetically
            let sortedByNameAZ = hotelSearchResultArray.sorted { $0.name?.localizedCaseInsensitiveCompare($1.name ?? "") == .orderedAscending }
            setupTVCells(hotelList: sortedByNameAZ)
            break
            
        case .hotelza:
            // Sort hotel names alphabetically
            let sortedByNameAZ = hotelSearchResultArray.sorted { $0.name?.localizedCaseInsensitiveCompare($1.name ?? "") == .orderedDescending }
            setupTVCells(hotelList: sortedByNameAZ)
            break
            
            
        case .nothing:
            setupTVCells(hotelList: hotelSearchResultArray)
            break
            
        default:
            break
        }
        
        DispatchQueue.main.async {[self] in
            // commonTableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        }
        
    }
    
    func filterByApplied(minpricerange: Double, maxpricerange: Double, noofstopsFA: [String], departureTimeFilter: [String], arrivalTimeFilter: [String], airlinesFA: [String], cancellationTypeFA: [String], connectingFlightsFA: [String], connectingAirportsFA: [String]) {
        
    }
    
}


extension HotelSearchResultVC:TimerManagerDelegate {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        TimerManager.shared.delegate = self
        
        if callapibool == true {
            holderView.isHidden = true
            callGetActiveSourceBookingSourchAPI()
        }
    }
    
    
    
    @objc func reload(notification: NSNotification){
        commonTableView.reloadData()
    }
    
    
    //MARK: - resultnil
    @objc func resultnil(notification: NSNotification){
        gotoNoInternetScreen(keystr: "noresult")
    }
    
    
    func gotoNoInternetScreen(keystr:String) {
        callapibool = true
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.key = keystr
        self.present(vc, animated: false)
    }
    
    
    @objc func offline(notificatio:UNNotification) {
        gotoNoInternetScreen(keystr: "offline")
    }
    
    
    func timerDidFinish() {
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    func updateTimer() {
        let totalTime = TimerManager.shared.totalTime
        let minutes =  totalTime / 60
        let seconds = totalTime % 60
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        
        setuplabels(lbl: titlelbl, text: "Your Session Expires In: \(formattedTime)",
                    textcolor: .BtnTitleColor,
                    font: .OpenSansRegular(size: 12),
                    align: .left)
    }
    
}
