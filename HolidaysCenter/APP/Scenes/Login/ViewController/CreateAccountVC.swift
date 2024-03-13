//
//  CreateAccountVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 16/08/22.
//

import UIKit
import MaterialComponents
import IQKeyboardManager

class CreateAccountVC: BaseTableVC, RegisterUserViewModelDelegate {
    
    
    var tablerow = [TableRow]()
    static var newInstance: CreateAccountVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? CreateAccountVC
        return vc
    }
    
    var countrycode = String()
    var fname = String()
    var lname = String()
    var email = String()
    var mobile = String()
    var pass = String()
    var cpass = String()
    var payload = [String:Any]()
    var vm:RegisterUserViewModel?
    
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: false)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
        
        
        countryCode = defaults.string(forKey: UserDefaultsKeys.mobilecountrycode) ?? ""
    }
    
    
    
    
    
    
    @objc func reload(notification: NSNotification){
        commonTableView.beginUpdates()
        commonTableView.endUpdates()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupTV()
        vm = RegisterUserViewModel(self)
        
        
    }
    
    func setupTV() {
        
        self.countrycode = defaults.string(forKey: UserDefaultsKeys.mobilecountrycode) ?? "+61"
        commonTableView.backgroundColor = .AppBackgroundColor
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "CreateAccountTVCell"])
        
        appendLoginTvcells()
    }
    
    
    func appendLoginTvcells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(height:30,bgColor: .AppBackgroundColor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType:.CreateAccountTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    override func editingMDCOutlinedTextField(tf:MDCOutlinedTextField){
        setcolor(tf: tf, color: .black)
        switch tf.tag {
        case 1:
            fname = tf.text ?? ""
            break
            
        case 2:
            lname = tf.text ?? ""
            break
            
        case 3:
            email = tf.text ?? ""
            break
            
        case 4:
            mobile = tf.text ?? ""
            break
            
        case 5:
            pass = tf.text ?? ""
            break
            
        case 6:
            cpass = tf.text ?? ""
            break
        default:
            break
        }
    }
    
    
    
    override func didTapOnCountryCodeBtnAction(cell: CreateAccountTVCell) {
        self.countrycode = cell.countryCodeTF.text ?? ""
    }
    
    
    func setcolor(tf:MDCOutlinedTextField,color:UIColor) {
        tf.setOutlineColor(color, for: .normal)
        tf.setOutlineColor(color, for: .editing)
    }
    
    override func didTapOnCreateAccountBtnBtnAction(cell: CreateAccountTVCell) {
        
        
        if fname.isEmpty == true {
            showToast3(message: "Enter First Name")
            setcolor(tf: cell.fnameTF, color: .red)
        }else  if lname.isEmpty == true {
            showToast3(message: "Enter Last Name")
            setcolor(tf: cell.lnameTF, color: .red)
        }else  if email.isEmpty == true {
            showToast3(message: "Enter Email Address")
            setcolor(tf: cell.emailTF, color: .red)
        }else  if email.isValidEmail() == false {
            showToast3(message: "Enter Valid Email address ")
            setcolor(tf: cell.emailTF, color: .red)
        }else if mobile.isEmpty == true {
            showToast3(message: "Enter Mobile Number")
            setcolor(tf: cell.mobileTF, color: .red)
        }else if mobilenoMaxLengthBool == false {
            showToast3(message: "Enter Valid Mobile Number")
            setcolor(tf: cell.mobileTF, color: .red)
        }else  if pass.isEmpty == true {
            showToast3(message: "Enter Password")
            setcolor(tf: cell.createPassTF, color: .red)
            setcolor(tf: cell.createPassTF, color: .red)
        }else  if cpass.isEmpty == true {
            showToast3(message: "Enter Conform Password")
            setcolor(tf: cell.confPassTF, color: .red)
            setcolor(tf: cell.confPassTF, color: .red)
        }else  if pass != cpass {
            showToast3(message: "Password Should Match")
            setcolor(tf: cell.createPassTF, color: .red)
            setcolor(tf: cell.confPassTF, color: .red)
        }else {
            
            
            payload.removeAll()
            payload["email"] = email
            payload["password"] = pass
            payload["first_name"] = fname
            payload["last_name"] = lname
            payload["phone"] = mobile
            payload["about_us"] = "test"
            
            
            vm?.CALL_REGISTER_USER_API(dictParam: payload)
            
        }
        
    }
    
    
    override func didTapOnBackToLoginBtnAction(cell:CreateAccountTVCell){
        gotoLoginPage()
    }
    
    
    func gotoLoginPage(){
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    
    @IBAction func didTapOnSkipBtn(_ sender: Any) {
        //        gotodashBoardScreen()
        //  gotoLoginPage()
        dismiss(animated: true)
    }
    
    func gotodashBoardScreen() {
        guard let vc = DBTabbarController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        callapibool = true
        present(vc, animated: true)
    }
    
    override func didTapOnBackToLoginBtn(cell: LabelWithButtonTVCell) {
        // gotoLoginPage()
        dismiss(animated: true)
    }
    
    func registerUserSucess(response: RegisterUserModel) {
        if response.status == false {
            showToast(message: response.msg ?? "")
        }else {
            showToast3(message: "User Registration Sucess")
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                dismiss(animated: true)
            }
        }
    }
    
    
    
}
