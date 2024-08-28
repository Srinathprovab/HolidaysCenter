//
//  DashBoardVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 16/08/22.
//

import UIKit

class DashBoardVC: BaseTableVC, IndexPageViewModelDelegate, CountryListViewModelDelegate {
    
    
    
    static var newInstance: DashBoardVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? DashBoardVC
        return vc
    }
    
   
    var tablerow = [TableRow]()
    var vm1:CountryListViewModel?
    var vm:IndexPageViewModel?
    //MARK: - side menu initial setup
    private var sideMenuViewController: SideMenuVC!
    private var sideMenuShadowView: UIView!
    private var sideMenuRevealWidth: CGFloat = 260
    private let paddingForRotation: CGFloat = 150
    private var isExpanded: Bool = false
    private var draggingIsEnabled: Bool = false
    private var panBaseLocation: CGFloat = 0.0
    
    //MARK: - Expand/Collapse the side menu by changing trailing's constant
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var revealSideMenuOnTop: Bool = true
    var gestureEnabled: Bool = true
    var payload = [String:Any]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        addObserver()
        
        if callapibool == true {
            callAPI()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupMenu()
        vm = IndexPageViewModel(self)
        vm1 = CountryListViewModel(self)
        
    }
    
    
    
    //MARK: - CALL_INDEX_PAGE_API
    
    func callAPI() {
        vm?.CALL_INDEX_PAGE_API(dictParam: [:])
    }
    
    
    func indexPageDetails(response: IndexPageModel) {
        imgPath = response.image_path ?? ""
        sliderimagesflight = response.flight_top_destinations1 ?? []
        sliderimageshotel = response.top_dest_hotel ?? []
        
        currencyType = response.currency ?? ""
        perfectholidays = response.perfect_holidays ?? []
        
        DispatchQueue.main.async {[self] in
            setupTV()
        }
        DispatchQueue.main.async {[self] in
            callcountryLiatAPI()
        }
    }
    
    
    
    func callcountryLiatAPI() {
        // vm1?.CALL_GET_COUNTRY_LIST_API(dictParam: [:])
    }
    
    func countryList(response: CountryListModel) {
        // countrylist = response.data?.country_list ?? []
    }
    
    
    
    
    func setupTV() {
        self.view.backgroundColor = .AppBGcolor
        
        
        
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "SelectTabTVCell",
                                         "HotelDealsTVCell",
                                         "DashboardDealsTitleTVCell"])
        appendTVCells()
    }
    
    
    func appendTVCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType:.SelectTabTVCell))
        tablerow.append(TableRow(height:10,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
        
        if sliderimagesflight.count != 0 {
            tablerow.append(TableRow(title:"Top Flight Destinations ",key: "deals", text:imgPath, height:50,cellType:.DashboardDealsTitleTVCell))
            tablerow.append(TableRow(height:18,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
            tablerow.append(TableRow(key1:"flight",cellType:.HotelDealsTVCell))
        }
        
        tablerow.append(TableRow(height:18,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
        
        if sliderimageshotel.count != 0 {
            tablerow.append(TableRow(title:"Discover the Latest Travel Deals ",key: "deals",text:imgPath,height:50,cellType:.DashboardDealsTitleTVCell))
            tablerow.append(TableRow(height:18,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
            tablerow.append(TableRow(key1:"hotel",cellType:.HotelDealsTVCell))
        }
        
        
        tablerow.append(TableRow(height:18,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
        
        if sliderimageshotel.count != 0 {
            tablerow.append(TableRow(title:"Last-Minute Holiday Vacation Deals ",key: "deals",text:imgPath,height:50,cellType:.DashboardDealsTitleTVCell))
            tablerow.append(TableRow(height:18,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
            tablerow.append(TableRow(key1:"holiday",cellType:.HotelDealsTVCell))
        }
        
        tablerow.append(TableRow(height:100,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    override func didTapOnDashboardTab(cell: SelectTabTVCell) {
        
        let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect)
        switch tabselect {
        case "Flight":
            gotoBookingFlightVC()
            break
            
        case "Hotel":
            gotoBookHotelVC()
            break
            
            
        case "Holidays":
            showToast(message: "Holidays module is not available yet. Stay tuned!")
            break
            
            
        case "Cruise":
            //            showToast(message: "Cruise module is not available yet. Stay tuned!")
            gotoContactUsVC()
            break
            
            
        default:
            break
        }
    }
    
    
    func gotoBookingFlightVC() {
        guard let vc = BookFlightVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        isFromVCBool = true
        callapibool = true
        self.present(vc, animated: true)
    }
    
    func gotoBookHotelVC() {
        guard let vc = BookHotelVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.isVcFrom = "dashboard"
        isFromVCBool = true
        self.present(vc, animated: true)
    }
    
    
    func gotoSideMenuVC() {
        guard let vc = SideMenuVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        isFromVCBool = true
        self.present(vc, animated: false)
    }
    
    func gotoContactUsVC(){
        guard let vc = ContactUsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        isFromVCBool = true
        vc.keystr = "dashboard"
        self.present(vc, animated: true)
    }
    
    override func didTapOnLaungageBtn(cell:SelectTabTVCell){
        guard let vc = SelectLanguageVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        isFromVCBool = true
        self.present(vc, animated: true)
    }
    
    
    
    
    
    
    //MARK:  Call this Button Action from the View Controller you want to Expand/Collapse when you tap a button
    override func didTapOnMenuBtn(cell:SelectTabTVCell){
        NotificationCenter.default.post(name: NSNotification.Name("callprofileapi"), object: nil)
        self.tabBarController?.tabBar.isHidden = true
        self.sideMenuState(expanded: self.isExpanded ? false : true)
    }
    
    
    
    
    //MARK: SETUP SIDE MENU
    func setupMenu(){
        menubool = true
        //MARK: Shadow Background View
        self.sideMenuShadowView = UIView(frame: self.view.bounds)
        self.sideMenuShadowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.sideMenuShadowView.backgroundColor = .black
        self.sideMenuShadowView.alpha = 0.0
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapGestureRecognizer))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.delegate = self
        self.sideMenuShadowView.addGestureRecognizer(tapGestureRecognizer)
        if self.revealSideMenuOnTop {
            view.insertSubview(self.sideMenuShadowView, at: 1)
        }
        
        //MARK: Side Menu
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self.sideMenuViewController = storyboard.instantiateViewController(withIdentifier: "SideMenuVC") as? SideMenuVC
        view.insertSubview(self.sideMenuViewController!.view, at: self.revealSideMenuOnTop ? 2 : 0)
        addChild(self.sideMenuViewController!)
        self.sideMenuViewController!.didMove(toParent: self)
        
        //MARK: Side Menu AutoLayout
        self.sideMenuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        if self.revealSideMenuOnTop {
            self.sideMenuTrailingConstraint = self.sideMenuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -self.sideMenuRevealWidth - self.paddingForRotation)
            self.sideMenuTrailingConstraint.isActive = true
        }
        NSLayoutConstraint.activate([
            self.sideMenuViewController.view.widthAnchor.constraint(equalToConstant: self.sideMenuRevealWidth + 50),
            self.sideMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.sideMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        //MARK: Side Menu Gestures
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGestureRecognizer.delegate = self
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    //MARK: Keep the state of the side menu (expanded or collapse) in rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = self.isExpanded ? 0 : (-self.sideMenuRevealWidth - self.paddingForRotation)
            }
        }
    }
    
    func animateShadow(targetPosition: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            //MARK: When targetPosition is 0, which means side menu is expanded, the shadow opacity is 0.6
            self.sideMenuShadowView.alpha = (targetPosition == 0) ? 0.6 : 0.0
        }
    }
    
    
    
    func sideMenuState(expanded: Bool) {
        if expanded {
            NotificationCenter.default.post(name: NSNotification.Name("callprofileapi"), object: nil)
            self.tabBarController?.tabBar.isHidden = true
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? 0 : self.sideMenuRevealWidth) { _ in
                self.isExpanded = true
            }
            // Animate Shadow (Fade In)
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.6 }
            menubool = true
        }
        else {
            self.tabBarController?.tabBar.isHidden = false
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? (-self.sideMenuRevealWidth - self.paddingForRotation) : 0) { _ in
                self.isExpanded = false
            }
            // Animate Shadow (Fade Out)
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.0 }
            
        }
    }
    
    func animateSideMenu(targetPosition: CGFloat, completion: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .layoutSubviews, animations: {
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = targetPosition
                self.view.layoutIfNeeded()
            }
            else {
                self.view.subviews[1].frame.origin.x = targetPosition
            }
        }, completion: completion)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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


extension DashBoardVC: UIGestureRecognizerDelegate {
    @objc func TapGestureRecognizer(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if self.isExpanded {
                self.sideMenuState(expanded: false)
            }
        }
    }
    
    // Close side menu when you tap on the shadow background view
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.sideMenuViewController.view))! {
            return false
        }
        return true
    }
    
    // Dragging Side Menu
    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
        
        guard gestureEnabled == true else { return }
        
        let position: CGFloat = sender.translation(in: self.view).x
        let velocity: CGFloat = sender.velocity(in: self.view).x
        
        switch sender.state {
        case .began:
            
            // If the user tries to expand the menu more than the reveal width, then cancel the pan gesture
            if velocity > 0, self.isExpanded {
                sender.state = .cancelled
            }
            
            // If the user swipes right but the side menu hasn't expanded yet, enable dragging
            if velocity > 0, !self.isExpanded {
                self.draggingIsEnabled = true
            }
            // If user swipes left and the side menu is already expanded, enable dragging
            else if velocity < 0, self.isExpanded {
                self.draggingIsEnabled = true
            }
            
            if self.draggingIsEnabled {
                // If swipe is fast, Expand/Collapse the side menu with animation instead of dragging
                let velocityThreshold: CGFloat = 550
                if abs(velocity) > velocityThreshold {
                    self.sideMenuState(expanded: self.isExpanded ? false : true)
                    self.draggingIsEnabled = false
                    return
                }
                
                if self.revealSideMenuOnTop {
                    self.panBaseLocation = 0.0
                    if self.isExpanded {
                        self.panBaseLocation = self.sideMenuRevealWidth
                    }
                }
            }
            
        case .changed:
            
            // Expand/Collapse side menu while dragging
            if self.draggingIsEnabled {
                if self.revealSideMenuOnTop {
                    // Show/Hide shadow background view while dragging
                    let xLocation: CGFloat = self.panBaseLocation + position
                    let percentage = (xLocation * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth
                    
                    let alpha = percentage >= 0.6 ? 0.6 : percentage
                    self.sideMenuShadowView.alpha = alpha
                    
                    // Move side menu while dragging
                    if xLocation <= self.sideMenuRevealWidth {
                        self.sideMenuTrailingConstraint.constant = xLocation - self.sideMenuRevealWidth
                    }
                }
                else {
                    if let recogView = sender.view?.subviews[1] {
                        // Show/Hide shadow background view while dragging
                        let percentage = (recogView.frame.origin.x * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth
                        
                        let alpha = percentage >= 0.6 ? 0.6 : percentage
                        self.sideMenuShadowView.alpha = alpha
                        
                        // Move side menu while dragging
                        if recogView.frame.origin.x <= self.sideMenuRevealWidth, recogView.frame.origin.x >= 0 {
                            recogView.frame.origin.x = recogView.frame.origin.x + position
                            sender.setTranslation(CGPoint.zero, in: view)
                        }
                    }
                }
            }
        case .ended:
            self.draggingIsEnabled = false
            // If the side menu is half Open/Close, then Expand/Collapse with animation
            if self.revealSideMenuOnTop {
                let movedMoreThanHalf = self.sideMenuTrailingConstraint.constant > -(self.sideMenuRevealWidth * 0.5)
                self.sideMenuState(expanded: movedMoreThanHalf)
            }
            else {
                if let recogView = sender.view?.subviews[1] {
                    let movedMoreThanHalf = recogView.frame.origin.x > self.sideMenuRevealWidth * 0.5
                    self.sideMenuState(expanded: movedMoreThanHalf)
                }
            }
        default:
            break
        }
    }
}




extension DashBoardVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reloadTV"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("tryagain"), object: nil)
        
        addObserveFlightDealsNotification()
        addObserveHotelDealsNotification()
        addObserveHolidaysDealsNotification()
        
        
    }
    
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
            if callapibool == true {
                callAPI()
            }
        }
    }
    
    //MARK: - resultnil
    @objc func resultnil() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "noresult"
        self.present(vc, animated: true)
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "nointernet"
        self.present(vc, animated: true)
    }
    
    
}


extension DashBoardVC {
    
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
    
    
    func gotoSearchFlightResultVC(input:[String:Any]) {
        defaults.set(false, forKey: "flightfilteronce")
        guard let vc = SearchFlightResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.payload = input
        callapibool = true
        self.present(vc, animated: true)
    }
}




extension DashBoardVC {
    
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
//            payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
            
          //  gotoSearchHotelsResultVC()
            gotoBookHotelVC()
            // showToast(message: "Hotel module is not available yet. Stay tuned!")
            
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



extension DashBoardVC {
    func  addObserveHolidaysDealsNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(holidaysdealstap), name: Notification.Name("holidaysdealstap"), object: nil)
    }
    
    
    @objc func holidaysdealstap() {
        showToast(message: "Holidays module is not available yet. Stay tuned!")
    }
}
