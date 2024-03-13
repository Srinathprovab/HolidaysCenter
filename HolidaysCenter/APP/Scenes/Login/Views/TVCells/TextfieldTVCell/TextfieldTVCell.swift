//
//  TextfieldTVCell.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit
import DropDown
import MaterialComponents.MaterialTextControls_OutlinedTextFields


protocol TextfieldTVCellDelegate {
    
    func didTapOnForGetPassword(cell:TextfieldTVCell)
    func editingTextField(tf:UITextField)
    func didTapOnShowPasswordBtn(cell:TextfieldTVCell)
    func didTapOnCountryCodeDropDownBtn(cell:TextfieldTVCell)
    func donedatePicker(cell:TextfieldTVCell)
    func cancelDatePicker(cell:TextfieldTVCell)
    func didTapOnCountryCodeBtnAction(cell:TextfieldTVCell)
    func didTapOnSelectedGender(cell:TextfieldTVCell)
    
}
class TextfieldTVCell: TableViewCell {
    
    @IBOutlet weak var showPassView: UIView!
    @IBOutlet weak var showPassBtn: UIButton!
    @IBOutlet weak var showPassImg: UIImageView!
    @IBOutlet weak var countryCodeView: UIView!
    @IBOutlet weak var txtField: MDCOutlinedTextField!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var forgetPwdBtn: UIButton!
    @IBOutlet weak var btnHeight: NSLayoutConstraint!
    @IBOutlet weak var viewheight: NSLayoutConstraint!
    
    @IBOutlet weak var countryCodeBtn: UIButton!
    @IBOutlet weak var textFieldHolderView: UIStackView!
    @IBOutlet weak var countryCodeTF: MDCOutlinedTextField!
    @IBOutlet weak var btn: UIButton!
    
    
    var gender = String()
    var filterdcountrylist = [Country_list]()
    var countryNames = [String]()
    var countrycodesArray = [String]()
    var showbool1 = true
    var showbool2 = true
    var chkBool = true
    let dropDown = DropDown()
    var isSearchBool = Bool()
    var searchText = String()
    
    let datePicker = UIDatePicker()
    let genderdropDown = DropDown()
    var maxLength = 10
    var key = String()
    var delegate:TextfieldTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        hidethings()
    }
    
    func hidethings(){
        txtField.text = cellInfo?.subTitle
        countryCodeView.isHidden = true
        dropDown.hide()
        datePicker.isHidden = true
        genderdropDown.hide()
        datePicker.isHidden = true
        showPassView.isHidden = true
        btn.isHidden = true
    }
    
    
    override func updateUI() {
        loadCountryNamesAndCode()
        btnHeight.constant = 0
        txtField.inputView = nil
        btn.isHidden = true
        
        
        setupTextField(txtField1: txtField, tagno: Int(cellInfo?.text ?? "") ?? 0, placeholder: cellInfo?.tempText ?? "",title: cellInfo?.title ?? "",subTitle: cellInfo?.subTitle ?? "")
        setupTextField(txtField1: countryCodeTF, tagno: Int(cellInfo?.text ?? "") ?? 0, placeholder: cellInfo?.tempText ?? "",title: "Code",subTitle: defaults.string(forKey: UserDefaultsKeys.mobilecountrycode) ?? "")
        txtField.text = cellInfo?.subTitle
        
        
        
        
        key = cellInfo?.key ?? ""
        switch cellInfo?.key {
            
            
        case "name":
            hidethings()
            break
            
        case "pwd":
            self.txtField.isSecureTextEntry = true
            break
            
        case "pass":
            self.txtField.isSecureTextEntry = true
            btnHeight.constant = 30
            forgetPwdBtn.isHidden = false
            showPassView.isHidden = false
            break
            
        case "mobile":
            textFieldHolderView.isUserInteractionEnabled = true
            countryCodeTF.textColor = .SubTitleColor
            countryCodeView.isHidden = false
            countryCodeTF.text = cellInfo?.buttonTitle
            txtField.textColor = .SubTitleColor
            txtField.keyboardType = .numberPad
            break
            
        case "mobile1":
            textFieldHolderView.isUserInteractionEnabled = true
            countryCodeView.isHidden = true
            txtField.keyboardType = .numberPad
            break
            
        case "dob":
            showPassView.isHidden = false
            showPassImg.image = UIImage(named: "cal")
            datePicker.isHidden = false
            break
            
        case "passport":
            showPassView.isHidden = false
            showPassImg.image = UIImage(named: "downarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
            break
            
            
        case "gender":
            genderdropDown.dataSource = ["Male","Female","Others"]
            setupGenderDropDown()
            break
            
            
        default:
            break
        }
        
        
       
        
        if txtField.tag == 3 {
            showDatePicker()
        }else if txtField.tag == 7 {
            btn.isHidden = false
        }
        
        
        
        if cellInfo?.key1 == "mobile" {
           
            textFieldHolderView.isUserInteractionEnabled = true
            countryCodeView.isHidden = false
            txtField.keyboardType = .numberPad
        }else if cellInfo?.key1 == "noedit" {
            txtField.isUserInteractionEnabled = false
            txtField.alpha = 0.6
            countryCodeTF.isUserInteractionEnabled = false
            countryCodeTF.alpha = 0.6
            countryCodeBtn.isUserInteractionEnabled = false
        }else {
            txtField.isUserInteractionEnabled = true
            txtField.alpha = 1
            countryCodeTF.isUserInteractionEnabled = true
            countryCodeTF.alpha = 1
            countryCodeBtn.isUserInteractionEnabled = true
        }
        
        
      
        
    }
    
    
    func setupTextField(txtField1:MDCOutlinedTextField,tagno:Int,placeholder:String,title:String,subTitle:String){
        
        txtField1.tag = tagno
        txtField1.label.text = title
        txtField1.text = subTitle
        txtField1.placeholder = placeholder
        txtField1.delegate = self
        txtField1.backgroundColor = .clear
        txtField1.font = UIFont.LatoRegular(size: 16)
        txtField1.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        txtField1.setOutlineColor( .black, for: .editing)
        txtField1.setOutlineColor( .red , for: .disabled)
        txtField1.setOutlineColor( .lightGray.withAlphaComponent(0.4) , for: .normal)
       
       
        txtField1.setTextColor(.AppLabelColor, for: .editing)
        txtField1.setTextColor(.AppLabelColor, for: .normal)
        
        txtField1.setNormalLabelColor(UIColor.AppLabelColor, for: .normal)
        txtField1.setNormalLabelColor(UIColor.AppLabelColor, for: .editing)
        
        txtField1.setFloatingLabelColor(UIColor.AppLabelColor, for: .editing)
        txtField1.setFloatingLabelColor(UIColor.AppLabelColor, for: .normal)
    }
    
   
   
    
    
    func setupUI() {
        countryCodeView.isHidden = true
        countryCodeView.backgroundColor = .WhiteColor
        
        self.txtField.isSecureTextEntry = false
        showPassView.backgroundColor = .WhiteColor
        showPassView.isHidden = true
        showPassBtn.setTitle("", for: .normal)
        holderView.backgroundColor = .WhiteColor
        showPassImg.image = UIImage(named: "hidepass")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
        
        txtField.delegate = self
        txtField.backgroundColor = .clear
        txtField.font = UIFont.LatoRegular(size: 16)
        txtField.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        
        txtField.label.textColor = .SubTitleColor
        
        txtField.setOutlineColor( .black, for: .editing)
        txtField.setOutlineColor( .red , for: .disabled)
        txtField.setOutlineColor( .lightGray.withAlphaComponent(0.4) , for: .normal)
        
        forgetPwdBtn.setTitle("Forgot Password?", for: .normal)
        forgetPwdBtn.setTitleColor(.AppBackgroundColor, for: .normal)
        forgetPwdBtn.titleLabel?.font = UIFont.OpenSansRegular(size: 14)
        forgetPwdBtn.isHidden = true
        
        
        setupDropDown()
        countryCodeTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        countryCodeTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
        countryCodeTF.text = defaults.string(forKey: UserDefaultsKeys.mobilecountrycode)
    }
    
    
    
    func setupGenderDropDown() {
        genderdropDown.direction = .any
        genderdropDown.backgroundColor = .WhiteColor
        genderdropDown.anchorView = self.txtField
        genderdropDown.bottomOffset = CGPoint(x: 0, y: txtField.frame.size.height + 10)
        genderdropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.txtField.text = item
            self?.gender = item
            
            self?.delegate?.didTapOnSelectedGender(cell: self!)
        }
        
    }
    
    @objc func editingText(textField:UITextField) {
        txtField.setOutlineColor(.black, for: .editing)
        txtField.setOutlineColor(.black, for: .normal)
        
        
        if textField.tag == 4 {
            if let text = textField.text {
                let length = text.count
                if length != maxLength {
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
    
    
    
    
    func showDatePicker(){
        //Formate Date
        datePicker.isHidden = false
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        
        if txtField.tag == 3 {
            txtField.inputAccessoryView = toolbar
            txtField.inputView = datePicker
        }
        
        
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        txtField.text = formatter.string(from: datePicker.date)
        delegate?.donedatePicker(cell: self)
    }
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell: self)
    }
    
    
    @IBAction func didTapOnForGetPassword(_ sender: Any) {
        delegate?.didTapOnForGetPassword(cell: self)
    }
    
    
    
    @IBAction func didTapOnShowPasswordBtn(_ sender: Any) {
        delegate?.didTapOnShowPasswordBtn(cell: self)
    }
    
    @IBAction func didTapOnCountryCodeDropDownBtn(_ sender: Any) {
        dropDown.show()
        delegate?.didTapOnCountryCodeDropDownBtn(cell: self)
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
            self?.txtField.text = ""
            self?.txtField.becomeFirstResponder()
            self?.delegate?.didTapOnCountryCodeBtnAction(cell: self!)
        }
        
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
    
    
    @IBAction func didTapOnCountryCodeBtn(_ sender: Any) {
        dropDown.show()
    }
    
    
    
    @IBAction func didTapOnGenderBtnAction(_ sender: Any) {
        genderdropDown.show()
    }
    
    
}


extension TextfieldTVCell {
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if key == "mobile" {
            maxLength = 10
            guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
                return false
            }
        } else  if key == "mobile1"{
            
            if textField == txtField{
                maxLength = cname.getMobileNumberMaxLength() ?? 8
                guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
                    return false
                }
            }else {
                maxLength = 10
            }
            
        } else {
            maxLength = 50
        }
        
        
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        
        return newString.length <= maxLength
    }
}
