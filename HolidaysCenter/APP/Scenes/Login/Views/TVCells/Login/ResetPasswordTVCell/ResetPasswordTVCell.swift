//
//  ResetPasswordTVCell.swift
//  HolidaysCenterApp
//
//  Created by FCI on 19/02/24.
//

import UIKit
import MaterialComponents
import DropDown

protocol ResetPasswordTVCellDelegate {
    
    func didTapOnSendBtnAction(cell:ResetPasswordTVCell)
    func editingTextField(tf:MDCOutlinedTextField)
    func didTapOnCountryCodeBtnAction(cell:ResetPasswordTVCell)
}

class ResetPasswordTVCell: TableViewCell {
    
    @IBOutlet weak var emailTF: MDCOutlinedTextField!
    @IBOutlet weak var mobileTF: MDCOutlinedTextField!
    @IBOutlet weak var countryCodeTF: MDCOutlinedTextField!
    @IBOutlet weak var sendbtn: UIButton!
    
    
    var cname = String()
    var filterdcountrylist = [Country_list]()
    var countryNames = [String]()
    var countrycodesArray = [String]()
    let dropDown = DropDown()
    var isSearchBool = Bool()
    var searchText = String()
    var maxLength = 50
    
    var delegate:ResetPasswordTVCellDelegate?
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
        
        loadCountryNamesAndCode()
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
    
    func setupUI() {
        setupTextField(txtField1: emailTF,
                       tagno: 1,
                       placeholder: "Email Address*",
                       title: "Email Address*",
                       subTitle: "Email Address*")
        
        
        setupTextField(txtField1: mobileTF,
                       tagno: 2,
                       placeholder: "Enter Mobile Number*",
                       title: "Mobile Number*",
                       subTitle: "Mobile Number*")
        
       

        
        setupTextField(txtField1: countryCodeTF,
                       tagno: 7,
                       placeholder: "Code*",
                       title: "Code*",
                       subTitle: "Code*")
        
        
        sendbtn.layer.cornerRadius = 25
        sendbtn.addTarget(self, action: #selector(didTapOnSendBtnAction(_:)), for: .touchUpInside)
        
        
        
        setupDropDown()
        countryCodeTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        countryCodeTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
        countryCodeTF.text = defaults.string(forKey: UserDefaultsKeys.mobilecountrycode)
        mobileTF.keyboardType = .numberPad
        
        countryCodeTF.textColor = .AppLabelColor
        countryCodeTF.setNormalLabelColor(UIColor.AppLabelColor, for: .normal)
        countryCodeTF.setFloatingLabelColor(UIColor.AppLabelColor, for: .editing)
        
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
        
        delegate?.editingTextField(tf: textField)
    }
    
    
    
    
    @objc func didTapOnSendBtnAction(_ sender:UIButton) {
        delegate?.didTapOnSendBtnAction(cell: self)
    }
    
    
    
}



extension ResetPasswordTVCell {
    
    
    
    
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
    
}


extension ResetPasswordTVCell {
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField == mobileTF {
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
