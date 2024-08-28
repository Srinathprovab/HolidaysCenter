//
//  ModifyHotelSearchVC.swift
//  KuwaitWays
//
//  Created by FCI on 03/05/23.
//

import UIKit

class ModifyHotelSearchVC: BaseTableVC {
    
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    
    var nationalityCode = String()
    var isVcFrom = String()
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    
    static var newInstance: ModifyHotelSearchVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ModifyHotelSearchVC
        return vc
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
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nationalityCode(notification:)), name: NSNotification.Name("nationalityCode"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        
    }
    
    func setupUI() {
        self.view.backgroundColor = .black.withAlphaComponent(0.50)
        nav.backgroundColor = .clear
        nav.titlelbl.text = "Modify Hotel Search"
        nav.titlelbl.textColor = .BtnTitleColor
        nav.backBtn.addTarget(self, action: #selector(backbtnAction(_:)), for: .touchUpInside)
        nav.backBtn.tintColor = .BtnTitleColor
        
        
        commonTableView.backgroundColor = .AppHolderViewColor
        commonTableView.layer.cornerRadius = 8
        commonTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "SearchFlightTVCell",
                                         "LabelTVCell",
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
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    @objc func backbtnAction(_ sender:UIButton) {
        dismiss(animated: true)
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
            
            for roomIndex in 0..<totalRooms {
                if let numChildren = Int(chArray[roomIndex]), numChildren > 0 {
                    var childAges: [String] = []
                    
                    // Check if childAgesArray has data and if it's applicable for the current room
                    if childAgesArray.count > roomIndex && childAgesArray[roomIndex].count > 0 {
                        // Iterate through the selected child ages for the current room
                        for selectedAge in childAgesArray[roomIndex].suffix(numChildren) {
                            childAges.append(selectedAge)
                        }
                        
                    }
                    
                    // Pad the array with "0" for the remaining children
                    for _ in childAges.count..<numChildren {
                        childAges.append("0")
                    }
                    
                    payload["childAge_\(roomIndex + 1)"] = childAges
                }
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
        }else if checkDepartureAndReturnDates(payload, p1: "hotel_checkin", p2: "hotel_checkout") == false ||   checkDepartureAndReturnDates(payload, p1: "hotel_checkout", p2: "hotel_checkin") == false{
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
}
