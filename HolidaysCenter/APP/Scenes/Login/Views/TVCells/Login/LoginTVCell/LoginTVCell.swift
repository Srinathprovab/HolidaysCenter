//
//  LoginTVCell.swift
//  HolidaysCenterApp
//
//  Created by FCI on 19/02/24.
//

import UIKit
import MaterialComponents

protocol LoginTVCellDelegate {
    func editingTextField(tf:MDCOutlinedTextField)
    func didTapOnForgetPasswordBtnAction(cell:LoginTVCell)
    func didTapOnLoginBtnAction(cell:LoginTVCell)
    func didTapOnBackToCreateAccountBtn(cell:LoginTVCell)
}

class LoginTVCell: TableViewCell {
    
    @IBOutlet weak var emailTF: MDCOutlinedTextField!
    @IBOutlet weak var passTF: MDCOutlinedTextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var forgetPasswordBtn: UIButton!
    @IBOutlet weak var createAccountBtn: UIButton!
    
    
    var delegate:LoginTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupUI() {
        setupTextField(txtField1: emailTF,
                       tagno: 1,
                       placeholder: "Email Address*",
                       title: "Email Address*",
                       subTitle: "Email Address*")
        
        
        setupTextField(txtField1: passTF,
                       tagno: 2,
                       placeholder: "Password*",
                       title: "Password*",
                       subTitle: "Password")
        
        passTF.isSecureTextEntry = true
        loginBtn.layer.cornerRadius = 25
        forgetPasswordBtn.addTarget(self, action: #selector(didTapOnForgetPasswordBtnAction(_:)), for: .touchUpInside)
        loginBtn.addTarget(self, action: #selector(didTapOnLoginBtnAction(_:)), for: .touchUpInside)
        createAccountBtn.addTarget(self, action: #selector(didTapOnBackToCreateAccountBtn(_:)), for: .touchUpInside)
        
    }
    
    func setupTextField(txtField1:MDCOutlinedTextField,tagno:Int,placeholder:String,title:String,subTitle:String){
        
        txtField1.tag = tagno
        txtField1.label.text = title
        // txtField1.text = subTitle
        txtField1.placeholder = placeholder
        txtField1.delegate = self
        txtField1.backgroundColor = .clear
        txtField1.font = UIFont.LatoRegular(size: 16)
        txtField1.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        txtField1.setOutlineColor( .BtnTitleColor, for: .editing)
        txtField1.setOutlineColor( .red , for: .disabled)
        txtField1.setOutlineColor( .lightGray.withAlphaComponent(0.4) , for: .normal)
        
        
        txtField1.setTextColor(.BtnTitleColor, for: .editing)
        txtField1.setTextColor(.BtnTitleColor, for: .normal)
        
        txtField1.setNormalLabelColor(UIColor.BtnTitleColor, for: .normal)
        txtField1.setNormalLabelColor(UIColor.BtnTitleColor, for: .editing)
        
        txtField1.setFloatingLabelColor(UIColor.BtnTitleColor, for: .editing)
        txtField1.setFloatingLabelColor(UIColor.BtnTitleColor, for: .normal)
    }
    
    
    @objc func editingText(textField:MDCOutlinedTextField) {
        textField.setOutlineColor(.BtnTitleColor, for: .editing)
        textField.setOutlineColor(.BtnTitleColor, for: .normal)
        delegate?.editingTextField(tf: textField)
    }
    
    
    
    @objc func didTapOnForgetPasswordBtnAction(_ sender:UIButton) {
        delegate?.didTapOnForgetPasswordBtnAction(cell: self)
    }
    
    @objc func didTapOnLoginBtnAction(_ sender:UIButton) {
        delegate?.didTapOnLoginBtnAction(cell: self)
    }
    
    @objc func didTapOnBackToCreateAccountBtn(_ sender:UIButton) {
        delegate?.didTapOnBackToCreateAccountBtn(cell: self)
    }
    
}




extension LoginTVCell {
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        
        return newString.length <= 100
    }
    
}
