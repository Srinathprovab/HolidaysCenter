//
//  BookHotelVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 22/08/22.
//

import UIKit

class BookHotelVC: BaseTableVC {
    
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    
    var nationalityCode = String()
    var isVcFrom = String()
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    let formatter = DateFormatter()
    
    static var newInstance: BookHotelVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookHotelVC
        return vc
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        formatter.dateFormat = "dd-MM-yyyy"
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(nationalityCode(notification:)), name: NSNotification.Name("nationalityCode"), object: nil)
        
        TimerManager.shared.stopTimer()
        addObserveHotelDealsNotification()
    }
    
    @objc func nationalityCode(notification: NSNotification){
        nationalityCode = notification.object as? String ?? ""
    }
    
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: false)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setInitalValues()
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        
    }
    
    func setupUI() {
        self.view.backgroundColor = .WhiteColor
        nav.bg.isHidden = true
        nav.contentView.backgroundColor = .WhiteColor
        nav.titlelbl.textColor = .AppLabelColor
        nav.titlelbl.text = "Book Hotel"
        nav.backBtn.tintColor = .AppLabelColor
        nav.backBtn.addTarget(self, action: #selector(backbtnAction(_:)), for: .touchUpInside)
        
        if screenHeight > 835 {
            navHeight.constant = 130
        }else {
            navHeight.constant = 120
        }
        
        self.view.backgroundColor = .WhiteColor
        commonTableView.backgroundColor = .AppBGcolor
        // commonTableView.isScrollEnabled = false
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "SearchFlightTVCell",
                                         "DashboardDealsTitleTVCell",
                                         "HotelDealsTVCell"])
        
        
        
        appendHotelSearctTvcells(str: "hotel")
        
        
    }
    
    @objc func reload(notification: NSNotification){
        commonTableView.reloadData()
    }
    
    func appendHotelSearctTvcells(str:String) {
        tablerow.removeAll()
        
        tablerow.append(TableRow(key:"hotel",cellType:.SearchFlightTVCell))
        tablerow.append(TableRow(height:10,bgColor: .AppHolderViewColor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"BDiscover the Latest Travel Deals",key: "deals",text:imgPath,height:50,cellType:.DashboardDealsTitleTVCell))
        tablerow.append(TableRow(key1:"hotel",cellType:.HotelDealsTVCell))
        tablerow.append(TableRow(height:100,bgColor: .AppHolderViewColor,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    @objc func backbtnAction(_ sender:UIButton) {
        guard let vc = DBTabbarController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        callapibool = true
        self.present(vc, animated: false)
    }
    
    
    override func didTapOnLocationOrCityBtn(cell:HolderViewTVCell){
        guard let vc = SelectFromCityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.titleStr = "Location/City"
        vc.keyStr = "hotel"
        self.present(vc, animated: false)
    }
    
    override func didtapOnCheckInBtn(cell:DualViewTVCell){
        guard let vc = Calvc.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    override func didtapOnCheckOutBtn(cell:DualViewTVCell){
        guard let vc = CalenderVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    override func didTapOnAddRooms(cell:HolderViewTVCell){
        guard let vc = AddRoomsVCViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    
    func setInitalValues() {
        totalRooms = 1
        adtArray.removeAll()
        chArray.removeAll()
        childAgesArray.removeAll()
        
        adtArray.append("2")
        chArray.append("0")
        
        defaults.set("1", forKey: UserDefaultsKeys.roomcount)
        defaults.set("2", forKey: UserDefaultsKeys.hoteladultscount)
        defaults.set("0", forKey: UserDefaultsKeys.hotelchildcount)
        let a = Int(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "") ?? 0
        let b = Int(defaults.string(forKey: UserDefaultsKeys.hotelchildcount) ?? "") ?? 0
        defaults.set("\(a + b)", forKey: UserDefaultsKeys.guestcount)
        
        defaults.set("Rooms \(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? ""),Adults \(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "")", forKey: UserDefaultsKeys.selectPersons)
        
    }
    
    
    
    override func didTapOnHotelNationalityBtnAction(cell:HolderViewTVCell){
        gotoNationalityVC()
    }
    
    
    func gotoNationalityVC(){
        guard let vc = NationalityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    override func didTapOnSearchHotelsBtn(cell:ButtonTVCell){
        
        payload.removeAll()
        payload["city"] = defaults.string(forKey: UserDefaultsKeys.locationcity)
        payload["hotel_destination"] = defaults.string(forKey: UserDefaultsKeys.locationid)
        payload["hotel_checkin"] = defaults.string(forKey: UserDefaultsKeys.checkin)
        payload["hotel_checkout"] = defaults.string(forKey: UserDefaultsKeys.checkout)
        
        payload["rooms"] = "\(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "1")"
        payload["adult"] = adtArray
        payload["child"] = chArray
        
        if starRatingInputArray.count > 0 {
            payload["star_rating"] = starRatingInputArray
        }
        
        
        if defaults.string(forKey: UserDefaultsKeys.hotelchildcount) == "0" {
            payload["childAge_1"] = [""]
        }else {
            
//            for roomIndex in 0..<totalRooms {
//                if let numChildren = Int(chArray[roomIndex]), numChildren > 0 {
//                    var childAges: [String] = []
//                    
//                    // Check if childAgesArray has data and if it's applicable for the current room
//                    if childAgesArray.count > roomIndex && childAgesArray[roomIndex].count > 0 {
//                        // Iterate through the selected child ages for the current room
//                        for selectedAge in childAgesArray[roomIndex].suffix(numChildren) {
//                            childAges.append(selectedAge)
//                        }
//                        
//                    }
//                    
//                    // Pad the array with "0" for the remaining children
//                    for _ in childAges.count..<numChildren {
//                        childAges.append("0")
//                    }
//                    
//                    payload["childAge_\(roomIndex + 1)"] = childAges
//                }
//            }
            
            // Assuming chArray is an array of strings representing the number of children per room
            for roomIndex in 0..<totalRooms {
                // Get the number of children for the current room
                if let numChildren = Int(chArray[roomIndex]), numChildren > 0 {
                    var childAges: [String] = []
                    
                    // Check if childAgesArray has data for the current room
                    if childAgesArray.count > roomIndex && childAgesArray[roomIndex].count > 0 {
                        // Iterate through the selected child ages for the current room
                        for selectedAge in childAgesArray[roomIndex].suffix(numChildren) {
                            childAges.append(selectedAge)
                        }
                    }

                    // Pad the array with "0" for any remaining children if necessary
                    for _ in childAges.count..<numChildren {
                        childAges.append("0")
                    }

                    // Set the payload for the current room (childAge_1, childAge_2, etc.)
                    payload["childAge_\(roomIndex + 1)"] = childAges
                }
            }

            // Check if there are no children at all and handle the case
            if defaults.string(forKey: UserDefaultsKeys.hotelchildcount) == "0" {
                payload["childAge_1"] = [""]
            }



            
        }
        
        payload["nationality"] = defaults.string(forKey: UserDefaultsKeys.hnationalitycode) ?? "KW"
        payload["currency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        if defaults.string(forKey: UserDefaultsKeys.locationcity) == "Add City" || defaults.string(forKey: UserDefaultsKeys.locationcity) == nil{
            showToast(message: "Enter Hotel or City ")
        }else if defaults.string(forKey: UserDefaultsKeys.checkin) == "Add Check In Date" || defaults.string(forKey: UserDefaultsKeys.checkin) == nil{
            showToast(message: "Enter Checkin Date")
        }else if defaults.string(forKey: UserDefaultsKeys.checkout) == "Add Check Out Date" || defaults.string(forKey: UserDefaultsKeys.checkout) == nil{
            showToast(message: "Enter Checkout Date")
        }else if defaults.string(forKey: UserDefaultsKeys.checkout) == defaults.string(forKey: UserDefaultsKeys.checkin) {
            showToast(message: "Enter Different Dates")
        }
        
//        else if  let checkinDate = defaults.string(forKey: UserDefaultsKeys.checkin),
//                  let checkoutDate = defaults.string(forKey: UserDefaultsKeys.checkout),
//                  let checkin = formatter.date(from: checkinDate),
//                  let checkout = formatter.date(from: checkoutDate),
//                  checkin > checkout {
//            
//            
//            showToast(message: "Invalid Date")
//        }
        
        else if defaults.string(forKey: UserDefaultsKeys.roomcount) == "" {
            showToast(message: "Add Rooms For Booking")
        }else if defaults.string(forKey: UserDefaultsKeys.hnationality) == nil {
            showToast(message: "Please Select Nationality.")
        }
        
//        else if checkDepartureAndReturnDates(payload, p1: "hotel_checkin", p2: "hotel_checkout") == false ||   checkDepartureAndReturnDates(payload, p1: "hotel_checkout", p2: "hotel_checkin") == false{
//            showToast(message: "Invalid Date")
//        }
        
        
        else {
            
            
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
        defaults.setValue(starRatingInputArray, forKey: UserDefaultsKeys.starRatingInputArray)
        loderBool = "hotel"
        defaults.set(false, forKey: "hoteltfilteronce")
        guard let vc = HotelSearchResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.nationalityCode = "IN"
        callapibool = true
        vc.payload = payload
        present(vc, animated: true)
    }
    
    
    
    //MARK: - donedatePicker cancelDatePicker
    
    override func donedatePicker(cell:SearchFlightTVCell){
   
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



extension BookHotelVC {
    
    func addObserveHotelDealsNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(hoteldealstap), name: Notification.Name("hoteldealstap"), object: nil)
    }
    
    
    @objc func hoteldealstap(ns:NSNotification) {
        if let userinfo = ns.userInfo as? [String:Any] {
            defaults.set("Hotel", forKey: UserDefaultsKeys.tabselect)
            
//            defaults.set(userinfo["city"] as? String, forKey: UserDefaultsKeys.locationcity)
//            defaults.set(userinfo["hotel_destination"] as? String, forKey: UserDefaultsKeys.locationid)
//            defaults.set(convertDateFormat(inputDate: userinfo["hotel_checkin"] as? String ?? "", f1: "yyyy-MM-dd", f2: "dd-MM-yyyy"), forKey: UserDefaultsKeys.checkin)
//            defaults.set(convertDateFormat(inputDate: userinfo["hotel_checkout"] as? String ?? "", f1: "yyyy-MM-dd", f2: "dd-MM-yyyy"), forKey: UserDefaultsKeys.checkout)
//            defaults.set("IN", forKey: UserDefaultsKeys.hnationalitycode)
//            defaults.set("KWD", forKey: UserDefaultsKeys.selectedCurrency)
//            
//            payload.removeAll()
//            payload["city"] = userinfo["city"] as? String
//            payload["hotel_destination"] = userinfo["hotel_destination"] as? String
//            payload["hotel_checkin"] = userinfo["hotel_checkin"] as? String
//            payload["hotel_checkout"] = userinfo["hotel_checkout"] as? String
//            
//            payload["rooms"] = "1"
//            payload["adult"] = ["2"]
//            payload["child"] = ["0"]
//            
//            payload["nationality"] = "IN"
//            payload["language"] = "english"
//            payload["currency"] = defaults.string(forKey:UserDefaultsKeys.selectedCurrency) ?? "KWD"
//            
//            payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
            
           // gotoSearchHotelsResultVC()
          //  commonTableView.reloadData()
            
            //showToast(message: "Hotel module is not available yet. Stay tuned!")
            
        }
    }
    
}
