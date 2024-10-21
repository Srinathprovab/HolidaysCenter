//
//  CreateAccountTVCell.swift
//  KuwaitWays
//
//  Created by FCI on 23/05/23.
//

import UIKit
import MaterialComponents
import DropDown

protocol CreateAccountTVCellDelegate {
    func didTapOnCountryCodeBtnAction(cell:CreateAccountTVCell)
    func didTapOnCreateAccountBtnBtnAction(cell:CreateAccountTVCell)
    func editingMDCOutlinedTextField(tf:MDCOutlinedTextField)
    func didTapOnBackToLoginBtnAction(cell:CreateAccountTVCell)
}

class CreateAccountTVCell: TableViewCell {
    
    @IBOutlet weak var createAccountBtnView: UIView!
    @IBOutlet weak var fnameTF: MDCOutlinedTextField!
    @IBOutlet weak var lnameTF: MDCOutlinedTextField!
    @IBOutlet weak var emailTF: MDCOutlinedTextField!
    @IBOutlet weak var countryCodeTF: MDCOutlinedTextField!
    @IBOutlet weak var mobileTF: MDCOutlinedTextField!
    @IBOutlet weak var createPassTF: MDCOutlinedTextField!
    @IBOutlet weak var confPassTF: MDCOutlinedTextField!
    @IBOutlet weak var countryCodeBtn: UIButton!
    @IBOutlet weak var createAccountBtn: UIButton!
    @IBOutlet weak var backtoLoginBtn: UIButton!
    @IBOutlet weak var checkImg: UIImageView!
    @IBOutlet weak var passImg: UIImageView!
    @IBOutlet weak var showPass1Img: UIImageView!
    @IBOutlet weak var countrycodeTV: UITableView!
    @IBOutlet weak var countrycodeTVHeight: NSLayoutConstraint!
    
    
    var filterdcountrylist = [Country_list]()
    var countryNames = [String]()
    var countrycodesArray = [String]()
    var showbool1 = true
    var showbool2 = true
    var chkBool = true
    let dropDown = DropDown()
    var isSearchBool = Bool()
    var searchText = String()
    var delegate:CreateAccountTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        countrycodeTVHeight.constant = 0
        loadCountryNamesAndCode()
    }
    
   
    
    
    func setupUI() {
        
        checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.BtnTitleColor)
        setupTextField(txtField1: fnameTF, tag1: 1, label: "First Name*", placeholder: "")
        setupTextField(txtField1: lnameTF, tag1: 2, label: "Last Name*", placeholder: "")
        setupTextField(txtField1: emailTF, tag1: 3, label: "Email Address*", placeholder: "")
        setupTextField(txtField1: countryCodeTF, tag1: 7, label: "Code*", placeholder: "")
        setupTextField(txtField1: mobileTF, tag1: 4, label: "Mobile Number*", placeholder: "")
        setupTextField(txtField1: createPassTF, tag1: 5, label: "Create Password*", placeholder: "")
        setupTextField(txtField1: confPassTF, tag1: 6, label: "Confirm Password*", placeholder: "")
        createPassTF.isSecureTextEntry = true
        confPassTF.isSecureTextEntry = true
       // createAccountBtnView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 4)
        //  countryCodeTF.text = defaults.string(forKey: UserDefaultsKeys.mobilecountrycode)
        
        countryCodeBtn.setTitle("", for: .normal)
        countryCodeBtn.addTarget(self, action: #selector(didTapOnCountryCodeBtnAction(_:)), for: .touchUpInside)
        createAccountBtn.setTitle("", for: .normal)
        createAccountBtn.addTarget(self, action: #selector(didTapOnCreateAccountBtnBtnAction(_:)), for: .touchUpInside)
        backtoLoginBtn.setTitle("", for: .normal)
        backtoLoginBtn.addTarget(self, action: #selector(didTapOnBackToLoginBtnAction(_:)), for: .touchUpInside)
        
        setupDropDown()
        countryCodeBtn.isHidden = true
        countryCodeTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        countryCodeTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
        countryCodeTF.text = defaults.string(forKey: UserDefaultsKeys.mobilecountrycode)
        mobileTF.keyboardType = .numberPad
        
//        countryCodeTF.textColor = .AppLabelColor
//        countryCodeTF.setNormalLabelColor(UIColor.AppLabelColor, for: .normal)
//        countryCodeTF.setFloatingLabelColor(UIColor.AppLabelColor, for: .editing)
        
        
    }
    
    
 
    
    
    
    @objc func didTapOnCountryCodeBtnAction(_ sender:UIButton) {
        dropDown.show()
    }
    
    @objc func didTapOnCreateAccountBtnBtnAction(_ sender:UIButton) {
        
        delegate?.didTapOnCreateAccountBtnBtnAction(cell: self)
    }
    
    
    @objc func didTapOnBackToLoginBtnAction(_ sender:UIButton) {
        delegate?.didTapOnBackToLoginBtnAction(cell: self)
    }
    
    
    func setupTextField(txtField1:MDCOutlinedTextField,tag1:Int,label:String,placeholder:String) {
        
        txtField1.tag = tag1
        txtField1.label.text = label
        // txtField1.text = subTitle
        txtField1.placeholder = placeholder
        txtField1.delegate = self
        txtField1.backgroundColor = .clear
        txtField1.font = UIFont.LatoRegular(size: 16)
        txtField1.addTarget(self, action: #selector(editingMDCOutlinedTextField(textField:)), for: .editingChanged)
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
    
    
    var cname = String()
    func setupDropDown() {
        
        dropDown.textColor = .AppLabelColor
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.countryCodeTF
        dropDown.bottomOffset = CGPoint(x: 0, y: countryCodeTF.frame.size.height + 25)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.countryCodeTF.text = self?.countrycodesArray[index] ?? ""
            self?.countryCodeTF.resignFirstResponder()
            self?.cname = self?.countryNames[index] ?? ""
            self?.mobileTF.text = ""
            self?.mobileTF.becomeFirstResponder()
            self?.delegate?.didTapOnCountryCodeBtnAction(cell: self!)
        }
        
    }
    
    @objc func editingMDCOutlinedTextField(textField:MDCOutlinedTextField) {
        
        if textField.text?.isEmpty != true {
            
            textField.setOutlineColor(.BtnTitleColor, for: .editing)
            textField.setOutlineColor(.BtnTitleColor, for: .normal)
            
            
            if textField == mobileTF {
                if let text = textField.text {
                    let length = text.count
                    if length != mobilenoMaxLength {
                        mobilenoMaxLengthBool = false
                    }else{
                        mobilenoMaxLengthBool = true
                    }
                    
                } else {
                    mobilenoMaxLengthBool = false
                }
            }
        }else {
            
            textField.setOutlineColor( .lightGray.withAlphaComponent(0.4) , for: .normal)
        }
        
        delegate?.editingMDCOutlinedTextField(tf: textField)
    }
    
    
    
    
    @IBAction func didTapOnCheckBox(_ sender: Any) {
        if chkBool == true {
            checkImg.image = UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal).withTintColor(.BtnTitleColor)
            chkBool = false
        }else {
            checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.BtnTitleColor)
            chkBool = true
        }
    }
    
    
    
    @IBAction func didTapOnShowPassBtnAction(_ sender: Any) {
        
        if showbool1 == true {
            createPassTF.isSecureTextEntry = false
            showPass1Img.image = UIImage(named: "showpass")?.withRenderingMode(.alwaysOriginal).withTintColor(.BtnTitleColor)
            showbool1 = false
        }else {
            createPassTF.isSecureTextEntry = true
            showPass1Img.image = UIImage(named: "hidepass")?.withRenderingMode(.alwaysOriginal).withTintColor(.BtnTitleColor)
            showbool1 = true
        }
    }
    
    @IBAction func didTapOnShowPassBtnAction1(_ sender: Any) {
        if showbool2 == true {
            confPassTF.isSecureTextEntry = false
            passImg.image = UIImage(named: "showpass")?.withRenderingMode(.alwaysOriginal).withTintColor(.BtnTitleColor)
            showbool2 = false
        }else {
            confPassTF.isSecureTextEntry = true
            passImg.image = UIImage(named: "hidepass")?.withRenderingMode(.alwaysOriginal).withTintColor(.BtnTitleColor)
            showbool2 = true
        }
    }
    
    
    
    @objc func searchTextBegin(textField: MDCOutlinedTextField) {
        textField.text = ""
        loadCountryNamesAndCode()
        dropDown.show()
    }
    
    
    @objc func searchTextChanged(textField: MDCOutlinedTextField) {
        searchText = textField.text ?? ""
        if searchText == "" {
            isSearchBool = false
            filterContentForSearchText(searchText)
        }else {
            isSearchBool = true
            filterContentForSearchText(searchText)
        }
        
        
    }
    
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        
        filterdcountrylist.removeAll()
        filterdcountrylist = countrylist.filter { thing in
            return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        countryNames.removeAll()
        countrycodesArray.removeAll()
        filterdcountrylist.forEach { i in
            countryNames.append(i.name ?? "")
            countrycodesArray.append(i.country_code ?? "")
        }
        dropDown.dataSource = countryNames
        dropDown.show()
        
    }
    
    
    func loadCountryNamesAndCode(){
        countryNames.removeAll()
        countrycodesArray.removeAll()
        countrylist.forEach { i in
            countryNames.append(i.name ?? "")
            countrycodesArray.append(i.country_code ?? "")
        }
        DispatchQueue.main.async {[self] in
            dropDown.dataSource = countryNames
        }
    }
}


extension CreateAccountTVCell {
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField.tag == 4 {
            mobilenoMaxLength = cname.getMobileNumberMaxLength() ?? 8
            guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
                return false
            }
        }else {
            mobilenoMaxLength = 50
        }
        
        
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        
        return newString.length <= mobilenoMaxLength
    }
}

