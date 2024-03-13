//
//  MyBookingVC.swift
//  KuwaitWays
//
//  Created by FCI on 08/05/23.
//

import UIKit

class MyBookingVC: BaseTableVC {
    
    @IBOutlet weak var satckView: UIStackView!
    @IBOutlet weak var btnsView: UIView!
    @IBOutlet weak var upcomingBtnView: UIView!
    @IBOutlet weak var upcomingul: UIView!
    @IBOutlet weak var upcominglbl: UILabel!
    @IBOutlet weak var upcomingBtn: UIButton!
    @IBOutlet weak var completedBtnView: UIView!
    @IBOutlet weak var completedul: UIView!
    @IBOutlet weak var completedlbl: UILabel!
    @IBOutlet weak var completedBtn: UIButton!
    @IBOutlet weak var cancelledBtnView: UIView!
    @IBOutlet weak var cancelledul: UIView!
    @IBOutlet weak var cancelledlbl: UILabel!
    @IBOutlet weak var cancelledBtn: UIButton!
    @IBOutlet weak var flightView: BorderedView!
    @IBOutlet weak var hotelView: BorderedView!
    @IBOutlet weak var flightBtnlbl: UILabel!
    @IBOutlet weak var hotelbtnlbl: UILabel!
    @IBOutlet weak var loginlbl: UILabel!
    
    
    
    var tapkey = "flight"
    var payload = [String:Any]()
    var tablerow = [TableRow]()
    var vm:MyBookingViewModel?
    
    //Hotel
    var cancelledbookingdetails = [Cancelled_booking_details]()
    var Upcomingbookingdetails = [Upcoming_booking_details]()
    var Confirmedbookingdetails = [Confirmed_booking_details]()
    var hotelkeystr = "upcoming"
    
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: false)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(logindon), name: Notification.Name("logindon"), object: nil)
        
        
        let logstatus = defaults.bool(forKey: UserDefaultsKeys.loggedInStatus)
        if logstatus == true {
            
            
            satckView.isHidden = false
            btnsView.isUserInteractionEnabled = true
            btnsView.alpha = 1
            satckView.isHidden = false
            loginlbl.isHidden = true
            
            if tapkey == "flight" {
                flightSelected()
                didTaponUpcommingBtnAction()
            }else {
                hotelSelected()
                hotelkeystr = "upcoming"
                callHotelBookingsAPI()
            }
            
        }else {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            setupTableViewWenNoLogin()
            btnsView.isUserInteractionEnabled = false
            btnsView.alpha = 0.3
            satckView.isHidden = true
            loginlbl.isHidden = false
            setAttributedString(str1: "Login To View Your Bookings")
        }
    }
    
    
    
    @objc func logindon() {
        if tapkey == "flight" {
            btnsView.isUserInteractionEnabled = true
            btnsView.alpha = 1
            satckView.isHidden = false
            loginlbl.isHidden = true
            flightSelected()
            didTaponUpcommingBtnAction()
        }else {
            hotelSelected()
            hotelkeystr = "upcoming"
            loginlbl.isHidden = true
            callHotelBookingsAPI()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = MyBookingViewModel(self)
    }
    
    
    func setupUI() {
        self.view.backgroundColor = .WhiteColor
        
        loginlbl.isHidden = true
        upcomingBtn.setTitle("", for: .normal)
        upcomingBtn.tag = 1
        upcomingBtn.addTarget(self, action: #selector(didtapOnButtoninMyBookingsScreen(_:)), for: .touchUpInside)
        
        completedBtn.setTitle("", for: .normal)
        completedBtn.tag = 2
        completedBtn.addTarget(self, action: #selector(didtapOnButtoninMyBookingsScreen(_:)), for: .touchUpInside)
        
        cancelledBtn.setTitle("", for: .normal)
        cancelledBtn.tag = 3
        cancelledBtn.addTarget(self, action: #selector(didtapOnButtoninMyBookingsScreen(_:)), for: .touchUpInside)
        
        
        setuplabels(lbl: upcominglbl, text: "Upcoming", textcolor: .AppNavBackColor, font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: completedlbl, text: "Completed", textcolor: .AppLabelColor.withAlphaComponent(0.50), font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: cancelledlbl, text: "Cancelled", textcolor: .AppLabelColor.withAlphaComponent(0.50), font: .LatoRegular(size: 14), align: .center)
        
        upcomingul.backgroundColor = .AppNavBackColor
        completedul.backgroundColor = .WhiteColor
        cancelledul.backgroundColor = .WhiteColor
        
        commonTableView.backgroundColor = .AppHolderViewColor
        commonTableView.registerTVCells(["MyBookingsTVCells","HotelMyBookingTVCell"])
        
    }
    
    
    @objc func didtapOnButtoninMyBookingsScreen(_ sender:UIButton){
        switch sender.tag {
            
        case 1:
            didTaponUpcommingBtnAction()
            break
            
        case 2:
            didTapOnCompletedBtnAction()
            break
            
        case 3:
            didTapOnCancelledBtnAction()
            break
            
        default:
            break
        }
        
    }
    
    
    func didTaponUpcommingBtnAction() {
        upcomingul.backgroundColor = .AppNavBackColor
        completedul.backgroundColor = .WhiteColor
        cancelledul.backgroundColor = .WhiteColor
        setuplabels(lbl: upcominglbl, text: "Upcoming", textcolor: .AppNavBackColor, font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: completedlbl, text: "Completed", textcolor: .AppLabelColor.withAlphaComponent(0.50), font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: cancelledlbl, text: "Cancelled", textcolor: .AppLabelColor.withAlphaComponent(0.50), font: .LatoRegular(size: 14), align: .center)
        
        
        if tapkey == "flight" {
            callUpcommingBookingsAPI()
        }else {
            hotelkeystr = "upcoming"
            callHotelBookingsAPI()
        }
    }
    
    func didTapOnCompletedBtnAction() {
        completedul.backgroundColor = .AppNavBackColor
        upcomingul.backgroundColor = .WhiteColor
        cancelledul.backgroundColor = .WhiteColor
        
        setuplabels(lbl: upcominglbl, text: "Upcoming", textcolor: .AppLabelColor.withAlphaComponent(0.50), font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: completedlbl, text: "Completed", textcolor: .AppNavBackColor, font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: cancelledlbl, text: "Cancelled", textcolor: .AppLabelColor.withAlphaComponent(0.50), font: .LatoRegular(size: 14), align: .center)
        
        
        if tapkey == "flight" {
            callCompletedBookingsAPI()
        }else {
            hotelkeystr = "confirmed"
            callHotelBookingsAPI()
        }
    }
    
    func didTapOnCancelledBtnAction() {
        cancelledul.backgroundColor = .AppNavBackColor
        completedul.backgroundColor = .WhiteColor
        upcomingul.backgroundColor = .WhiteColor
        
        setuplabels(lbl: upcominglbl, text: "Upcoming", textcolor: .AppLabelColor.withAlphaComponent(0.50), font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: completedlbl, text: "Completed", textcolor: .AppLabelColor.withAlphaComponent(0.50), font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: cancelledlbl, text: "Cancelled", textcolor: .AppNavBackColor, font: .LatoRegular(size: 14), align: .center)
        
        
        if tapkey == "flight" {
            callCancelledBookingsAPI()
        }else {
            hotelkeystr = "cancelled"
            callHotelBookingsAPI()
        }
    }
    
    
    
    
    
    
    func flightSelected() {
        tapkey = "flight"
        
        flightView.backgroundColor = .WhiteColor
        flightBtnlbl.textColor = .AppLabelColor
        
        hotelView.backgroundColor = .AppBtnColor
        hotelbtnlbl.textColor = .BtnTitleColor
        
        
        didTaponUpcommingBtnAction()
    }
    
    
    func hotelSelected() {
        tapkey = "hotel"
        flightView.backgroundColor = .AppBtnColor
        flightBtnlbl.textColor = .BtnTitleColor
        
        hotelView.backgroundColor = .WhiteColor
        hotelbtnlbl.textColor = .AppBtnColor
        
        didTaponUpcommingBtnAction()
    }
    
    
    @IBAction func didTapOnFlightSelectedBtnAction(_ sender: Any) {
        flightSelected()
    }
    
    
    
    @IBAction func didTapOnHotelBtnAction(_ sender: Any) {
        hotelSelected()
    }
    
    
    
    //MARK: - didTapOnVoucherBtnAction
    override func didTapOnVoucherBtnAction(cell: HotelMyBookingTVCell) {
        
        print(cell.pdfUrlString)
        
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.gotoAboutUsVC(title: "Vocher Details", url: cell.pdfUrlString)
        }
        
    }
    
    
    func gotoAboutUsVC(title:String,url:String) {
        guard let vc = LoadWebViewVC.newInstance.self else {return}
        vc.urlString = url
        vc.isVcFrom = "voucher"
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        self.present(vc, animated: true)
        
    }
    
   
    
}


extension MyBookingVC:MyBookingViewModelDelegate {
    
    
    
    
    func callUpcommingBookingsAPI() {
        loderBool = "normal"
        payload.removeAll()
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        vm?.CALL_UPCOMMING_BOOKINGS_API(dictParam: payload)
    }
    
    
    func callCompletedBookingsAPI() {
        loderBool = "normal"
        payload.removeAll()
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        vm?.CALL_COMPLETED_BOOKINGS_API(dictParam: payload)
    }
    
    func callCancelledBookingsAPI() {
        loderBool = "normal"
        payload.removeAll()
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        vm?.CALL_CANCELLED_BOOKINGS_API(dictParam: payload)
    }
    
    
    
    func upcommingbookingsdetails(response: MyBookingModel) {
        loderBool = "normal"
        DispatchQueue.main.async {
            self.setupTVCells(flightdata: response.flight_data ?? [], key1: "completed")
        }
    }
    
    func completedbookingsdetails(response: MyBookingModel) {
        loderBool = "normal"
        DispatchQueue.main.async {
            self.setupTVCells(flightdata: response.flight_data ?? [], key1: "completed")
            
        }
    }
    
    func cancelledbookingsdetails(response: MyBookingModel) {
        loderBool = "normal"
        DispatchQueue.main.async {
            self.setupTVCells(flightdata: response.flight_data ?? [], key1: "cancel")
        }
    }
    
    
    func setupTVCells(flightdata:[MyBookingsFlightData],key1:String) {
        tablerow.removeAll()
        loginlbl.text = ""
        TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
        
        flightdata.forEach { i in
            i.summary?.forEach({ k in
                tablerow.append(TableRow(title:"j.access_key",
                                         fromTime: k.origin?.time,
                                         toTime:k.destination?.time,
                                         fromCity: k.origin?.city,
                                         toCity: k.destination?.city,
                                         fromdate: k.origin?.date,
                                         todate: k.destination?.date,
                                         noosStops: "\(k.no_of_stops ?? 0) Stops",
                                         airlineslogo: k.operator_image,
                                         airlinesCode:"(\(k.operator_code ?? "")-\(k.operator_name ?? ""))",
                                         kwdprice:"\(flightdata.first?.transaction?.currency ?? ""):\(flightdata.first?.transaction?.fare ?? "")",
                                         travelTime: k.duration,
                                         key: key1,
                                         cellType:.MyBookingsTVCells))
                
            })
        }
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
        
        if flightdata.count == 0 {
            tablerow.removeAll()
            
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
            
            commonTVData = tablerow
            commonTableView.reloadData()
        }
        
    }
    
    
    
    func setupTableViewWenNoLogin() {
        tablerow.removeAll()
        //   TableViewHelper.EmptyMessage(message: "Login To View Your Bookings", tableview: commonTableView, vc: self)
        
        
        loginlbl.text = "Login To View Your Bookings"
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
}



extension MyBookingVC {
    
    
    func callHotelBookingsAPI() {
        
        loderBool = "normal"
        payload.removeAll()
        payload["userid"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        vm?.CALL_BOOKINGS_HOTEL_API(dictParam: payload)
        
    }
    
    
    func hotelmybookingDetails(response: HotelMyBookingModel) {
        
        
        cancelledbookingdetails = response.cancelled_booking_details ?? []
        Upcomingbookingdetails = response.upcoming_booking_details ?? []
        Confirmedbookingdetails = response.confirmed_booking_details ?? []
        
        
        DispatchQueue.main.async {[self] in
            switch hotelkeystr {
                
            case "upcoming":
                setupHotelUpcomingTVCells(detials: Upcomingbookingdetails)
                break
                
            case "confirmed":
                setupHotelConfirmedTVCells(details: Confirmedbookingdetails)
                break
                
            case "cancelled":
                setupHotelCancelledTVCells(details: cancelledbookingdetails)
                break
                
                
            default:
                break
            }
        }
    }
    
    
    
    func setupHotelUpcomingTVCells(detials:[Upcoming_booking_details]) {
        tablerow.removeAll()
        
        
        
        
        
        if detials.count > 0 {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            detials.forEach { i in
                
                
                tablerow.append(TableRow(title:i.hotel_name,
                                         subTitle: i.hotel_location,
                                         text: i.hotel_check_out,
                                         buttonTitle: i.hotel_check_in,
                                         tempText: i.pdf_url,
                                         cellType:.HotelMyBookingTVCell))
            }
            
        }else {
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
        }
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    func setupHotelCancelledTVCells(details:[Cancelled_booking_details]) {
        
        tablerow.removeAll()
        
        if details.count > 0 {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            details.forEach { i in
                
                
                tablerow.append(TableRow(title:i.hotel_name,
                                         subTitle: i.hotel_location,
                                         text: i.hotel_check_out,
                                         buttonTitle: i.hotel_check_in,
                                         tempText: i.pdf_url,
                                         cellType:.HotelMyBookingTVCell))
            }
            
        }else {
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
        }
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    func setupHotelConfirmedTVCells(details:[Confirmed_booking_details]) {
        
        tablerow.removeAll()
        
        
        if details.count > 0 {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            details.forEach { i in
                
                tablerow.append(TableRow(title:i.hotel_name,
                                         subTitle: i.hotel_location,
                                         text: i.hotel_check_out,
                                         buttonTitle: i.hotel_check_in,
                                         tempText: i.pdf_url,
                                         cellType:.HotelMyBookingTVCell))
            }
        }else {
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
        }
        
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
}



extension MyBookingVC {
    
    
    func setAttributedString(str1:String) {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.AppLabelColor,
                      NSAttributedString.Key.font:UIFont.LatoRegular(size: 15),
                      .underlineColor:UIColor.AppBtnColor,
                      .underlineStyle: NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        loginlbl.attributedText = combination
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        loginlbl.addGestureRecognizer(tapGesture)
        loginlbl.isUserInteractionEnabled = true
    }
    
    @objc func labelTapped(gesture:UITapGestureRecognizer) {
        if gesture.didTapAttributedString("Login To View Your Bookings", in: loginlbl) {
            gotoLoginVC()
        }
        
        
        func gotoLoginVC() {
            guard let vc = LoginVC.newInstance.self else {return}
            vc.modalPresentationStyle = .overCurrentContext
            vc.isvcfrom = "mybookings"
            present(vc, animated: true)
        }
        
    }
    
}
