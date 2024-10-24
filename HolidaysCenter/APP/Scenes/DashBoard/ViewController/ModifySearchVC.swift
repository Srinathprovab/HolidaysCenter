//
//  ModifySearchVC.swift
//  KuwaitWays
//
//  Created by FCI on 25/04/23.
//

import UIKit

class ModifySearchVC: BaseTableVC {
    
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
    @IBOutlet weak var btnsHolderiew: UIStackView!
    @IBOutlet weak var closeBrtn: UIButton!
    
    var fromdataArray = [[String:Any]]()
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var payload2 = [String:Any]()
    var isVcFrom = String()
    var tablerow = [TableRow]()
    static var newInstance: ModifySearchVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ModifySearchVC
        return vc
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("calreloadTV"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("tryagain"), object: nil)
        
    }
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: false)
    }
    
    
    @objc func reload(notification: NSNotification){
        commonTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        
        self.view.backgroundColor = .black.withAlphaComponent(0.50)
        self.holderView.backgroundColor = .black.withAlphaComponent(0.50)
        closeBrtn.addTarget(self, action: #selector(closeBtnAction(_:)), for: .touchUpInside)
        closeBrtn.setTitle("", for: .normal)
        
        btnsHolderiew.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 20)
        buttonsView.backgroundColor = .WhiteColor
        //  setupViews(v: buttonsView, radius: 20, color: .WhiteColor)
        setupViews(v: oneWayView, radius: 18, color: .AppBtnColor)
        setupViews(v: roundTripView, radius: 18, color: .WhiteColor)
        setupViews(v: multicityView, radius: 18, color: .WhiteColor)
        multicityView.isHidden = true
        setupLabels(lbl: oneWaylbl, text: "One Way", textcolor: .WhiteColor, font: .OpenSansRegular(size: 16))
        setupLabels(lbl: roundTriplbl, text: "Round Trip", textcolor: .SubTitleColor, font: .OpenSansRegular(size: 16))
        setupLabels(lbl: multicitylbl, text: "Multicity", textcolor: .SubTitleColor, font: .OpenSansRegular(size: 16))
        
        
        oneWayBtn.setTitle("", for: .normal)
        roundTripBtn.setTitle("", for: .normal)
        multicityBtn.setTitle("", for: .normal)
        
        buttonsView.layer.cornerRadius = 8
        buttonsView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        buttonsView.clipsToBounds = true
        
        
        commonTableView.isScrollEnabled = false
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "SearchFlightTVCell",
                                         "LabelTVCell",
                                         "HotelDealsTVCell",
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
    
    
    @objc func closeBtnAction(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    
    func appendTvcells(str:String) {
        tablerow.removeAll()
        
        tablerow.append(TableRow(key:str,cellType:.SearchFlightTVCell))
        tablerow.append(TableRow(height:10,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(height:500,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    func appendMulticityTvcells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType:.MultiCityTripTVCell))
        tablerow.append(TableRow(height:10,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(height:500,bgColor: .WhiteColor,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    
    
    @objc func backbtnAction(_ sender:UIButton) {
        dismiss(animated: false)
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
        oneWaylbl.textColor = .WhiteColor
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
        roundTriplbl.textColor = .WhiteColor
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
        multicitylbl.textColor = .WhiteColor
        
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
            //        else if defaults.string(forKey:UserDefaultsKeys.toCity) == defaults.string(forKey:UserDefaultsKeys.fromCity) {
            //            showToast(message: "Please Select Different Citys")
            //        }
            else if defaults.string(forKey:UserDefaultsKeys.calDepDate) == "" {
                showToast(message: "Please Select Departure Date")
            }else if defaults.string(forKey:UserDefaultsKeys.travellerDetails) == "Add Details" {
                showToast(message: "Add Traveller")
            }else if defaults.string(forKey:UserDefaultsKeys.selectClass) == "Add Details" {
                showToast(message: "Add Class")
            }else if isDepartureBeforeOrEqual == false {
                showToast(message: "Invalid Date")
            }else{
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
//            let formatter = DateFormatter()
//            formatter.dateFormat = "dd-MM-yyyy"
//            defaults.set(formatter.string(from: cell.depDatePicker.date), forKey: UserDefaultsKeys.calDepDate)
//            
//        }else {
//            
//            let formatter = DateFormatter()
//            formatter.dateFormat = "dd-MM-yyyy"
//            defaults.set(formatter.string(from: cell.retdepDatePicker.date), forKey: UserDefaultsKeys.calDepDate)
//            defaults.set(formatter.string(from: cell.retDatePicker.date), forKey: UserDefaultsKeys.calRetDate)
//        }
        
        commonTableView.reloadData()
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell:SearchFlightTVCell){
        self.view.endEditing(true)
    }
    
}

extension ModifySearchVC: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none // This ensures the popover is always presented as a popover and not as a fullscreen view
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        // Handle popover dismissal here if needed
        
    }
}
