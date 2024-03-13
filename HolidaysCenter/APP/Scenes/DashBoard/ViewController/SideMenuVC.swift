//
//  SideMenuVC.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit
import MessageUI
import SafariServices
import CallKit

class SideMenuVC: BaseTableVC, ProfileUpdateViewModelDelegate {
    
    @IBOutlet weak var holderView: UIView!
    
    static var newInstance: SideMenuVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SideMenuVC
        return vc
    }
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var vm:LogoutViewmodel?
    var vm1:ProfileUpdateViewModel?
    
    override func viewWillDisappear(_ animated: Bool) {
        menubool = false
    }
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: false)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loginDone), name: NSNotification.Name("logindon"), object: nil)
        
        
        let logstatus = defaults.bool(forKey: UserDefaultsKeys.loggedInStatus)
        if logstatus == true {
            if  menubool == true {
                callApi()
            }
        }
        
        
    }
    
    
    func callApi() {
        payload.removeAll()
        loderBool = "normal"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        vm1?.CALL_SHOW_PROFILE_API(dictParam: payload)
    }
    
    
    func profileDetails(response: ProfileUpdateModel) {
        loderBool = "normal"
        profildata = response.data
        
        DispatchQueue.main.async {[self] in
            setupMenuTVCells()
        }
    }
    
    @objc func loginDone() {
        callApi()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = LogoutViewmodel(self)
        vm1 = ProfileUpdateViewModel(self)
        
    }
    
    
    func setupUI(){
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        holderView.backgroundColor = .clear
        
        
        commonTableView.backgroundColor = .WhiteColor
        commonTableView.registerTVCells(["MenuBGTVCell",
                                         "checkOptionsTVCell",
                                         "EmptyTVCell",
                                         "MenuTitleTVCell",
                                         "AboutusTVCell"])
        
        setupMenuTVCells()
    }
    
    
    
    
    //MARK: - setupMenuTVCells
    func setupMenuTVCells() {
        
        tablerow.removeAll()
        let userloginstatus = defaults.bool(forKey: UserDefaultsKeys.loggedInStatus)
        
        
        tablerow.append(TableRow(cellType:.MenuBGTVCell))
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Bookings",key: "ourproducts", image: "",cellType:.MenuTitleTVCell))
        tablerow.append(TableRow(title:"Flight",key: "menu", image: "menu5",cellType:.checkOptionsTVCell))
        tablerow.append(TableRow(title:"Hotel",key: "menu", image: "menu6",cellType:.checkOptionsTVCell))
        tablerow.append(TableRow(title:"Cruise",key: "menu", image: "htab3",cellType:.checkOptionsTVCell))
        tablerow.append(TableRow(title:"Holidays",key: "menu", image: "holiday",cellType:.checkOptionsTVCell))
        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Traveler Tools",key: "ourproducts", image: "",cellType:.MenuTitleTVCell))
        
        if  userloginstatus == true {
            tablerow.append(TableRow(title:"Check My Bookings",key: "menu", image: "menu1",cellType:.checkOptionsTVCell))
        }
        
        
        
        tablerow.append(TableRow(title:"Offers",key: "mail", image: "offers",cellType:.checkOptionsTVCell))
        tablerow.append(TableRow(title:"Manage Booking",key: "menu", image: "mbooking",cellType:.checkOptionsTVCell))
        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        
        tablerow.append(TableRow(title:"Legal",key: "ourproducts", image: "",cellType:.MenuTitleTVCell))
        tablerow.append(TableRow(cellType:.AboutusTVCell))
        
        
        if  userloginstatus == true {
            tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
            tablerow.append(TableRow(title:"Delete Account",key: "logout", image: "deleteacc",cellType:.checkOptionsTVCell))
            tablerow.append(TableRow(title:"Logout",key: "logout", image: "logout",cellType:.checkOptionsTVCell))
            
        }
        
        
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"info@holidayscenter.com",key: "mail", image: "mail",cellType:.checkOptionsTVCell))
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        
        
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - didTapOnLoginBtn
    override func didTapOnLoginBtn(cell: MenuBGTVCell) {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        isFromVCBool = true
        present(vc, animated: true)
        
    }
    
    
    
    //MARK: - didTapOnEditProfileBtn
    override func didTapOnEditProfileBtn(cell: MenuBGTVCell) {
        guard let vc = EditProfileVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        isFromVCBool = true
        present(vc, animated: true)
    }
    
    
    
    //MARK: - didTapOnMenuOptionBtn
    override func didTapOnMenuOptionBtn(cell:checkOptionsTVCell){
        switch cell.titlelbl.text {
            
        case "Check My Bookings":
            gotoMyBookingVC()
            break
            
        case "Flight":
            gotoBookFlightsVC()
            break
            
        case "Hotel":
            gotoBookHotelsVC()
            // showToast(message: "Hotel module is not available yet. Stay tuned!")
            break
            
        case "Holidays":
            showToast(message: "Holidays module is not available yet. Stay tuned!")
            break
            
            
        case "Cruise":
            //showToast(message: "Cruise module is not available yet. Stay tuned!")
            gotoContactUsVC()
            break
            
        case "Logout":
            loderBool = "normal"
            vm?.CALL_LOgout_API(dictParam: [:])
            break
            
            
        case "Delete Account":
            loderBool = "normal"
            payload.removeAll()
            payload["user_id"]  = defaults.string(forKey: UserDefaultsKeys.userid)
            vm?.CALL_DELETE_USER_ACCOUNT_API(dictParam: payload)
            break
            
            
        case "info@holidayscenter.com":
            openMail()
            break
            
            
        default:
            break
        }
    }
    
    
    
    //MARK: - didTapOnAboutUsLink
    func gotoBookFlightsVC() {
        guard let vc = BookFlightVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        isFromVCBool = true
        present(vc, animated: true)
    }
    
    
    
    //MARK: - gotoBookHotelsVC
    func gotoBookHotelsVC() {
        guard let vc = BookHotelVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        isFromVCBool = true
        present(vc, animated: true)
    }
    
    
    
    //MARK: - gotoMyBookingVC
    func gotoMyBookingVC() {
        guard let vc = DBTabbarController.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.selectedIndex = 1
        isFromVCBool = true
        present(vc, animated: true)
    }
    
    
    
    //MARK: - didTapOnAboutUsLink
    override func didTapOnAboutUsLink(cell: AboutusTVCell) {
        gotoAboutUsVC(keystr: "aboutus")
    }
    
    //MARK: - didTapOnTermsLink
    override func didTapOnTermsLink(cell: AboutusTVCell) {
        gotoAboutUsVC(keystr: "terms")
    }
    
    //MARK: - didTapOnCoockiesLink
    override func didTapOnCoockiesLink(cell: AboutusTVCell) {
        gotoAboutUsVC(keystr: "pp")
    }
    
    
    override func didTapOnContactUs(cell:AboutusTVCell){
        NotificationCenter.default.post(name: NSNotification.Name("contactus"), object: nil)
        gotoContactUsVC()
    }
    
    
    func gotoAboutUsVC(keystr:String) {
        guard let vc = AboutUsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.keystr = keystr
        isFromVCBool = true
        present(vc, animated: true)
    }
    
    func gotoContactUsVC() {
        guard let vc = ContactUsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.keystr = "contactus"
        present(vc, animated: true)
    }
    
    
    
    func openMail() {
        openEmail(mailstr: "info@holidayscenter.com")
    }
    
    
    
}

extension SideMenuVC:LogoutViewmodelDelegate {
    
    
    
    func logoutSucess(response: LoginModel) {
        loderBool = "normal"
        showToast(message: response.data ?? "")
        defaults.set(false, forKey: UserDefaultsKeys.loggedInStatus)
        
        defaults.set("", forKey: UserDefaultsKeys.userid)
        defaults.set("", forKey: UserDefaultsKeys.username)
        defaults.set("", forKey: UserDefaultsKeys.userimg)
        defaults.set("", forKey: UserDefaultsKeys.useremail)
        defaults.set("", forKey: UserDefaultsKeys.usermobile)
        defaults.set("", forKey: UserDefaultsKeys.usermobilecode)
        
        
        DispatchQueue.main.async {[self] in
            setupMenuTVCells()
        }
    }
    
    
    
    func deleteSucess(response: LoginModel) {
        loderBool = "normal"
        showToast(message: response.msg ?? "")
        defaults.set(false, forKey: UserDefaultsKeys.loggedInStatus)
        
        defaults.set("", forKey: UserDefaultsKeys.userid)
        defaults.set("", forKey: UserDefaultsKeys.username)
        defaults.set("", forKey: UserDefaultsKeys.userimg)
        defaults.set("", forKey: UserDefaultsKeys.useremail)
        defaults.set("", forKey: UserDefaultsKeys.usermobile)
        defaults.set("", forKey: UserDefaultsKeys.usermobilecode)
        
        
        DispatchQueue.main.async {[self] in
            setupMenuTVCells()
        }
    }
    
    
}




extension SideMenuVC:MFMailComposeViewControllerDelegate {
    
    @objc func openEmail(mailstr:String) {
        if MFMailComposeViewController.canSendMail() {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            composeVC.setToRecipients([mailstr]) // Set the recipient email address
            
            // Set the email subject
            //    composeVC.setSubject("Hello from Swift!")
            
            // Set the email body
            //   composeVC.setMessageBody("This is the body of the email.", isHTML: false)
            
            present(composeVC, animated: true, completion: nil)
        } else {
            // Handle the case when the device cannot send emails
            print("Device cannot send emails.")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
