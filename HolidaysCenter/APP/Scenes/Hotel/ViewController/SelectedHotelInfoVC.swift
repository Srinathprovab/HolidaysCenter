//
//  SelectedHotelInfoVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 22/08/22.
//



import UIKit

class SelectedHotelInfoVC: BaseTableVC, HotelDetailsViewModelDelegate {
    
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var bookNowHolderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var bookNowView: UIView!
    @IBOutlet weak var bookNowlbl: UILabel!
    @IBOutlet weak var bookNowBtn: UIButton!
    @IBOutlet weak var yesbtn: UIButton!
    @IBOutlet weak var nobtn: UIButton!
    @IBOutlet weak var priceUpdationView: UIView!
    
    
    
    var selectedRoomBool = false
    var htoken = String()
    var htoken89 = String()
    var htokenkey89 = String()
    
    var room_token = String()
    var roomDetails = String()
    var hotel_details = String()
    
    var kwdprice = String()
    var hotelid = String()
    var token = String()
    var isVcFrom = String()
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var vm:HotelDetailsViewModel?
    
    static var newInstance: SelectedHotelInfoVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectedHotelInfoVC
        return vc
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        vm = HotelDetailsViewModel(self)
        
        
        addObserver()
    }
    
    
    func setupUI() {
        
        self.view.backgroundColor = .WhiteColor
        self.holderView.backgroundColor = .AppHolderViewColor
        nav.titlelbl.text = "Hotel Details"
        nav.backBtn.addTarget(self, action: #selector(backbtnAction(_:)), for: .touchUpInside)
        nav.citylbl.isHidden = false
        nav.datelbl.isHidden = false
        nav.travellerlbl.isHidden = false
        
        nav.citylbl.text = "\(defaults.string(forKey: UserDefaultsKeys.locationcity) ?? "")"
        nav.datelbl.text = "CheckIn -\(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "" , f1: "dd-MM-yyyy", f2: "dd MMM")) & CheckOut -\(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "", f1: "dd-MM-yyyy", f2: "dd MMM"))"
        nav.travellerlbl.text = "Guests- \(defaults.string(forKey: UserDefaultsKeys.guestcount) ?? "1") / Room - \(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "") / \(totalNoofNights)"
        if screenHeight > 835 {
            navHeight.constant = 190
        }else {
            navHeight.constant = 160
        }
        
        setupViews(v: bookNowHolderView, radius: 0, color: .WhiteColor)
        setupViews(v: bookNowView, radius: 20, color: .AppNavBackColor)
        setupLabels(lbl: bookNowlbl, text: "BOOK NOW", textcolor: .BtnTitleColor, font: .OpenSansRegular(size: 16))
        bookNowBtn.setTitle("", for: .normal)
        bookNowBtn.addTarget(self, action: #selector(didTapOnBookNowBtn(_:)), for: .touchUpInside)
        
        
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "HotelSearchResultTVCell",
                                         "RatingWithLabelsTVCell",
                                         "FacilitiesTVCell",
                                         "HotelImagesTVCell",
                                         "TwinSuperiorRoomTVCell",
                                         "TitleLblTVCell",
                                         "RoomsTVCell"])
        
        
        
        yesbtn.layer.cornerRadius = 4
        nobtn.layer.cornerRadius = 4
        priceUpdationView.isHidden = true
        
    }
    
    
    @objc func backbtnAction(_ sender:UIButton) {
        callapibool = false
        dismiss(animated: true)
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
    
    
    override func didTapOnCancellationPolicyBtn(cell: TwinSuperiorRoomTVCell) {
        
        
        var amountString = String()
        for amount in cell.cancellationPoloicy {
            amountString = amount
        }
        
        guard let vc = CancellationPolicyPopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.amount = amountString
        self.present(vc, animated: false)
        
        
    }
    
    
    override func didTapOnRoomTvcell(cell:TwinSuperiorRoomTVCell) {
        ratekeyArray.removeAll()
        ratekeyArray.append(cell.ratekey)
        
        room_selected = cell.room_selected
        room_token = cell.token
        ratekeyArray.removeAll()
        ratekeyArray.append(cell.ratekey)
        
        newGrandTotal = "\(cell.kwdlbl.text ?? ""):\(cell.kwdPricelbl.text ?? "")"
        
        setupLabels(lbl: titlelbl, text: "\(cell.kwdlbl.text ?? ""):\(cell.kwdPricelbl.text ?? "")", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 20))
        promoGrandAmount = cell.kwdPricelbl.text ?? ""
        
        
    }
    
    @objc func didTapOnBookNowBtn(_ sender:UIButton) {
        
        
        if self.selectedRoomBool != false {
            guard let vc = PayNowVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            callapibool = true
            vc.room_token = self.room_token
            vc.htoken = self.htoken89
            vc.htokenkey = self.htokenkey89
            vc.hoteldetails = self.hotel_details
            vc.roomDetails = self.roomDetails
            vc.roomselected = room_selected
            vc.hpayableAmount = titlelbl.text ?? ""
            self.present(vc, animated: false)
            
        }else {
            showToast(message: "Please Select Room To Continue Bookng")
        }
        
    }
    
    
    @IBAction func didTapOnYesBtnAction(_ sender: Any) {
        priceUpdationView.isHidden = true
    }
    
    
    @IBAction func didTapOnNoBtnAction(_ sender: Any) {
        gotoBookHotelVC()
    }
    
    
    func gotoBookHotelVC() {
        guard let vc = BookHotelVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        isFromVCBool = false
        self.present(vc, animated: false)
    }
    
    
}


extension SelectedHotelInfoVC {
    
    
    
    func callAPI() {
        
        payload["booking_source"] = hbooking_source
        payload["hotel_id"] = hotelid
        payload["search_id"] = hsearch_id
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        payload["ResultToken"] = token
        payload["currency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency)
        
        vm?.CALL_GET_HOTEL_DETAILS_API(dictParam: payload)
    }
    
    
    
    func hotelDetails(response: HotelDetailsModel) {
        
        holderView.isHidden = false
        hd = response
        
        htokenkey89 = response.hotel_details?.tokenKey ?? ""
        htoken89 = response.hotel_details?.token ?? ""
        
        hsearch_id = response.params?.search_id ?? ""
        hbooking_source = response.params?.booking_source ?? ""
        htoken = response.params?.resultToken ?? ""
        hotel_details = response.hotel_details_key ?? ""
        roomDetails = response.roomDetails ?? ""
        
        
        //MARK:- first Room selected
        setupLabels(lbl: titlelbl, text: "\(response.hotel_details?.currency ?? ""):\(response.hotel_details?.rooms?[0][0].roomPrice ?? "")", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 20))
        room_selected = "0"
        room_token = response.hotel_details?.rooms?[0][0].token ?? ""
        ratekeyArray.removeAll()
        ratekeyArray.append(response.hotel_details?.rooms?[0][0].rateKey ?? "")
        promoGrandAmount = response.hotel_details?.rooms?[0][0].roomPrice ?? ""
        newGrandTotal = titlelbl.text ?? ""
        
        
        if response.price_change == 1 {
            priceUpdationView.isHidden = false
        }
        
        DispatchQueue.main.async {
            self.setupTVCells(hotelDetails: response)
        }
        
        
    }
    
    
    
    func setupTVCells(hotelDetails:HotelDetailsModel) {
        tablerow.removeAll()
        
        
        tablerow.append(TableRow(title:hotelDetails.hotel_details?.name,
                                 subTitle: hotelDetails.hotel_details?.address,
                                 key: "rating",
                                 characterLimit: Int(hotelDetails.hotel_details?.star_rating ?? "0"),
                                 cellType:.RatingWithLabelsTVCell))
        
        
        tablerow.append(TableRow(height:20,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
        
        
        
        
        tablerow.append(TableRow(title:hotelDetails.hotel_details?.hotel_desc ?? "",
                                 image:hotelDetails.hotel_details?.image,
                                 moreData: hotelDetails.hotel_details?.images,
                                 cellType:.HotelImagesTVCell))
        
        

        tablerow.append(TableRow(title:"Rooms",key: "room",cellType:.TitleLblTVCell))
        
        hotelDetails.hotel_details?.rooms?.forEach({ i in
           
            for (index,value) in i.enumerated() {
                tablerow.append(TableRow(title:"\(index)",moreData: value,cellType:.TwinSuperiorRoomTVCell))
            }
        })
        
        
        
        
        
        if let fac = hotelDetails.hotel_details?.format_ame,fac.count != 0 {
            
            tablerow.append(TableRow(title:"Facilities",
                                     moreData: fac,
                                     cellType:.FacilitiesTVCell))
            
        }
        
        
        tablerow.append(TableRow(height:50,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TwinSuperiorRoomTVCell {
            cell.radioImg.image = UIImage(named: "radioSelected")
           
            selectedRoomBool = true
            defaults.set(cell.titlelbl.text, forKey: UserDefaultsKeys.roomType)
            defaults.set(cell.nonRefundablelbl.text, forKey: UserDefaultsKeys.refundtype)
            
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TwinSuperiorRoomTVCell {
            cell.radioImg.image = UIImage(named: "radioUnselected")
        }
    }
}


extension SelectedHotelInfoVC:TimerManagerDelegate {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        TimerManager.shared.delegate = self
        
        if callapibool == true {
            holderView.isHidden = true
            callAPI()
        }
    }
    
    
    
    @objc func reload(notification: NSNotification){
        commonTableView.reloadData()
    }
    
    
    //MARK: - resultnil
    @objc func resultnil(notification: NSNotification){
        callapibool = true
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.key = "noresult"
        self.present(vc, animated: false)
    }
    
    
    @objc func offline(notificatio:UNNotification) {
        callapibool = true
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.key = "offline"
        self.present(vc, animated: false)
    }
    
    
    func timerDidFinish() {
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    func updateTimer() {
        
    }
    
}
