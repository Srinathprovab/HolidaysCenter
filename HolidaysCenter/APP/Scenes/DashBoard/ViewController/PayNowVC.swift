//
//  PayNowVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 18/08/22.
//

import UIKit
import CoreData

class PayNowVC: BaseTableVC, PreProcessBookingViewModelDelegate, TimerManagerDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var viewFlightsBtnView: UIView!
    @IBOutlet weak var viewFlightlbl: UILabel!
    @IBOutlet weak var viewFlightsBtn: UIButton!
    @IBOutlet weak var bookNowHolderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var bookNowView: UIView!
    @IBOutlet weak var bookNowlbl: UILabel!
    @IBOutlet weak var bookNowBtn: UIButton!
    
    static var newInstance: PayNowVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? PayNowVC
        return vc
    }
    var email = String()
    var mobile = String()
    var countryCode = String()
    var billingCountryCode = String()
    var billingCountryName = String()
    var tmpFlightPreBookingId = String()
    
    var fnameA = [String]()
    var passengertypeA = [String]()
    var title2A = [String]()
    var mnameA = [String]()
    var lnameA = [String]()
    var dobA = [String]()
    var passportNoA = [String]()
    var countryCodeA = [String]()
    var genderA = [String]()
    var passportexpiryA = [String]()
    var passportissuingcountryA = [String]()
    var middleNameA = [String]()
    var leadPassengerA = [String]()
    var activepaymentoptions = String()
    var tokenkey1 = String()
    
    var tokenkey = String()
    let datePicker = UIDatePicker()
    var tablerow = [TableRow]()
    var bool = true
    var name = String()
    var flighttotelCount = 0
    var hoteltotelCount = 0
    var adultsCount = Int()
    var childCount = Int()
    var infantsCount = Int()
    var positionsCount = 0
    
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var secureapidonebool = false
    var hbookingToken = String()
    var hbookingTokenkey = String()
  
    var vm:PreProcessBookingViewModel?
    var vm1:HotelMBViewModel?
    var details  = [NSFetchRequestResult]()
    
    var payemail = String()
    var paymobile = String()
    var paymobilecountrycode = String()
    var nationalityCode = String()
    var accesskeytp  = String()
    var room_token = String()
    var htokenkey = String()
    var htoken = String()
    var hoteldetails = String()
    var roomDetails = String()
    var roomselected = String()
    var hpayableAmount = String()
    
    var pre_booking_params:Pre_booking_params?
    var promocodeBool = false
    var promocodeValue = String()
    var promocodeString = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        vm = PreProcessBookingViewModel(self)
        vm1 = HotelMBViewModel(self)
        
        
        setupInitialValues()
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    func setupUI() {
        
        if screenHeight > 835 {
            navHeight.constant = 190
        }else {
            navHeight.constant = 150
        }
        
        holderView.backgroundColor = .WhiteColor
        nav.titlelbl.text = "Booking Details"
        nav.backBtn.addTarget(self, action: #selector(gotoBackScreen), for: .touchUpInside)
        nav.citylbl.isHidden = false
        nav.datelbl.isHidden = false
        nav.travellerlbl.isHidden = false
        
        
        viewFlightsBtnView.backgroundColor = .clear
        viewFlightsBtnView.addCornerRadiusWithShadow(color: .clear, borderColor: HexColor("#C5A47E"), cornerRadius: 15)
        viewFlightlbl.textColor = .BtnTitleColor
        viewFlightlbl.font = UIFont.poppinsRegular(size: 14)
        viewFlightsBtn.setTitle("", for: .normal)
        
        setupViews(v: bookNowHolderView, radius: 0, color: .WhiteColor)
        setupViews(v: bookNowView, radius: 6, color: .AppNavBackColor)
        bookNowView.layer.cornerRadius = 20
        bookNowView.clipsToBounds = true
        setupLabels(lbl: titlelbl, text: grandTotal, textcolor: .AppLabelColor, font: .OpenSansMedium(size: 20))
        setupLabels(lbl: bookNowlbl, text: "PAY NOW", textcolor: .BtnTitleColor, font: .OpenSansMedium(size: 16))
        bookNowBtn.setTitle("", for: .normal)
        
        
        commonTableView.registerTVCells(["TDetailsLoginTVCell",
                                         "EmptyTVCell",
                                         "FlightPromocodeTVCell",
                                         "PriceSummaryTVCell",
                                         "checkOptionsTVCell",
                                         "AddTravellersDetailsTVCell",
                                         "PriceLabelsTVCell",
                                         "ContactInformationTVCell",
                                         "AddDeatilsOfTravellerTVCell",
                                         "TotalNoofTravellerTVCell",
                                         "AcceptTermsAndConditionTVCell",
                                         "HotelPurchaseSummaryTVCell",
                                         "SpecialRequestTVCell",
                                         "AddDeatilsOfGuestTVCell",
                                         "FlightPriceSummeryTVCell"])
        
        
        
        
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
    
    
    //MARK: - didTapOnViewFlightDetails
    @objc func didTapOnViewFlightDetails(_ sender:UIButton) {
        guard let vc = ViewFlightDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnViewHotelDetails
    @objc func didTapOnViewHotelDetails(_ sender:UIButton) {
        guard let vc = ViewHotelDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        isFromVCBool = true
        self.present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnLoginBtn
    override func didTapOnLoginBtn(cell: TDetailsLoginTVCell) {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.isvcfrom = "paynow"
        self.present(vc, animated: true)
    }
    
    //MARK: - didTapOnApplyBtn FlightPromocodeTVCell
   
    override func didTapOnExpandViewBtnAction(cell:FlightPromocodeTVCell){
        commonTableView.reloadData()
    }
    
    
    override func didTapOnApplyBtn(cell:FlightPromocodeTVCell){
        
        if cell.promocodeTF.text?.isEmpty == false {
            callPromocodeAPI(promocodeStr: cell.promocodeTF.text ?? "")
        }else {
            showToast(message: "Enter PromoCode To Apply")
        }
    }
    
    
    
    func callPromocodeAPI(promocodeStr:String) {
        payload.removeAll()
        payload["moduletype"] = "flight"
        payload["promocode"] = promocodeStr
        payload["total_amount_val"] = promoGrandAmount
        payload["convenience_fee"] = "0"
        payload["email"] = payemail
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        vm?.CALL_APPLY_PROMOCODE_API(dictParam: payload)
    }
    
    
    
    func promocodeResult(response: ApplyPromocodeModel) {
        
        if response.status == 1 {
            promocodeBool = true
            promocodeValue = response.total_amount_val ?? ""
            promocodeDiscountValue = response.value ?? ""
            promocodeString = response.promocode ?? ""
            grandTotal = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? ""):\(response.total_amount_val ?? "")"
            totalTripCost = response.total_amount_val ?? ""
            setuplabels(lbl: titlelbl, text: grandTotal, textcolor: .AppLabelColor, font: .OpenSansMedium(size: 20), align: .left)
            NotificationCenter.default.post(name: NSNotification.Name("promocodeapply"), object: nil)
            
            DispatchQueue.main.async {[self] in
                commonTableView.reloadData()
            }
            
        }else {
            showToast(message: "Invalid Promo Code")
            promocodeBool = false
        }
        
    }
    
    //MARK: - didTapOnRefundBtn
    override func didTapOnRefundBtn(cell: PriceSummaryTVCell) {
        print("didTapOnRefundBtn")
    }
    
    
    //MARK: - didTapOnCountryCodeBtn
    override func didTapOnCountryCodeBtn(cell: ContactInformationTVCell) {
        self.billingCountryCode = cell.billingCountryCode
        self.billingCountryName = cell.billingCountryName
        self.countryCode = cell.countryCodeLbl.text ?? ""
        self.paymobilecountrycode = cell.countryCodeLbl.text ?? ""
    }
    
    
    //MARK: - didTapOnDropDownBtn
    override func didTapOnDropDownBtn(cell: ContactInformationTVCell) {
        self.billingCountryCode = cell.billingCountryCode
        self.billingCountryName = cell.billingCountryName
        self.countryCode = cell.countryCodeLbl.text ?? ""
        self.paymobilecountrycode = cell.countryCodeLbl.text ?? ""
    }
    
    
    //MARK: - editingTextField
    override func editingTextField(tf:UITextField){
        
        switch tf.tag {
        case 111:
            self.payemail = tf.text ?? ""
            break
            
        case 222:
            self.paymobile = tf.text ?? ""
            break
            
            
        default:
            break
        }
    }
    
    
    
    override func didTapOnTAndCAction(cell: AcceptTermsAndConditionTVCell) {
        gotoAboutUsVC(keystr: "terms")
    }
    
    override func didTapOnPrivacyPolicyAction(cell: AcceptTermsAndConditionTVCell) {
        gotoAboutUsVC(keystr: "pp")
    }
    
    
    
    
    func gotoAboutUsVC(keystr:String) {
        guard let vc = AboutUsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.keystr = keystr
        present(vc, animated: true)
    }
    
    
    @IBAction func didTapOPayNowBtn(_ sender: Any) {
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            if journeyType == "Flight" {
                tapOnPayNow()
            }else {
                hotelTapPayNow()
            }
        }
    }
    
    
    //MARK: - AddDeatilsOfTravellerTVCell Delegate Methods
    
    override func didTapOnExpandAdultViewbtnAction(cell: AddDeatilsOfTravellerTVCell) {
        if cell.expandViewBool == true {
            
            cell.expandView()
            cell.expandViewBool = false
        }else {
            
            cell.collapsView()
            cell.expandViewBool = true
        }
        
        commonTableView.beginUpdates()
        commonTableView.endUpdates()
    }
    
    
    override func tfeditingChanged(tf:UITextField) {
        print(tf.tag)
    }
    
    
    
    override func donedatePicker(cell:AddDeatilsOfTravellerTVCell){
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell:AddDeatilsOfTravellerTVCell){
        self.view.endEditing(true)
    }
    
    
    override func didTapOnFlyerProgramBtnAction(cell:AddDeatilsOfTravellerTVCell){
        // print(cell.flyerProgramTF.text)
    }
    
    
    
    //MARK: - AddDeatilsOfGuestTVCell Delegate Methods
    override func didTapOnExpandAdultViewbtnAction(cell: AddDeatilsOfGuestTVCell){
        if cell.expandViewBool == true {
            
            cell.expandView()
            cell.expandViewBool = false
        }else {
            
            cell.collapsView()
            cell.expandViewBool = true
        }
        
        commonTableView.beginUpdates()
        commonTableView.endUpdates()
    }
    
    
    
    
    //MARK: - Hotel Commets
    override func textViewDidChange(textView:UITextView){
        hCommentsString = textView.text ?? ""
        
        print(hCommentsString)
    }
}


//MARK: - Did Tap On Hotel Pay Now Button API Calls
extension PayNowVC:HotelMBViewModelDelegate {
    
    
    //MARK:  setupHotelTVCells
    func setupHotelTVCells() {
        tablerow.removeAll()
        holderView.isHidden = false
        
        
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == false {
            tablerow.append(TableRow(cellType:.TDetailsLoginTVCell))
        }
        
        tablerow.append(TableRow(title:"Guest Details",cellType:.TotalNoofTravellerTVCell))
        
        for i in 1...adultsCount {
            positionsCount += 1
            let travellerCell = TableRow(title: "Adult \(i)", key: "adult", characterLimit: positionsCount, cellType: .AddDeatilsOfGuestTVCell)
            
            tablerow.append(travellerCell)
            
        }
        
        
        if childCount != 0 {
            for i in 1...childCount {
                positionsCount += 1
                tablerow.append(TableRow(title:"Child \(i)",key:"child",characterLimit: positionsCount,cellType:.AddDeatilsOfGuestTVCell))
                
            }
        }
        
        
        
        tablerow.append(TableRow(cellType:.ContactInformationTVCell))
        tablerow.append(TableRow(cellType:.SpecialRequestTVCell))
        tablerow.append(TableRow(cellType:.FlightPromocodeTVCell))
       
        tablerow.append(TableRow(title:"Purchase Summary",
                                 subTitle: defaults.string(forKey: UserDefaultsKeys.roomType),
                                 key:defaults.string(forKey: UserDefaultsKeys.checkout),
                                 text: defaults.string(forKey: UserDefaultsKeys.guestcount),
                                 headerText: defaults.string(forKey: UserDefaultsKeys.hoteladultscount),
                                 buttonTitle: defaults.string(forKey: UserDefaultsKeys.checkin),
                                 key1: defaults.string(forKey: UserDefaultsKeys.refundtype),
                                 TotalQuestions:grandTotal,
                                 cellType:.HotelPurchaseSummaryTVCell,
                                 questionBase: hpayableAmount))
        
        
        tablerow.append(TableRow(title:"I Accept T&C and Privacy Policy",cellType:.AcceptTermsAndConditionTVCell))
        tablerow.append(TableRow(height:30, bgColor:.AppBGcolor,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
}


extension PayNowVC {
    
    
    func setupInitialValues() {
        
        TimerManager.shared.delegate = self
        checkTermsAndCondationStatus = false
        countryCode = defaults.string(forKey: UserDefaultsKeys.mobilecountrycode) ?? ""
        billingCountryCode = defaults.string(forKey: UserDefaultsKeys.mobilecountrycode) ?? ""
        paymobilecountrycode = defaults.string(forKey: UserDefaultsKeys.mobilecountrycode) ?? "+965"
        
        let logstatus = defaults.bool(forKey: UserDefaultsKeys.loggedInStatus)
        if logstatus == true  {
            payemail = defaults.string(forKey: UserDefaultsKeys.useremail) ?? ""
            paymobile = defaults.string(forKey: UserDefaultsKeys.usermobile) ?? ""
            paymobilecountrycode = defaults.string(forKey: UserDefaultsKeys.usermobilecode) ?? ""
            mobilenoMaxLengthBool = true
        }
        
        
        addObserver()
        
        
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            if journeyType == "Flight" {
                DispatchQueue.main.async {[self] in
                    holderView.isHidden = true
                    viewFlightlbl.text = "View Flight Details"
                    nav.citylbl.text = defaults.string(forKey: UserDefaultsKeys.journeyCitys) ?? ""
                    nav.datelbl.text = defaults.string(forKey: UserDefaultsKeys.journeyDates) ?? ""
                    
                    
                    if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                        if journeyType == "oneway" {
                            nav.travellerlbl.text = defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? ""
                            
                            adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                            childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                            infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                            flighttotelCount = (adultsCount + childCount + infantsCount)
                        }else if journeyType == "circle"{
                            nav.travellerlbl.text = defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? ""
                            
                            adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                            childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                            infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                            flighttotelCount = (adultsCount + childCount + infantsCount)
                        }else {
                            nav.travellerlbl.text = defaults.string(forKey: UserDefaultsKeys.mtravellerDetails) ?? ""
                            
                            adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1") ?? 0
                            childCount = Int(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "0") ?? 0
                            infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.minfantsCount) ?? "0") ?? 0
                            flighttotelCount = (adultsCount + childCount + infantsCount)
                        }
                    }
                    
                    viewFlightsBtn.addTarget(self, action: #selector(didTapOnViewFlightDetails(_:)), for: .touchUpInside)
                    
                    callAPI()
                }
            }else {
                DispatchQueue.main.async {[self] in
                    holderView.isHidden = true
                    viewFlightlbl.text = "View Hotel Details"
                    viewFlightsBtn.addTarget(self, action: #selector(didTapOnViewHotelDetails(_:)), for: .touchUpInside)
                    
                    adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "1") ?? 0
                    childCount = Int(defaults.string(forKey: UserDefaultsKeys.hotelchildcount) ?? "0") ?? 0
                    nav.citylbl.text = "\(defaults.string(forKey: UserDefaultsKeys.locationcity) ?? "")"
                    nav.datelbl.text = "CheckIn - \(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "" , f1: "dd-MM-yyyy", f2: "dd MMM")) & CheckOut - \(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "", f1: "dd-MM-yyyy", f2: "dd MMM"))"
                    nav.travellerlbl.text = "Guests- \(defaults.string(forKey: UserDefaultsKeys.guestcount) ?? "1") / Room - \(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "")"
                    
                    if callapibool == true {
                        callHotelMobileBookingAPI()
                    }
                    
                }
            }
        }
        
        
    }
    
    
    
    //MARK: - CALL_PRE_PROCESS_BOOKING_API
    func callAPI() {
        
        payload.removeAll()
        payload["search_id"] = searchid
        payload["booking_source"] = bookingsource
        payload["promocode_val"] = ""
        payload["access_key"] = accesskey
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid)
        
        vm?.CALL_PRE_PROCESS_BOOKING_API(dictParam: payload)
    }
    
    func preProcessBookingDetails(response: PreProcessBookingModel) {
        
        
        if response.status == true{
            tokenkey1 = response.form_params?.token_key ?? ""
            
            DispatchQueue.main.async {[self] in
                callMobileBookingAPI(res: response)
            }
        }else {
            gotoNoInternetConnectionVC(key: "noresult")
        }
    }
    
    //MARK: - CALL_MOBILE_BOOKING_API
    func callMobileBookingAPI(res:PreProcessBookingModel) {
        
        tokenkey1 = res.form_params?.token_key ?? ""
        promoinfoArray = res.promo_info ?? []
        
        DispatchQueue.main.async {[self] in
            payload.removeAll()
            payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid)
            payload["search_id"] = searchid
            payload["booking_source"] = bookingsourcekey
            payload["promocode_val"] = ""
            payload["access_key"] = accesskey
            payload["booking_id"] = res.form_params?.booking_id
            
            vm?.CALL_MOBILE_BOOKING_API(dictParam: payload)
            
        }
    }
    
    
    func mobileBookingDetails(response: MobileBookingModel) {
        
        
        if response.status == 1 {
            
            
            activepaymentoptions = response.active_payment_options?[0] ?? ""
            tmpFlightPreBookingId = response.tmp_flight_pre_booking_id ?? ""
            accesskey = response.access_key_tp ?? ""
            bookingsource = response.booking_source ?? ""
          
            
            
            //            specialAssistancelist1 = response.special_allowance ?? []
            //            meallist = response.meal_list ?? []
            
            
            DispatchQueue.main.async {[self] in
                setupTVCells()
            }
            
            
        }else {
            gotoNoInternetConnectionVC(key: "noresult")
        }
        
        
    }
    
    
    
    
    //MARK: - setupTVCells
    func setupTVCells() {
        tablerow.removeAll()
        holderView.isHidden = false
        
        
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == false {
            tablerow.append(TableRow(cellType:.TDetailsLoginTVCell))
        }
        
        
        
        passengertypeArray.removeAll()
        tablerow.append(TableRow(height:20, bgColor:.AppHolderViewColor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Passenger Details",cellType:.TotalNoofTravellerTVCell))
        for i in 1...adultsCount {
            positionsCount += 1
            passengertypeArray.append("Adult")
            let travellerCell = TableRow(title: "Adult \(i)", key: "adult", characterLimit: positionsCount, cellType: .AddDeatilsOfTravellerTVCell)
            tablerow.append(travellerCell)
            
        }
        
        
        if childCount != 0 {
            for i in 1...childCount {
                positionsCount += 1
                passengertypeArray.append("Child")
                tablerow.append(TableRow(title:"Child \(i)",key:"child",characterLimit: positionsCount,cellType:.AddDeatilsOfTravellerTVCell))
            }
        }
        
        if infantsCount != 0 {
            for i in 1...infantsCount {
                positionsCount += 1
                passengertypeArray.append("Infant")
                tablerow.append(TableRow(title:"Infant \(i)",key:"infant",characterLimit: positionsCount,cellType:.AddDeatilsOfTravellerTVCell))
            }
        }
        
        tablerow.append(TableRow(cellType:.ContactInformationTVCell))
        
        if promocodeBool == false {
            tablerow.append(TableRow(cellType:.FlightPromocodeTVCell))
        }
        
        
        tablerow.append(TableRow(cellType:.FlightPriceSummeryTVCell))
        
        
        
        
        tablerow.append(TableRow(title:"I Accept T&C and Privacy Policy",cellType:.AcceptTermsAndConditionTVCell))
        tablerow.append(TableRow(height:30, bgColor:.AppBGcolor,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
}





//MARK: - Did Tap On Flight Pay Now Button API Calls
extension PayNowVC {
    
    func tapOnPayNow() {
        
        payload.removeAll()
        payload1.removeAll()
        
        
        
        var callpaymentbool = true
        var fnameCharBool = true
        var lnameCharBool = true
        
        
        
        
        for traveler in travelerArray {
            
            if traveler.firstName == nil  || traveler.firstName?.isEmpty == true{
                callpaymentbool = false
                
            }
            
            if (traveler.firstName?.count ?? 0) <= 3 {
                fnameCharBool = false
            }
            
            if traveler.lastName == nil || traveler.firstName?.isEmpty == true{
                callpaymentbool = false
            }
            
            if (traveler.lastName?.count ?? 0) <= 3 {
                lnameCharBool = false
            }
            
            if traveler.dob == nil || traveler.dob?.isEmpty == true{
                callpaymentbool = false
            }
            
            if traveler.passportno == nil || traveler.passportno?.isEmpty == true{
                callpaymentbool = false
            }
            
            if traveler.passportIssuingCountry == nil || traveler.passportIssuingCountry?.isEmpty == true{
                callpaymentbool = false
            }
            
            if traveler.passportExpireDate == nil || traveler.passportExpireDate?.isEmpty == true{
                callpaymentbool = false
            }
            
            
            // Continue checking other fields
        }
        
        
        
        
        let positionsCount1 = commonTableView.numberOfRows(inSection: 0)
        for position in 0..<positionsCount1 {
            // Fetch the cell for the given position
            if let cell = commonTableView.cellForRow(at: IndexPath(row: position, section: 0)) as? AddDeatilsOfTravellerTVCell {
                
                if cell.titleTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.titleView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                    
                } else {
                    // Textfield is not empty
                }
                
                if cell.fnameTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.fnameView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                }else if (cell.fnameTF.text?.count ?? 0) <= 3{
                    cell.fnameView.layer.borderColor = UIColor.red.cgColor
                    fnameCharBool = false
                }else {
                    fnameCharBool = true
                }
                
                if cell.lnameTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.lnameView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                }else if (cell.lnameTF.text?.count ?? 0) <= 3{
                    cell.lnameView.layer.borderColor = UIColor.red.cgColor
                    lnameCharBool = false
                } else {
                    // Textfield is not empty
                    lnameCharBool = true
                }
                
                
                if cell.dobTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.dobView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                } else {
                    // Textfield is not empty
                }
                
                
                if cell.passportnoTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.passportnoView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                } else {
                    // Textfield is not empty
                }
                
                
                if cell.passportIssuingCountryTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.issuecountryView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                } else {
                    // Textfield is not empty
                }
                
                
                if cell.passportExpireDateTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.passportexpireView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                } else {
                    // Textfield is not empty
                }
                
            }
        }
        
        let laedpassengerArray = travelerArray.compactMap({$0.laedpassenger})
        let mrtitleArray = travelerArray.compactMap({$0.mrtitle})
        let genderArray = travelerArray.compactMap({$0.gender})
        let firstnameArray = travelerArray.compactMap({$0.firstName})
        let lastNameArray = travelerArray.compactMap({$0.lastName})
        let middlenameArray = travelerArray.compactMap({$0.middlename})
        let dobArray = travelerArray.compactMap({$0.dob})
        let passportnoArray = travelerArray.compactMap({$0.passportno})
        //   let nationalityArray = travelerArray.compactMap({$0.nationality})
        let passportIssuingCountryArray = travelerArray.compactMap({$0.passportIssuingCountry})
        let passportExpireDateArray = travelerArray.compactMap({$0.passportExpireDate})
        // let passengertypeArray = travelerArray.compactMap({$0.passengertype})
        
        
        // Convert arrays to string representations
        let laedpassengerString = "[\"" + laedpassengerArray.joined(separator: "\",\"") + "\"]"
        let genderString = "[\"" + genderArray.joined(separator: "\",\"") + "\"]"
        let mrtitleString = "[\"" + mrtitleArray.joined(separator: "\",\"") + "\"]"
        let firstnameString = "[\"" + firstnameArray.joined(separator: "\",\"") + "\"]"
        let middlenameString = "[\"" + middlenameArray.joined(separator: "\",\"") + "\"]"
        let lastNameString = "[\"" + lastNameArray.joined(separator: "\",\"") + "\"]"
        let dobString = "[\"" + dobArray.joined(separator: "\",\"") + "\"]"
        let passportnoString = "[\"" + passportnoArray.joined(separator: "\",\"") + "\"]"
        let passportIssuingCountryString = "[\"" + passportIssuingCountryArray.joined(separator: "\",\"") + "\"]"
        let passportExpireDateString = "[\"" + passportExpireDateArray.joined(separator: "\",\"") + "\"]"
        let passengertypeArrayString = "[\"" + passengertypeArray.joined(separator: "\",\"") + "\"]"
        
        payload["search_id"] = searchid
        payload["tmp_flight_pre_booking_id"] = tmpFlightPreBookingId
        payload["token_key"] = tokenkey1
        payload["access_key"] =  accesskey
        payload["access_key_tp"] =  accesskey
        payload["insurance_policy_type"] = "0"
        payload["insurance_policy_option"] = "0"
        payload["insurance_policy_cover_type"] = "0"
        payload["insurance_policy_duration"] = "0"
        payload["isInsurance"] = "0"
        payload["redeem_points_post"] = "1"
        payload["booking_source"] = bookingsource
        payload["promocode_val"] = promocodeString
        payload["promocode_code"] = ""
        payload["mealsAmount"] = "0"
        payload["baggageAmount"] = "0"
        
        payload["passenger_type"] = passengertypeArrayString
        payload["lead_passenger"] = laedpassengerString
        payload["gender"] = genderString
        payload["name_title"] =  mrtitleString
        payload["first_name"] =  firstnameString
        payload["middle_name"] =  middlenameString
        payload["last_name"] =  lastNameString
        payload["date_of_birth"] =  dobString
        payload["passenger_passport_number"] =  passportnoString
        payload["passenger_passport_issuing_country"] =  passportIssuingCountryString
        payload["passenger_nationality"] = passportIssuingCountryString
        payload["passenger_passport_expiry"] =  passportExpireDateString
        payload["Frequent"] = "\([["Select"]])"
        payload["ff_no"] = "\([[""]])"
        payload["payment_method"] =  "PNHB1"
        
        payload["billing_email"] = payemail
        payload["passenger_contact"] = paymobile
        payload["country_mobile_code"] = paymobilecountrycode
        payload["insurance"] = "1"
        payload["tc"] = "on"
        payload["booking_step"] = "book"
        payload["selectedCurrency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        
        //   payload["gender"] = genderString
        //        payload["address2"] = "ecity"
        //        payload["billing_address_1"] = "DA"
        //        payload["billing_state"] = "ASDAS"
        //        payload["billing_city"] = "sdfsd"
        //        payload["billing_zipcode"] = "sdf"
        //   payload["billing_country"] = nationalityCode
        
        
        
        // Check additional conditions
        if callpaymentbool == false {
            showToast(message: "Add Details")
        }else if passportExpireDateBool == false {
            showToast(message: "Invalid expiry. Passport expires within the next 3 months.")
        }else if !fnameCharBool {
            showToast(message: "First name should have more than 3 characters")
        }else if !lnameCharBool {
            showToast(message: "Last name should have more than 3 characters")
        }else if payemail == "" {
            showToast(message: "Enter Email Address")
        }else if payemail.isValidEmail() == false {
            showToast(message: "Enter Valid Email Addreess")
        }else if paymobile == "" {
            showToast(message: "Enter Mobile No")
        }else if paymobilecountrycode == "" {
            showToast(message: "Enter Country Code")
        }else if mobilenoMaxLengthBool == false {
            showToast(message: "Enter Valid Mobile No")
        }else if checkTermsAndCondationStatus == false {
            showToast(message: "Please Accept T&C and Privacy Policy")
        }else {
            
            
            vm?.CALL_PROCESS_PASSENGER_DETAIL_API(dictParam: payload)
        }
    }
    
    
    func processPassengerDetails(response: ProcessPassangerDetailModel) {
        secureapidonebool = true
        
        if response.status == true {
            gotoLoadWebViewVC(url: response.form_url ?? "")
        }else {
            showToast(message: response.msg ?? "")
        }
        
    }
    
    
    func gotoLoadWebViewVC(url:String) {
        guard let vc = LoadWebViewVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.urlString = url
        present(vc, animated: true)
    }
    
    
    
    
    func preFlightBookingDetails(response: ProcessPassangerDetailModel) {
        DispatchQueue.main.async {[self] in
            payload.removeAll()
            payload["app_reference"] = tmpFlightPreBookingId
            payload["promocode_val"] = promocodeString
            
            vm?.CALL_FLIGHT_PRE_CONF_PAYMENT_API(dictParam: payload, key: "\(searchid)")
        }
    }
    
    
    func flightPrePaymentDetails(response: PrePaymentConfModel) {
        DispatchQueue.main.async {[self] in
            payload.removeAll()
            payload["extra_price"] = "0"
            payload["promocode_val"] = promocodeString
            
            vm?.CALL_SENDTO_PAYMENT_API(dictParam: payload, key: "\(tmpFlightPreBookingId)/\(searchid)")
        }
    }
    
    
    
    func sendtoPaymentDetails(response: sendToPaymentModel) {
        
        
        if response.status == true {
            DispatchQueue.main.async {[self] in
                payload.removeAll()
                vm?.CALL_SECURE_BOOKING_API(dictParam: [:], key: "\(tmpFlightPreBookingId)")
            }
        }else {
            showToast(message: response.msg ?? "")
            gotoNoInternetConnectionVC(key: "noseat")
            
        }
    }
    
    
    
    
    func secureBookingDetails(response: sendToPaymentModel) {
        // gotoLoadWebViewVC(url: response.form_url ?? "")
    }
    
}


extension PayNowVC {
    
    
    //MARK: - callHotelMobileBookingAPI
    func callHotelMobileBookingAPI() {
        payload.removeAll()
        
        
        if hbooking_source == "PTBSID0000000044" {
            
            payload["search_id"] = hsearch_id
            payload["booking_source"] = hbooking_source
            payload["token"] = self.room_token
            payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
            payload["room_selected"] = roomselected
            payload["RoomDetails"] = roomDetails
            payload["hotel_details"] = hoteldetails
            payload["currency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency)
            
            
            vm1?.CALL_GET_HOTEL_MOBILE_BOOKING_DETAILS_API(dictParam: payload)
            
        }else if hbooking_source == "PTBSID0000000089" {
            
            let ratekeyArrayString = "[\"" + ratekeyArray.joined(separator: "\",\"") + "\"]"
            payload["search_id"] = hsearch_id
            payload["booking_source"] = hbooking_source
            payload["token"] = self.htoken
            payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
            payload["room_selected"] = roomselected
            payload["token_key"] = htokenkey
            payload["rateKey"] = ratekeyArrayString
            payload["currency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency)
            
            
            vm1?.CALL_GET_HOTEL_MOBILE_BOOKING_DETAILS_API(dictParam: payload)
        }
        
    }
    
    
    //MARK: - hotelMBDetails
    func hotelMBDetails(response: HotelMBModel) {
        
        holderView.isHidden = false
        hbookingToken = response.data?.token ?? ""
        hbookingTokenkey = response.data?.token_key ?? ""
        specialReq = response.data?.special_request ?? []
        
        titlelbl.text = hpayableAmount
        
        
        DispatchQueue.main.async {[self] in
            setupHotelTVCells()
        }
    }
    
    func hotelTapPayNow() {
        
        payload.removeAll()
        payload1.removeAll()
        
        
        var callpaymenthotelbool = true
        var fnameCharBool = true
        var lnameCharBool = true
        
        
        for traveler in travelerArray {
            
            if traveler.firstName == nil  || traveler.firstName?.isEmpty == true{
                callpaymenthotelbool = false
                
            }
            
            if (traveler.firstName?.count ?? 0) <= 3 {
                fnameCharBool = false
            }
            
            if traveler.lastName == nil || traveler.firstName?.isEmpty == true{
                callpaymenthotelbool = false
            }
            
            if (traveler.lastName?.count ?? 0) <= 3 {
                lnameCharBool = false
            }
            
            
            // Continue checking other fields
        }
        
        
        
        let positionsCount1 = commonTableView.numberOfRows(inSection: 0)
        for position in 0..<positionsCount1 {
            // Fetch the cell for the given position
            if let cell = commonTableView.cellForRow(at: IndexPath(row: position, section: 0)) as? AddDeatilsOfGuestTVCell {
                
                if cell.titleTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.titleView.layer.borderColor = UIColor.red.cgColor
                    callpaymenthotelbool = false
                    
                }
                
                if cell.fnameTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.fnameView.layer.borderColor = UIColor.red.cgColor
                    callpaymenthotelbool = false
                }else if (cell.fnameTF.text?.count ?? 0) <= 3{
                    cell.fnameView.layer.borderColor = UIColor.red.cgColor
                    fnameCharBool = false
                }else {
                    fnameCharBool = true
                }
                
                if cell.lnameTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.lnameView.layer.borderColor = UIColor.red.cgColor
                    callpaymenthotelbool = false
                }else if (cell.lnameTF.text?.count ?? 0) <= 3{
                    cell.lnameView.layer.borderColor = UIColor.red.cgColor
                    lnameCharBool = false
                } else {
                    // Textfield is not empty
                    lnameCharBool = true
                }
                
                
            }
        }
        
        
        let mrtitleArray = travelerArray.compactMap({$0.mrtitle})
        let passengertypeArray = travelerArray.compactMap({$0.passengertype})
        let firstnameArray = travelerArray.compactMap({$0.firstName})
        let lastNameArray = travelerArray.compactMap({$0.lastName})
        let laedpassengerArray = travelerArray.compactMap({$0.laedpassenger})
        
        let mrtitleString = "[\"" + mrtitleArray.joined(separator: "\",\"") + "\"]"
        let firstnameString = "[\"" + firstnameArray.joined(separator: "\",\"") + "\"]"
        let lastNameString = "[\"" + lastNameArray.joined(separator: "\",\"") + "\"]"
        let passengertypeString = "[\"" + passengertypeArray.joined(separator: "\",\"") + "\"]"
        let laedpassengerArrayString = "[\"" + laedpassengerArray.joined(separator: "\",\"") + "\"]"
        
        
        let spcialReqArrayStr = "[\"" + selectedSpecialReqArray.joined(separator: "\",\"") + "\"]"

        
        payload["search_id"] = hsearch_id
        payload["token"] = hbookingToken
        payload["token_key"] = hbookingTokenkey
        payload["booking_source"] = hbooking_source
        payload["payment_method"] = "PNHB1"
        payload["payment_booking_source"] = ""
        payload["promo_code"] = promocodeString
        payload["promo_actual_value"] = ""
        payload["base_en_rate"] = ""
        payload["reward_usable"] = ""
        payload["reward_earned"] = ""
        payload["total_price_with_rewards"] = ""
        payload["reducing_amount"] = ""
        payload["passenger_type"] = passengertypeString
        payload["lead_passenger"] = laedpassengerArrayString
        payload["rateKey"] = ""
        payload["mealsID"] = ""
        payload["dob"] = "\([""])"
        payload["nationality"] = "\([""])"
        payload["name_title"] = mrtitleString
        payload["first_name"] = firstnameString
        payload["last_name"] = lastNameString
        payload["billing_email"] = payemail
        payload["passenger_contact"] = paymobile
        payload["payment_value"] = "payment_gateway_knet"
        payload["users_comments"] = hCommentsString
        payload["special_req"] = spcialReqArrayStr
        
        
        // Check additional conditions
        if payemail == "" {
            showToast(message: "Enter Email Address")
        }else if payemail.isValidEmail() == false {
            showToast(message: "Enter Valid Email Addreess")
        }else if paymobile == "" {
            showToast(message: "Enter Mobile No")
        }else if countryCode == "" {
            showToast(message: "Enter Country Code")
        }else if mobilenoMaxLengthBool == false {
            showToast(message: "Enter Valid Mobile No")
        }else
        
        if callpaymenthotelbool == false{
            showToast(message: "Add Details")
        }else if fnameCharBool == false{
            showToast(message: "More Than 3 Char")
        }else if lnameCharBool == false{
            showToast(message: "More Than 3 Char")
        }else if checkTermsAndCondationStatus == false {
            showToast(message: "Please Accept T&C and Privacy Policy")
        }else {
            vm1?.CALL_GET_HOTEL_MOBILE_PRE_BOOKING_DETAILS_API(dictParam: payload)
        }
        
    }
    
    
    func hotelMobilePreBookingDetails(response: HotelPreBookingModel) {
        
        if response.status == 1 {
            gotoLoadWebViewVC(url: response.data ?? "")
        }else {
            showToast(message: response.msg ?? "")
        }
        
    }
    
    
    
    func hotelSecureBookingDetails(response: HotelSecureBookingModel) {
        // BASE_URL = BASE_URL1
    }
    
}



extension PayNowVC {
    //MARK: - searchFlightAgain gotoBackScreen
    @objc func gotoBackScreen() {
        callapibool = false
        travelerArray.removeAll()
        
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            if journeyType == "Flight" {
                searchFlightAgain()
               // dismiss(animated: true)
            }else {
                searchHotelAgain()
                // dismiss(animated: true)
            }
        }
        
    }
    
    
    //MARK: - searchFlightAgain gotoBackScreen
    func searchFlightAgain() {
        
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
    
    
    func gotoSearchFlightResultVC(input:[String:Any]) {
        defaults.set(false, forKey: "flightfilteronce")
        guard let vc = SearchFlightResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.payload = input
        callapibool = true
        self.present(vc, animated: true)
    }
    
    
    //MARK: - searchHotelAgain gotoBackScreen
    func  searchHotelAgain(){
        
        payload.removeAll()
        
        payload["city"] = defaults.string(forKey: UserDefaultsKeys.locationcity)
        payload["hotel_destination"] = defaults.string(forKey: UserDefaultsKeys.locationid)
        payload["hotel_checkin"] = defaults.string(forKey: UserDefaultsKeys.checkin)
        payload["hotel_checkout"] = defaults.string(forKey: UserDefaultsKeys.checkout)
        
        payload["rooms"] = "\(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "1")"
        payload["adult"] = adtArray
        payload["child"] = chArray
        
        for roomIndex in 0..<totalRooms {
            
            
            if let numChildren = Int(chArray[roomIndex]), numChildren > 0 {
                var childAges: [String] = Array(repeating: "0", count: numChildren)
                
                if numChildren > 2 {
                    childAges.append("0")
                }
                
                payload["childAge_\(roomIndex + 1)"] = childAges
            }
        }
        
        
        payload["nationality"] = defaults.string(forKey: UserDefaultsKeys.hnationalitycode) ?? "KW"
        //        payload["language"] = "english"
        //        payload["search_source"] = "postman"
        //        payload["currency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        if defaults.string(forKey: UserDefaultsKeys.locationcity) == "Add City" || defaults.string(forKey: UserDefaultsKeys.locationcity) == nil{
            showToast(message: "Enter Hotel or City ")
        }else if defaults.string(forKey: UserDefaultsKeys.checkin) == "Add Check In Date" || defaults.string(forKey: UserDefaultsKeys.checkin) == nil{
            showToast(message: "Enter Checkin Date")
        }else if defaults.string(forKey: UserDefaultsKeys.checkout) == "Add Check Out Date" || defaults.string(forKey: UserDefaultsKeys.checkout) == nil{
            showToast(message: "Enter Checkout Date")
        }else if defaults.string(forKey: UserDefaultsKeys.checkout) == defaults.string(forKey: UserDefaultsKeys.checkin) {
            showToast(message: "Enter Different Dates")
        }else if defaults.string(forKey: UserDefaultsKeys.roomcount) == "" {
            showToast(message: "Add Rooms For Booking")
        }else if defaults.string(forKey: UserDefaultsKeys.hnationality) == "Nationality" {
            showToast(message: "Please Select Nationality.")
        }else if checkDepartureAndReturnDates(payload, p1: "hotel_checkin", p2: "hotel_checkout") == false {
            showToast(message: "Invalid Date")
        }else {
            
            
            do{
                
                let jsonData = try JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
                let jsonStringData =  NSString(data: jsonData as Data, encoding: NSUTF8StringEncoding)! as String
                
                print(jsonStringData)
                
                
            }catch{
                print(error.localizedDescription)
            }
            
            gotoSearchHotelsResultVC()
        }
    }
    
    
    func gotoSearchHotelsResultVC(){
        defaults.set(false, forKey: "hoteltfilteronce")
        guard let vc = HotelSearchResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.nationalityCode = "IN"
        callapibool = true
        vc.payload = payload
        present(vc, animated: true)
    }
    
}



extension PayNowVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reloadTV"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("tryagain"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(logindon), name: Notification.Name("logindon"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(passportexpiry), name: NSNotification.Name("passportexpiry"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(cancelpromo), name: Notification.Name("cancelpromo"), object: nil)
        
        
    }
    
    
    @objc func cancelpromo() {
        promocodeBool = false
        promocodeValue = ""
        promocodeString = ""
        grandTotal = newGrandTotal
        totalTripCost = newGrandTotal1
        
        
        setupLabels(lbl: titlelbl, text: grandTotal, textcolor: .AppLabelColor, font: .OpenSansMedium(size: 20))
        
        hotelPromocodeBool.toggle()
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    @objc func passportexpiry(notify:NSNotification) {
        passportExpireDateBool = false
        showToast(message: (notify.object as? String) ?? "")
    }
    
    @objc func logindon(){
       // setupTVCells()
        commonTableView.reloadData()
    }
    
    
    func timerDidFinish() {
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    func updateTimer() {
        
    }
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
            callAPI()
        }
    }
    
    
    //MARK: - resultnil
    @objc func resultnil() {
        gotoNoInternetConnectionVC(key: "noresult")
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        gotoNoInternetConnectionVC(key: "nointernet")
    }
    
    func gotoNoInternetConnectionVC(key:String) {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = key
        self.present(vc, animated: false)
    }
    
}
