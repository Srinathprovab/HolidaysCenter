//
//  LoginVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 16/08/22.
//

import UIKit
import MaterialComponents

class LoginVC: BaseTableVC {
    
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var skipbtn: UIButton!
    @IBOutlet weak var backbtn: UIButton!
    var tablerow = [TableRow]()
    
    static var newInstance: LoginVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? LoginVC
        return vc
    }
    var email = String()
    var pass = String()
    var showPwdBool = true
    var isvcfrom = String()
    var payload = [String:Any]()
    var vm:LoginViewModel?
    var vm1:ProfileUpdateViewModel?
    
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: false)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        
        if isvcfrom == "ViewController" && ExecuteOnceBool == false {
            skipbtn.isHidden = false
            backbtn.isHidden = true
        }else {
            skipbtn.isHidden = true
            backbtn.isHidden = false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupTV()
        vm = LoginViewModel(self)
        vm1 = ProfileUpdateViewModel(self)
    }
    
    func setupTV() {
        
        
        
        commonTableView.backgroundColor = .AppBackgroundColor
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "LoginTVCell"])
        
        appendLoginTvcells()
    }
    
    
    func appendLoginTvcells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(height:80,bgColor: .AppBackgroundColor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType:.LoginTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    override func didTapOnForgetPasswordBtnAction(cell: LoginTVCell) {
        guard let vc = ResetPasswordVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    override func editingTextField(tf:MDCOutlinedTextField){
        print(tf.text ?? "")
        switch tf.tag {
        case 1:
            email = tf.text ?? ""
            break
            
        case 2:
            pass = tf.text ?? ""
            break
            
        default:
            break
        }
    }
    
    
    
    
    override func didTapOnShowPasswordBtn(cell:TextfieldTVCell){
        
        if showPwdBool == true {
            cell.showPassImg.image = UIImage(named: "showpass")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
            cell.txtField.isSecureTextEntry = false
            showPwdBool = false
        }else {
            cell.showPassImg.image = UIImage(named: "hidepass")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
            cell.txtField.isSecureTextEntry = true
            showPwdBool = true
        }
        
    }
    
    
    
    
    override func didTapOnGoogleBtn(cell: SignUpWithTVCell){
        print("didTapOnGoogleBtn")
    }
    
    
    override func didTapOnBackToCreateAccountBtn(cell: LoginTVCell) {
        guard let vc = CreateAccountVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    func gotodashBoardScreen() {
        guard let vc = DBTabbarController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        callapibool = true
        present(vc, animated: true)
    }
    
    
    
    override func didTapOnLoginBtnAction(cell: LoginTVCell) {
        
        if email.isEmpty == true {
            cell.emailTF.setOutlineColor(.red, for: .normal)
            cell.emailTF.setOutlineColor(.red, for: .editing)
            showToast3(message: "Enter Email Address")
        }else if email.isValidEmail() == false {
            cell.emailTF.setOutlineColor(.red, for: .normal)
            cell.emailTF.setOutlineColor(.red, for: .editing)
            showToast3(message: "Enter Valid Email Address")
        }else if pass.isEmpty == true {
            cell.passTF.setOutlineColor(.red, for: .normal)
            cell.passTF.setOutlineColor(.red, for: .editing)
            showToast3(message: "Enter Password")
        }else {
            payload.removeAll()
            loderBool = "normal"
            payload["username"] = email
            payload["password"] = pass
            vm?.CALL_LOGIN_API(dictParam: payload)
        }
        
        
    }
    
    
    @IBAction func didTapOnSkipBtn(_ sender: Any) {
        gotodashBoardScreen()
    }
    
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}



extension LoginVC:LoginViewModelDelegate {
    
    func loginSucess(response: LoginModel) {
        loderBool = "normal"
        if response.status == false {
            
            showToast3(message: response.data ?? "")
            defaults.set(false, forKey: UserDefaultsKeys.loggedInStatus)
        }else {
            
            showToast3(message: response.data ?? "")
            defaults.set(true, forKey: UserDefaultsKeys.loggedInStatus)
            defaults.set(response.user_id, forKey: UserDefaultsKeys.userid)
            defaults.set("\(response.first_name ?? "") \(response.last_name ?? "")", forKey: UserDefaultsKeys.username)
            defaults.set(response.image, forKey: UserDefaultsKeys.userimg)
            NotificationCenter.default.post(name: NSNotification.Name("logindon"), object: nil)
            
            DispatchQueue.main.async {[self] in
                callProfileAPI()
            }
            
        }
    }
    
    
}



extension LoginVC:ProfileUpdateViewModelDelegate {
    
    func callProfileAPI() {
        payload.removeAll()
        loderBool = "normal"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        vm1?.CALL_SHOW_PROFILE_API(dictParam: payload)
    }
    
    func profileDetails(response: ProfileUpdateModel) {
        
        loderBool = "normal"
        profildata = response.data
        
        defaults.set(profildata?.image, forKey: UserDefaultsKeys.userimg)
        defaults.set(profildata?.email, forKey: UserDefaultsKeys.useremail)
        defaults.set(profildata?.phone, forKey: UserDefaultsKeys.usermobile)
        defaults.set(profildata?.country_code, forKey: UserDefaultsKeys.usermobilecode)
        
        let seconds = 1.0
        if isvcfrom == "ViewController" {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                // Put your code which should be executed with a delay here
                gotodashBoardScreen()
            }
        }else {
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                // Put your code which should be executed with a delay here
                dismiss(animated: true)
            }
        }
    }
}
