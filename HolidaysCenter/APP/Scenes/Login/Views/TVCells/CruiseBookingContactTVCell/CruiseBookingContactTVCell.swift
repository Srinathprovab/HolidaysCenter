//
//  CruiseBookingContactTVCell.swift
//  HolidaysCenterApp
//
//  Created by FCI on 20/02/24.
//

import UIKit
import MaterialComponents
import DropDown


protocol CruiseBookingContactTVCellDelegate {
    func editingTextField(tf:UITextField)
    func didTapOnAddressBtnAction(cell:CruiseBookingContactTVCell)
    func didTapOnMailBtnAction(cell:CruiseBookingContactTVCell)
    func didTapOnPhoneBtnAction(cell:CruiseBookingContactTVCell)
    func didTapOnSubmitBtnAction(cell:CruiseBookingContactTVCell)
    func textViewDidChange(textView:UITextView)
    func didTapOnRequestCallBackBtnAction(cell:CruiseBookingContactTVCell)
    func didTapOnCountryCodeBtnAction(cell:CruiseBookingContactTVCell)
}

class CruiseBookingContactTVCell: TableViewCell, UITextViewDelegate {
    
    
    @IBOutlet weak var nameTF: MDCOutlinedTextField!
    @IBOutlet weak var emaillbl: UILabel!
    @IBOutlet weak var emailTF: MDCOutlinedTextField!
    @IBOutlet weak var countryCodeTF: MDCOutlinedTextField!
    @IBOutlet weak var mobileTF: MDCOutlinedTextField!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var requestBtnView: UIView!
    @IBOutlet weak var helpDeskView: UIView!
    @IBOutlet weak var arrowImg: UIImageView!
    
    
    var cname = String()
    var filterdcountrylist = [Country_list]()
    var countryNames = [String]()
    var countrycodesArray = [String]()
    let dropDown = DropDown()
    var isSearchBool = Bool()
    var searchText = String()
    var requestBool = false
    var placeHolder = String()
    var delegate:CruiseBookingContactTVCellDelegate?
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
        
        helpDeskView.isHidden = true
        requestBtnView.isHidden = false
        emaillbl.text = "booking@holidayscenter.com"
       
        
        setupTextField(txtField1: nameTF,
                       tagno: 1,
                       placeholder: "Name",
                       title: "Enter Name",
                       subTitle: "Name")
        
        setupTextField(txtField1: emailTF,
                       tagno: 2,
                       placeholder: "Email",
                       title: "Enter Email",
                       subTitle: "Email")
        
        
        setupTextField(txtField1: mobileTF,
                       tagno: 3,
                       placeholder: "Mobile Number",
                       title: "Enter Mobile Number",
                       subTitle: "Mobile Number")
        
        
        setupTextField(txtField1: countryCodeTF,
                       tagno: 7,
                       placeholder: "Code*",
                       title: "Code*",
                       subTitle: "Code*")
        
        
        setupdescView()
        
        
        setupDropDown()
        countryCodeTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        countryCodeTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
        countryCodeTF.text = defaults.string(forKey: UserDefaultsKeys.mobilecountrycode)
        mobileTF.keyboardType = .numberPad
        
        countryCodeTF.textColor = .AppLabelColor
        countryCodeTF.setNormalLabelColor(UIColor.AppLabelColor, for: .normal)
        countryCodeTF.setFloatingLabelColor(UIColor.AppLabelColor, for: .editing)
        
        
        arrowImg.image = UIImage(named: "down1")?.withRenderingMode(.alwaysOriginal).withTintColor(.BtnTitleColor)
    
        
    }
    
    
    
    func setupTextField(txtField1:MDCOutlinedTextField,tagno:Int,placeholder:String,title:String,subTitle:String){
        
        
        txtField1.tag = tagno
        txtField1.label.text = title
        txtField1.placeholder = placeholder
        txtField1.delegate = self
        txtField1.backgroundColor = .clear
        txtField1.font = UIFont.LatoRegular(size: 16)
        txtField1.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        txtField1.setOutlineColor( .AppLabelColor, for: .editing)
        txtField1.setOutlineColor( .red , for: .disabled)
        txtField1.setOutlineColor( .lightGray.withAlphaComponent(0.3) , for: .normal)
        
        txtField1.setTextColor(.AppLabelColor, for: .editing)
        txtField1.setTextColor(.AppLabelColor, for: .normal)
        
        txtField1.setNormalLabelColor(UIColor.AppLabelColor, for: .normal)
        txtField1.setNormalLabelColor(UIColor.AppLabelColor, for: .editing)
        
        txtField1.setFloatingLabelColor(UIColor.AppLabelColor, for: .editing)
        txtField1.setFloatingLabelColor(UIColor.AppLabelColor, for: .normal)
        
        
    }
    
    
    func setupdescView() {
        
        messageTextView.layer.cornerRadius = 6
        messageTextView.clipsToBounds = true
        messageTextView.layer.borderWidth = 1
        messageTextView.layer.borderColor = UIColor.AppBorderColor.cgColor
        
        messageTextView.text = ""
        messageTextView.delegate = self
        messageTextView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        messageTextView.setPlaceholder11(ph: placeHolder)
    }
    
    @objc func textViewDidChange(_ textView: UITextView) {
        textView.checkPlaceholder11()
        delegate?.textViewDidChange(textView: textView)
    }
    
    
    
    @objc func editingText(textField:UITextField) {
        delegate?.editingTextField(tf: textField)
    }
    
    @IBAction func didTapOnAddressBtnAction(_ sender: Any) {
        delegate?.didTapOnAddressBtnAction(cell: self)
    }
    
    @IBAction func didTapOnMailBtnAction(_ sender: Any) {
        delegate?.didTapOnMailBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnPhoneBtnAction(_ sender: Any) {
        delegate?.didTapOnPhoneBtnAction(cell: self)
    }
    
    @IBAction func didTapOnSubmitBtnAction(_ sender: Any) {
        delegate?.didTapOnSubmitBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnRequestCallBackBtnAction(_ sender: Any) {
        requestBool.toggle()
        if requestBool {
            arrowImg.image = UIImage(named: "downup")?.withRenderingMode(.alwaysOriginal).withTintColor(.BtnTitleColor)
            helpDeskView.isHidden = false
           
        }else {
            arrowImg.image = UIImage(named: "down1")?.withRenderingMode(.alwaysOriginal).withTintColor(.BtnTitleColor)
            helpDeskView.isHidden = true
            
        }
        delegate?.didTapOnRequestCallBackBtnAction(cell: self)
    }
}




extension UITextView{
    
    func setPlaceholder11(ph:String) {
        
        let placeholderLabel = UILabel()
        placeholderLabel.text = "Message"
        placeholderLabel.font = UIFont.OpenSansRegular(size: 16)
        placeholderLabel.sizeToFit()
        placeholderLabel.tag = 222
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (self.font?.pointSize)! / 2)
        placeholderLabel.textColor = .AppLabelColor
        placeholderLabel.isHidden = !self.text.isEmpty
        
        self.addSubview(placeholderLabel)
    }
    
    func checkPlaceholder11() {
        let placeholderLabel = self.viewWithTag(222) as! UILabel
        placeholderLabel.isHidden = !self.text.isEmpty
    }
    
}



extension CruiseBookingContactTVCell {
    
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



extension CruiseBookingContactTVCell {
    
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

