//
//  ContactUsVC.swift
//  HolidaysCenter
//
//  Created by FCI on 02/11/23.
//

import UIKit
import MessageUI

class ContactUsVC: BaseTableVC {
    
    @IBOutlet weak var titlelbl: UILabel!
    
    static var newInstance: ContactUsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ContactUsVC
        return vc
    }
    
    var countrycode = String()
    var keystr = String()
    var tablerow = [TableRow]()
    var name = String()
    var email = String()
    var mobil = String()
    var message = String()
    var payload = [String:Any]()
    var vm:ContactusViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = ContactusViewModel(self)
    }
    
    
    
    func setupUI() {
        
        self.countrycode = defaults.string(forKey: UserDefaultsKeys.mobilecountrycode) ?? "+61"
        commonTableView.backgroundColor = HexColor("#E6E8E7",alpha: 0.65)
        commonTableView.registerTVCells(["ContactUsTVCell",
                                         "CruiseBookingContactTVCell"])
        
        setupTV()
    }
    
    
    func setupTV() {
        tablerow.removeAll()
        
        if keystr == "dashboard" {
            titlelbl.text = "Cruise Booking Contact"
            tablerow.append(TableRow(cellType:.CruiseBookingContactTVCell))
        }else {
            titlelbl.text = "Contact Us"
            tablerow.append(TableRow(cellType:.ContactUsTVCell))
        }
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    override func textViewDidChange(textView:UITextView){
        message = textView.text
    }
    
    override func editingTextField(tf:UITextField){
        switch tf.tag {
        case 1:
            name = tf.text ?? ""
            break
            
        case 2:
            email = tf.text ?? ""
            break
            
        case 3:
            mobil = tf.text ?? ""
            break
            
        default:
            break
        }
    }
    
    
    override func didTapOnAddressBtnAction(cell: ContactUsTVCell) {
        print("didTapOnAddressBtnAction")
    }
    
    override func didTapOnAddressBtnAction(cell: CruiseBookingContactTVCell) {
        print("didTapOnAddressBtnAction")
    }
    
    
    override func didTapOnMailBtnAction(cell: ContactUsTVCell) {
        openEmail(mailstr: "booking@holidayscenter.com")
    }
    
    override func didTapOnMailBtnAction(cell: CruiseBookingContactTVCell) {
        openEmail(mailstr: "booking@holidayscenter.com")
    }
    
    override func didTapOnPhoneBtnAction(cell: ContactUsTVCell) {
        let phoneNumber = "1300450229" // Replace with the actual phone number from your data
        makePhoneCall(number: phoneNumber)
        
    }
    
    override func didTapOnPhoneBtnAction(cell: CruiseBookingContactTVCell) {
        let phoneNumber = "1300450229" // Replace with the actual phone number from your data
        makePhoneCall(number: phoneNumber)
        
    }
    
    
    
    override func didTapOnSubmitBtnAction(cell: ContactUsTVCell) {
        
        if name.isEmpty == true {
            showToast(message: "Enter Full Name")
        }else if email.isEmpty == true {
            showToast(message: "Enter Email")
        }else if mobil.isEmpty == true {
            showToast(message: "Mobile Number")
        }else {
            callAPI()
        }
    }
    
    
    
    override func didTapOnSubmitBtnAction(cell: CruiseBookingContactTVCell) {
        
        if name.isEmpty == true {
            showToast(message: "Enter Full Name")
        }else if email.isEmpty == true {
            showToast(message: "Enter Email")
        }else if mobil.isEmpty == true {
            showToast(message: "Mobile Number")
        }else {
            callCruiseAPI()
        }
    }
    
    
    override func didTapOnRequestCallBackBtnAction(cell:CruiseBookingContactTVCell){
        commonTableView.reloadData()
    }
    
    
    override func didTapOnCountryCodeBtnAction(cell:ContactUsTVCell){
        self.countrycode = cell.countryCodeTF.text ?? ""
        print(countrycode)
    }
    
    override func didTapOnCountryCodeBtnAction(cell:CruiseBookingContactTVCell){
        self.countrycode = cell.countryCodeTF.text ?? ""
        print(countrycode)
    }
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
}


//MARK: - CALL CONTACT US API
extension ContactUsVC:ContactusViewModelDelegate{
    
    
    func callAPI() {
        
        payload.removeAll()
        payload["full_name"] = name
        payload["email"] = email
        payload["phone_number"] = mobil
        payload["message"] = message
        payload["country_code"] = self.countrycode
        
        vm?.CALL_CONTACT_US_API(dictParam: payload)
    }
    
    
    func contactusResponse(response: ContactusModel) {
        if response.status == 1 {
            showToast(message: response.msg ?? "")
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                dismiss(animated: true)
            }
        }
    }
    
}


//MARK: - CALL_CONTACT_CRUISE_API
extension ContactUsVC{
    
    func callCruiseAPI() {
        
        payload.removeAll()
        payload["full_name"] = name
        payload["email"] = email
        payload["phone_number"] = mobil
        payload["message"] = message
        payload["country_code"] = self.countrycode
        
        vm?.CALL_CONTACT_CRUISE_API(dictParam: payload)
    }
    
    
    
    func cruiseContactusResponse(response: CursiModel) {
        if response.status == true {
            showToast(message: response.msg ?? "")
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                dismiss(animated: true)
            }
        }
    }
    
    
}


extension ContactUsVC:MFMailComposeViewControllerDelegate {
    
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
    
    
    func makePhoneCall(number: String) {
        if let phoneURL = URL(string: "tel://\(number)"),
           UIApplication.shared.canOpenURL(phoneURL) {
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        } else {
            // Handle the case where the device cannot make calls or the URL is invalid.
        }
    }
    
    
}
