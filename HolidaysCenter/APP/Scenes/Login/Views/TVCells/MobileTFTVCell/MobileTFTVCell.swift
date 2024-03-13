//
//  MobileTFTVCell.swift
//  HolidaysCenter
//
//  Created by FCI on 30/10/23.
//

import UIKit
import MaterialComponents
import DropDown

protocol MobileTFTVCellDelegate {
    func editingTextField(tf:UITextField)
    func didTapOnCountryCodeBtnAction(cell:MobileTFTVCell)
}

class MobileTFTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var txtField: MDCOutlinedTextField!
    @IBOutlet weak var countryCodeBtn: UIButton!
    @IBOutlet weak var textFieldHolderView: UIStackView!
    @IBOutlet weak var countryCodeTF: MDCOutlinedTextField!
    
    
    var filterdcountrylist = [Country_list]()
    var countryNames = [String]()
    var countrycodesArray = [String]()
    let dropDown = DropDown()
    var isSearchBool = Bool()
    var searchText = String()
    var maxLength = 10
    var cname = String()
    var delegate:MobileTFTVCellDelegate?
    
    
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
        
        setupTextField(txtField1: txtField, tagno: Int(cellInfo?.text ?? "") ?? 0, placeholder: cellInfo?.tempText ?? "",title: cellInfo?.title ?? "",subTitle: cellInfo?.subTitle ?? "")
        setupTextField(txtField1: countryCodeTF, tagno: Int(cellInfo?.text ?? "") ?? 0, placeholder: cellInfo?.tempText ?? "",title: "Code",subTitle: defaults.string(forKey: UserDefaultsKeys.mobilecountrycode) ?? "")
        
        txtField.text = cellInfo?.subTitle
        countryCodeTF.text = cellInfo?.buttonTitle
        
        textFieldHolderView.isUserInteractionEnabled = false
        textFieldHolderView.alpha = 0.6
        
    }
    
    
    func setupUI() {
        txtField.keyboardType = .numberPad
        setupDropDown()
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
        txtField1.label.textColor = .SubTitleColor
        txtField1.setOutlineColor( .black, for: .editing)
        txtField1.setOutlineColor( .red , for: .disabled)
        txtField1.setOutlineColor( .lightGray.withAlphaComponent(0.4) , for: .normal)
        
        txtField1.setTextColor(.AppLabelColor, for: .editing)
        txtField.setTextColor(.AppLabelColor, for: .normal)
        
        txtField1.setNormalLabelColor(UIColor.AppLabelColor, for: .normal)
        txtField1.setNormalLabelColor(UIColor.AppLabelColor, for: .editing)
        
        txtField1.setFloatingLabelColor(UIColor.AppLabelColor, for: .editing)
        txtField1.setFloatingLabelColor(UIColor.AppLabelColor, for: .normal)
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
    
    
    
    
    
    @IBAction func didTapOnCountryCodeBtn(_ sender: Any) {
        dropDown.show()
    }
    
}



extension MobileTFTVCell {
    
    
    func setupDropDown() {
        dropDown.textColor = .AppLabelColor
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.countryView
        dropDown.bottomOffset = CGPoint(x: 0, y: countryView.frame.size.height + 25)
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
    
}



extension MobileTFTVCell {
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField == countryCodeTF{
            maxLength = cname.getMobileNumberMaxLength() ?? 8
            guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
                return false
            }
        }else {
            maxLength = 10
            guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
                return false
            }
        }
        
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        
        return newString.length <= maxLength
    }
}
