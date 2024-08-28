//
//  BookFlightVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 17/08/22.
//

import UIKit

class BookFlightVC: BaseTableVC {
    
    
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var oneWayView: UIView!
    @IBOutlet weak var oneWaylbl: UILabel!
    @IBOutlet weak var oneWayBtn: UIButton!
    @IBOutlet weak var roundTripView: UIView!
    @IBOutlet weak var roundTriplbl: UILabel!
    @IBOutlet weak var roundTripBtn: UIButton!
    @IBOutlet weak var multicityView: UIView!
    @IBOutlet weak var multicitylbl: UILabel!
    @IBOutlet weak var multicityBtn: UIButton!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var btnsHolderiew: UIStackView!
    
    
    
    var fromdataArray = [[String:Any]]()
    var payload2 = [String:Any]()
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var isVcFrom = String()
    var tablerow = [TableRow]()
    var vm:CountryListViewModel?
    let formatter = DateFormatter()
   
    static var newInstance: BookFlightVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookFlightVC
        return vc
    }
    
    
    
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: false)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        formatter.dateFormat = "dd-MM-yyyy"
        
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("calreloadTV"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(selectedEconomy(notification:)), name: NSNotification.Name("eco"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("AdvancedSearchTVCellreload"), object: nil)
        
        
        addObserveFlightDealsNotification()
    }
    
    
    @objc func reload(notification: NSNotification){
        commonTableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        //  vm = CountryListViewModel(self)
        
        // callCountryListAPI()
    }
    
    func setupUI() {
        
        loderBool = "flight"
        callapibool = false
        self.holderView.backgroundColor = .WhiteColor
        
        setuplabels(lbl: nav.titlelbl, text: "Book Flight", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 20), align: .center)
        nav.backBtn.addTarget(self, action: #selector(backbtnAction(_:)), for: .touchUpInside)
        nav.contentView.backgroundColor = .WhiteColor
        nav.titlelbl.textColor = .AppLabelColor
        nav.backBtn.tintColor = UIColor.AppLabelColor
        nav.bg.isHidden = true
        if screenHeight > 835 {
            navHeight.constant = 140
        }else {
            navHeight.constant = 110
        }
        
        
        btnsHolderiew.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 20)
        buttonsView.backgroundColor = .WhiteColor
        //  setupViews(v: buttonsView, radius: 20, color: .WhiteColor)
        setupViews(v: oneWayView, radius: 18, color: .AppBtnColor)
        setupViews(v: roundTripView, radius: 18, color: .WhiteColor)
        setupViews(v: multicityView, radius: 18, color: .WhiteColor)
        multicityView.isHidden = true
        setupLabels(lbl: oneWaylbl, text: "One Way", textcolor: .BtnTitleColor, font: .OpenSansRegular(size: 16))
        setupLabels(lbl: roundTriplbl, text: "Round Trip", textcolor: .SubTitleColor, font: .OpenSansRegular(size: 16))
        setupLabels(lbl: multicitylbl, text: "Multicity", textcolor: .SubTitleColor, font: .OpenSansRegular(size: 16))
        
        
        oneWayBtn.setTitle("", for: .normal)
        roundTripBtn.setTitle("", for: .normal)
        multicityBtn.setTitle("", for: .normal)
        
        commonTableView.backgroundColor = .AppBGcolor
        //  commonTableView.isScrollEnabled = false
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "SearchFlightTVCell",
                                         "DashboardDealsTitleTVCell",
                                         "HotelDealsTVCell",
                                         "AddCityTVCell",
                                         "MultiCityTripTVCell"])
        
        appendTvcells(str: "oneway")
        if let selectedJourneyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if selectedJourneyType == "multicity" {
                setupMulticity()
            }else if selectedJourneyType == "circle" {
                setupRoundTrip()
            }else {
                setupOneWay()
            }
        }
        
        
        
    }
    
    
    func appendTvcells(str:String) {
        tablerow.removeAll()
        
        tablerow.append(TableRow(key:str,cellType:.SearchFlightTVCell))
        tablerow.append(TableRow(height:10,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"BEST DEALS FLIGHTS ",key: "deals", text:imgPath, height:50,cellType:.DashboardDealsTitleTVCell))
        tablerow.append(TableRow(height:10,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(key1:"flight",cellType:.HotelDealsTVCell))
        tablerow.append(TableRow(height:30,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    func appendMulticityTvcells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType:.AddCityTVCell))
        tablerow.append(TableRow(height:10,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Top Flight Destinations",key: "deals", text:imgPath, height:50,cellType:.DashboardDealsTitleTVCell))
        tablerow.append(TableRow(height:18,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(key1:"flight",cellType:.HotelDealsTVCell))
        tablerow.append(TableRow(height:30,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    override func didTapOnAddCityBtn(cell: AddCityTVCell) {
        commonTableView.reloadData()
    }
    
    override func didTapOnAdvanceSearchBtn(cell:AddCityTVCell){
        commonTableView.reloadData()
    }
    
    
    
    @objc func backbtnAction(_ sender:UIButton) {
        guard let vc = DBTabbarController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        callapibool = true
        present(vc, animated: false)
        
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.2
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    
    @IBAction func didTapOnOneWayBtn(_ sender: Any) {
        setupOneWay()
    }
    
    @IBAction func didTapOnRoundTripBtn(_ sender: Any) {
        setupRoundTrip()
    }
    
    
    @IBAction func didTapOnMulticityBtn(_ sender: Any) {
        setupMulticity()
    }
    
    func setupOneWay() {
        oneWaylbl.textColor = .BtnTitleColor
        roundTriplbl.textColor = .SubTitleColor
        multicitylbl.textColor = .SubTitleColor
        
        oneWayView.backgroundColor = .AppBtnColor
        roundTripView.backgroundColor = .WhiteColor
        multicityView.backgroundColor = .WhiteColor
        
        defaults.set("oneway", forKey: UserDefaultsKeys.journeyType)
        appendTvcells(str: "oneway")
    }
    
    
    func setupRoundTrip() {
        oneWaylbl.textColor = .SubTitleColor
        roundTriplbl.textColor = .BtnTitleColor
        multicitylbl.textColor = .SubTitleColor
        
        oneWayView.backgroundColor = .WhiteColor
        roundTripView.backgroundColor = .AppBtnColor
        multicityView.backgroundColor = .WhiteColor
        
        defaults.set("circle", forKey: UserDefaultsKeys.journeyType)
        appendTvcells(str: "roundtrip")
    }
    
    
    func setupMulticity() {
        oneWaylbl.textColor = .SubTitleColor
        roundTriplbl.textColor = .SubTitleColor
        multicitylbl.textColor = .BtnTitleColor
        
        oneWayView.backgroundColor = .WhiteColor
        roundTripView.backgroundColor = .WhiteColor
        multicityView.backgroundColor = .AppBtnColor
        
        defaults.set("multicity", forKey: UserDefaultsKeys.journeyType)
        appendMulticityTvcells()
    }
    
    
    
    override func didTapOnFromCity(cell: HolderViewTVCell) {
        gotoSelectCityVC(str: "From", tokey: "Tooo")
    }
    
    override func didTapOnToCity(cell: HolderViewTVCell) {
        gotoSelectCityVC(str: "To", tokey: "frommm")
    }
    
    override func didTapOnSelectDepDateBtn(cell: DualViewTVCell) {
        gotoCalenderVC()
    }
    override func didTapOnSelectRepDateBtn(cell: DualViewTVCell) {
        gotoCalenderVC()
    }
    
    
    override func didTapOnAddTravellerEconomy(cell:AddCityTVCell){
        gotoAddTravelerVC()
    }
    
    override func didTapOnMultiCityTripSearchFlight(cell:AddCityTVCell){
        CALLMULTICITYAPI()
    }
    
    override func didTapOnNationalityBtn(cell:AddCityTVCell){
        gotoNationalityVC()
    }
    
    override func didTapOnAirlinesBtnAction(cell:AddCityTVCell){
        callPopoverVC1(cell: cell, key: "air")
    }
    
    override func didTapOnselectClassBtnAction(cell:AddCityTVCell){
        callPopoverVC1(cell: cell, key: "eco")
    }
    
    
    func gotoSelectCityVC(str:String,tokey:String) {
        guard let vc = SelectFromCityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.titleStr = str
        vc.keyStr = "flight"
        vc.tokey = tokey
        self.present(vc, animated: true)
    }
    
    func gotoCalenderVC() {
        guard let vc = Calvc.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    func gotoAddTravelerVC() {
        guard let vc = TravellerEconomyVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    override func didTapOnAddRooms(cell:HolderViewTVCell){
        
    }
    
    
    
    func gotoSearchFlightResultVC(input:[String:Any]) {
        defaults.set(false, forKey: "flightfilteronce")
        guard let vc = SearchFlightResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.payload = input
        callapibool = true
        self.present(vc, animated: true)
    }
    
    
    
    
    override func didTapOnSearchFlightsBtn(cell:SearchFlightTVCell) {
        
        payload.removeAll()
        NotificationCenter.default.post(name: NSNotification.Name("resetallFilters"), object: nil)
        
        DispatchQueue.main.async {
            TimerManager.shared.stopTimer()
        }
        
        
        let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
        if journyType == "oneway" {
            payload["return"] = ""
        }else {
            payload["return"] = defaults.string(forKey: UserDefaultsKeys.calRetDate)
            
        }
        payload["trip_type"] = defaults.string(forKey: UserDefaultsKeys.journeyType)
        payload["adult"] = defaults.string(forKey: UserDefaultsKeys.adultCount)
        payload["child"] = defaults.string(forKey: UserDefaultsKeys.childCount)
        payload["infant"] = defaults.string(forKey: UserDefaultsKeys.infantsCount)
        payload["sector_type"] = "international"
        payload["from"] = defaults.string(forKey: UserDefaultsKeys.fromCity)
        payload["from_loc_id"] = defaults.string(forKey: UserDefaultsKeys.fromlocid)
        payload["to"] = defaults.string(forKey: UserDefaultsKeys.toCity)
        payload["to_loc_id"] = defaults.string(forKey: UserDefaultsKeys.tolocid)
        payload["depature"] = defaults.string(forKey: UserDefaultsKeys.calDepDate)
        
        payload["carrier"] = ""
        payload["psscarrier"] = defaults.string(forKey: UserDefaultsKeys.nationalitycode) ?? "ALL"
        payload["v_class"] = defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "Economy"
        payload["search_flight"] = "Search"
        payload["search_source"] = "Mobile"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        payload["currency"] = defaults.string(forKey:UserDefaultsKeys.selectedCurrency) ?? "KWD"
        if journyType == "oneway" {
            let departureDate = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? ""
            let returnDate = defaults.string(forKey: UserDefaultsKeys.calRetDate) ?? ""
            
            let isDepartureBeforeOrEqual = isDepartureBeforeOrEqualReturn(departureDateString: departureDate, returnDateString: returnDate)
            
            
            if defaults.string(forKey:UserDefaultsKeys.fromCity) == "" {
                showToast(message: "Please Select From City")
            }else if defaults.string(forKey:UserDefaultsKeys.toCity) == "" {
                showToast(message: "Please Select To City")
            }
            //        else if defaults.string(forKey:UserDefaultsKeys.toCity) == defaults.string(forKey:UserDefaultsKeys.fromCity) {
            //            showToast(message: "Please Select Different Citys")
            //        }
            else if defaults.string(forKey:UserDefaultsKeys.calDepDate) == "" {
                showToast(message: "Please Select Departure Date")
            }else if defaults.string(forKey:UserDefaultsKeys.travellerDetails) == "Add Details" {
                showToast(message: "Add Traveller")
            }else if defaults.string(forKey:UserDefaultsKeys.selectClass) == "Add Details" {
                showToast(message: "Add Class")
            }else{
                gotoSearchFlightResultVC(input: payload)
            }
        }else {
            let departureDate = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? ""
            let returnDate = defaults.string(forKey: UserDefaultsKeys.calRetDate) ?? ""
            
            let isDepartureBeforeOrEqual = isDepartureBeforeOrEqualReturn(departureDateString: departureDate, returnDateString: returnDate)
            
            
            if defaults.string(forKey:UserDefaultsKeys.fromCity) == "" {
                showToast(message: "Please Select From City")
            }else if defaults.string(forKey:UserDefaultsKeys.toCity) == "" {
                showToast(message: "Please Select To City")
            }
            
//            else if  let checkinDate = defaults.string(forKey: UserDefaultsKeys.calDepDate),
//                      let checkoutDate = defaults.string(forKey: UserDefaultsKeys.calRetDate),
//                      let checkin = formatter.date(from: checkinDate),
//                      let checkout = formatter.date(from: checkoutDate),
//                      checkin > checkout {
//                showToast(message: "Invalid Date")
//            }
            //        else if defaults.string(forKey:UserDefaultsKeys.toCity) == defaults.string(forKey:UserDefaultsKeys.fromCity) {
            //            showToast(message: "Please Select Different Citys")
            //        }
            else if defaults.string(forKey:UserDefaultsKeys.calDepDate) == "" {
                showToast(message: "Please Select Departure Date")
            }else if defaults.string(forKey:UserDefaultsKeys.travellerDetails) == "Add Details" {
                showToast(message: "Add Traveller")
            }else if defaults.string(forKey:UserDefaultsKeys.selectClass) == "Add Details" {
                showToast(message: "Add Class")
            }
            else if isDepartureBeforeOrEqual == false {
                showToast(message: "Invalid Date")
            }
            else{
                gotoSearchFlightResultVC(input: payload)
            }
            
        }
        
    }
    
    
    //MARK: -CALL MULTICITY TRIP API
    func CALLMULTICITYAPI() {
        
        payload.removeAll()
        payload2.removeAll()
        fromdataArray.removeAll()
        
        DispatchQueue.main.async {
            TimerManager.shared.stopTimer()
        }
        
        for (index,_) in fromCityNameArray.enumerated() {
            
            payload2["from"] = fromCityNameArray[index]
            payload2["from_loc_id"] = fromlocidArray[index]
            payload2["to"] = toCityNameArray[index]
            payload2["to_loc_id"] = tolocidArray[index]
            payload2["depature"] = depatureDatesArray[index]
            
            fromdataArray.append(payload2)
        }
        
        payload["sector_type"] = "international"
        payload["trip_type"] = defaults.string(forKey:UserDefaultsKeys.journeyType)
        payload["adult"] = defaults.string(forKey:UserDefaultsKeys.madultCount)
        payload["child"] = defaults.string(forKey:UserDefaultsKeys.mchildCount)
        payload["infant"] = defaults.string(forKey:UserDefaultsKeys.minfantsCount)
        payload["checkbox-group"] = "on"
        payload["search_flight"] = "Search"
        payload["anNonstopflight"] = "1"
        payload["carrier"] = ""
        payload["psscarrier"] = "ALL"
        payload["remngwd"] = defaults.string(forKey:UserDefaultsKeys.mselectClass) ?? "Economy"
        payload["v_class"] = defaults.string(forKey:UserDefaultsKeys.mselectClass) ?? "Economy"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        payload["currency"] = defaults.string(forKey:UserDefaultsKeys.selectedCurrency) ?? "KWD"
        payload["placeDetails"] = fromdataArray
        
        var showToastMessage: String? = nil
        
        for cityName in fromCityNameArray {
            if cityName == "From" {
                showToastMessage = "Please Select Origin"
                break
            }
        }
        
        if showToastMessage == nil {
            for cityName in toCityNameArray {
                if cityName == "To" {
                    showToastMessage = "Please Select Destination"
                    break
                }
            }
        }
        
        if showToastMessage == nil {
            for date in depatureDatesArray {
                if date == "Date" {
                    showToastMessage = "Please Select Date"
                    break
                }
            }
        }
        
        
        
        if showToastMessage == nil {
            if depatureDatesArray != depatureDatesArray.sorted() {
                showToastMessage = "Please Select Dates in Ascending Order"
            } else if depatureDatesArray.count == 2 && depatureDatesArray[0] == depatureDatesArray[1] {
                showToastMessage = "Please Select Different Dates"
            }
        }
        
        
        
        if let message = showToastMessage {
            showToast(message: message)
        } else {
            gotoSearchFlightResultVC(input: payload)
        }
        
        
    }
    
    override func didTapOnFromBtn(cell:MulticityFromToTVCell){
        gotoSelectCityVC(str: "From", tokey: "")
    }
    override func didTapOnToBtn(cell:MulticityFromToTVCell){
        gotoSelectCityVC(str: "To", tokey: "")
    }
    override func didTapOndateBtn(cell:MulticityFromToTVCell){
        gotoCalenderVC()
    }
    override func didTapOnCloseBtn(cell:MulticityFromToTVCell){
        print("didTapOnCloseBtn")
    }
    override func didTapOnAddTravellerEconomy(cell:HolderViewTVCell){
        gotoAddTravelerVC()
    }
    
    override func didTapOnMultiCityTripSearchFlight(cell:ButtonTVCell){
        gotoSearchFlightResultVC(input: payload)
    }
    
    override func didTapOnAddTravelerEconomy(cell:HolderViewTVCell){
        gotoAddTravelerVC()
    }
    
    
    override func didTapOnNationalityBtnAction(cell:NatinalityTVCell) {
        gotoNationalityVC()
    }
    
    
    func gotoNationalityVC(){
        guard let vc = NationalityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    
    override func didTapOnAirlinesSelectBtnAction(cell:AdvancedSearchTVCell) {
        // callPopoverVC(cell: cell, key: "air")
        gotoNationalityVC()
    }
    
    override func didTapOnEconomySelectBtnAction(cell:AdvancedSearchTVCell) {
        callPopoverVC(cell: cell, key: "eco")
        
    }
    
    var overlayView: UIView?
    
    func callPopoverVC(cell:AdvancedSearchTVCell,key:String) {
        
        var popoverContent = (self.storyboard?.instantiateViewController(withIdentifier: "PopoverVC")) as! PopoverVC
        var nav = UINavigationController(rootViewController: popoverContent)
        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        var popover = nav.popoverPresentationController
        popoverContent.preferredContentSize = CGSize(width: cell.btnsView.frame.width, height: 200)
        popoverContent.key = key
        popover?.delegate = self
        if key == "eco" {
            popover?.sourceView = cell.economyView
            popover?.sourceRect = cell.economyView.bounds
        }else {
            popover?.sourceView = cell.AirlinesView
            popover?.sourceRect = cell.AirlinesView.bounds
        }
        popover?.permittedArrowDirections = [.any]
        
        self.present(nav, animated: true, completion: nil)
    }
    
    
    
    func callPopoverVC1(cell:AddCityTVCell,key:String) {
        
        var popoverContent = (self.storyboard?.instantiateViewController(withIdentifier: "PopoverVC")) as! PopoverVC
        var nav = UINavigationController(rootViewController: popoverContent)
        nav.modalPresentationStyle = UIModalPresentationStyle.popover
        var popover = nav.popoverPresentationController
        popoverContent.preferredContentSize = CGSize(width: cell.advanceSearchView.frame.width, height: 200)
        popoverContent.key = key
        popover?.delegate = self
        if key == "eco" {
            popover?.sourceView = cell.economyView
            popover?.sourceRect = cell.economyView.bounds
        }else {
            popover?.sourceView = cell.airlinesView
            popover?.sourceRect = cell.airlinesView.bounds
        }
        popover?.permittedArrowDirections = [.any]
        
        self.present(nav, animated: true, completion: nil)
    }
    
    
    
    
    @objc func selectedEconomy(notification: NSNotification){
        // Handle popover dismissal here if needed
        UIView.animate(withDuration: 0.3, animations: {
            self.overlayView?.alpha = 0
        }) { _ in
            self.overlayView?.removeFromSuperview()
            self.overlayView = nil
        }
    }
    
    
    //MARK: - donedatePicker cancelDatePicker
    
    override func donedatePicker(cell:SearchFlightTVCell){
        
//        let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
//        if journyType == "oneway" {
//           
//            defaults.set(formatter.string(from: cell.depDatePicker.date), forKey: UserDefaultsKeys.calDepDate)
//           
//        }else {
//            
//          
//            defaults.set(formatter.string(from: cell.retdepDatePicker.date), forKey: UserDefaultsKeys.calDepDate)
//            defaults.set(formatter.string(from: cell.retDatePicker.date), forKey: UserDefaultsKeys.calRetDate)
//            
//        }
//        
        
        commonTableView.reloadData()
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell:SearchFlightTVCell){
        self.view.endEditing(true)
    }
    
    @IBAction func didTapOnWhatsappBtnAction(_ sender: Any) {
        let alert = UIAlertController(title: "WhatsApp Account Found", message: "Would you like to continue to chat with \(phoneNumber)?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            self.openWhatsApp()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func openWhatsApp1() {
          // Replace with the phone number you want to open chat with
          
          // Check if WhatsApp is installed
          guard let whatsappURL = URL(string: "whatsapp://send?phone=\(phoneNumber)") else {
              return
          }

          if UIApplication.shared.canOpenURL(whatsappURL) {
              // Open WhatsApp with the specified phone number
              UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
          } else {
              // WhatsApp is not installed, handle accordingly (e.g., show alert)
              print("WhatsApp is not installed.")
          }
      }
    
     func openWhatsApp() {
            let urlString = "https://wa.me/\(phoneNumber)"
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL) {
                    UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                } else {
                    print("WhatsApp is not installed.")
                    // Handle case where WhatsApp is not installed
                }
            }
        }
    
    
}



//MARK: - adaptivePresentationStyle
extension BookFlightVC: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none // This ensures the popover is always presented as a popover and not as a fullscreen view
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        // Handle popover dismissal here if needed
        
    }
}


//MARK: - flightdealstap
extension BookFlightVC {
    
    func addObserveFlightDealsNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(flightdealstap), name: Notification.Name("flightdealstap"), object: nil)
    }
    
    
    @objc func flightdealstap(ns:NSNotification) {
        if let userinfo = ns.userInfo as? [String:Any] {
            
            payload.removeAll()
            NotificationCenter.default.post(name: NSNotification.Name("resetallFilters"), object: nil)
            defaults.set("Flight", forKey: UserDefaultsKeys.tabselect)
            
            
            
            defaults.set(userinfo["from"] as? String, forKey: UserDefaultsKeys.fromCity)
            defaults.set(userinfo["from_loc_id"] as? String, forKey: UserDefaultsKeys.fromlocid)
            defaults.set(userinfo["to"] as? String, forKey: UserDefaultsKeys.toCity)
            defaults.set(userinfo["to_loc_id"] as? String, forKey: UserDefaultsKeys.tolocid)
            
            
            defaults.set("\(userinfo["from_city_name"] as? String ?? "") (\(userinfo["from_city_loc"] as? String ?? ""))", forKey: UserDefaultsKeys.fromcityname)
            defaults.set("\(userinfo["to_city_name"] as? String ?? "") (\(userinfo["to_city_loc"] as? String ?? ""))", forKey: UserDefaultsKeys.tocityname)
            defaults.set(convertDateFormat(inputDate: userinfo["depature"] as? String ?? "", f1: "yyyy-MM-dd", f2: "dd-MM-yyyy"), forKey: UserDefaultsKeys.calDepDate)
            
            if let returnDate = userinfo["return"] as? String {
                if returnDate.isEmpty == false || returnDate == "" {
                    defaults.set(convertDateFormat(inputDate: userinfo["return"] as? String ?? "", f1: "yyyy-MM-dd", f2: "dd-MM-yyyy"), forKey: UserDefaultsKeys.calRetDate)
                }
            }
            
            
            
            defaults.set("Economy", forKey: UserDefaultsKeys.selectClass)
            defaults.set("1", forKey: UserDefaultsKeys.adultCount)
            defaults.set("0", forKey: UserDefaultsKeys.childCount)
            defaults.set("0", forKey: UserDefaultsKeys.infantsCount)
            defaults.set("1", forKey: UserDefaultsKeys.totalTravellerCount)
            
            let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1") Traveller - \(defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "Economy")"
            defaults.set(totaltraverlers, forKey: UserDefaultsKeys.travellerDetails)
            
            
            DispatchQueue.main.async {
                TimerManager.shared.stopTimer()
            }
            
            
            payload["trip_type"] = userinfo["trip_type"] as? String
            payload["adult"] = "1"
            payload["child"] = "0"
            payload["infant"] = "0"
            payload["sector_type"] = "international"
            payload["from"] = userinfo["from"] as? String
            payload["from_loc_id"] = userinfo["from_loc_id"] as? String
            payload["to"] = userinfo["to"] as? String
            payload["to_loc_id"] = userinfo["to_loc_id"] as? String
            payload["depature"] = convertDateFormat(inputDate: userinfo["depature"] as? String ?? "", f1: "yyyy-MM-dd", f2: "dd-MM-yyyy")
            payload["return"] = convertDateFormat(inputDate: userinfo["return"] as? String ?? "", f1: "yyyy-MM-dd", f2: "dd-MM-yyyy")
            payload["carrier"] = ""
            payload["psscarrier"] = "ALL"
            payload["v_class"] = "Economy"
            payload["search_flight"] = "Search"
            payload["search_source"] = "search"
            payload["user_id"] = userinfo["user_id"] as? String
            payload["currency"] = defaults.string(forKey:UserDefaultsKeys.selectedCurrency) ?? "KWD"
            
            gotoSearchFlightResultVC(input: payload)
            
        }
    }
    
}
