//
//  ResetPasswordVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 16/08/22.
//

import UIKit
import MaterialComponents

class ResetPasswordVC: BaseTableVC, ForgetPasswordViewModelDelegate {
    
    
    var tablerow = [TableRow]()
    static var newInstance: ResetPasswordVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ResetPasswordVC
        return vc
    }
    var email = String()
    var mobile = String()
    var payload = [String:Any]()
    var vm:ForgetPasswordViewModel?
    var countrycode = String()

    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: false)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupTV()
        vm = ForgetPasswordViewModel(self)
    }
    
    func setupTV() {
        
        self.countrycode = defaults.string(forKey: UserDefaultsKeys.mobilecountrycode) ?? "+61"
        commonTableView.backgroundColor = .AppBackgroundColor
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "ResetPasswordTVCell"])
        
        appendLoginTvcells()
    }
    
    
    
    func appendLoginTvcells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(height:60,bgColor: .AppBackgroundColor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType:.ResetPasswordTVCell))
       
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
   
    
    override func didTapOnCountryCodeBtnAction(cell:ResetPasswordTVCell){
        countrycode = cell.countryCodeTF.text ?? ""
        print(countrycode)
    }
    
    override func editingTextField(tf:MDCOutlinedTextField){
        print(tf.text ?? "")
        switch tf.tag {
        case 1:
            email = tf.text ?? ""
            break
            
        case 2:
            mobile = tf.text ?? ""
            break
            
        default:
            break
        }
    }
    
    
    func setcolor(tf:MDCOutlinedTextField,color:UIColor) {
        tf.setOutlineColor(color, for: .normal)
    }
    
    
    
    
    @IBAction func didTapOnSkipBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
    override func didTapOnSendBtnAction(cell: ResetPasswordTVCell) {
        
        if email.isEmpty == true {
            cell.emailTF.setOutlineColor(.red, for: .normal)
            cell.emailTF.setOutlineColor(.red, for: .editing)
            showToast3(message: "Enter Email Address")
        }else if email.isValidEmail() == false {
            cell.emailTF.setOutlineColor(.red, for: .normal)
            cell.emailTF.setOutlineColor(.red, for: .editing)
            showToast3(message: "Enter Valid Email Address")
        }else if mobile.isEmpty == true {
            cell.mobileTF.setOutlineColor(.red, for: .normal)
            cell.mobileTF.setOutlineColor(.red, for: .editing)
            showToast3(message: "Enter Mobile Number")
        }else {
            payload.removeAll()
            loderBool = "normal"
            payload["email"] = email
            payload["phone"] = mobile
            vm?.CALL_FORGET_PASSWORD_API(dictParam: payload)
        }
        
        
    }
    
    
    func forgetPasswordDetails(response: LoginModel) {
        if response.status == false {
            showToast(message: response.data ?? "Errorrrrr")
        }else {
            showToast3(message: response.data ?? "")
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                dismiss(animated: true)
            }
        }
    }
    
    
    
}
