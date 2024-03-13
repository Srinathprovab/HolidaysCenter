//
//  PromocodeTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 18/08/22.
//

import UIKit
protocol PromocodeTVCellDelegate {
    func didTapOnApplyBtn(cell:PromocodeTVCell)
    func editingTextField(tf:UITextField)
}

class PromocodeTVCell: TableViewCell {
        
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var promocodeTF: UITextField!
    @IBOutlet weak var applyBtn: UIButton!
    @IBOutlet weak var subtitlelbl: UILabel!
 //   @IBOutlet weak var promoHolderView: UIStackView!
    
    
    var showpromoBool = Bool()
    var delegate:PromocodeTVCellDelegate?
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
        contentView.backgroundColor = .AppBGcolor
        holderView.backgroundColor = .WhiteColor
        img.image = UIImage(named: "coupon")
        setupLabels(lbl: titlelbl, text: "Offers & Promocode", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 18))
        setupLabels(lbl: subtitlelbl, text: "Have An E-coupon or Promo Code ?", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 12))
        setupViews(v: textFieldView, radius: 4, color: .WhiteColor)
        textFieldView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        applyBtn.setTitle("Apply", for: .normal)
        applyBtn.setTitleColor(.AppNavBackColor, for: .normal)
        applyBtn.titleLabel?.font = UIFont.poppinsRegular(size: 16)
        promocodeTF.placeholder = "Enter Promocode"
        promocodeTF.backgroundColor = .clear
        promocodeTF.setLeftPaddingPoints(20)
        promocodeTF.font = UIFont.LatoRegular(size: 16)
        promocodeTF.delegate = self
        promocodeTF.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.5
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    @objc func editingText(textField:UITextField) {
        delegate?.editingTextField(tf: textField)
    }
    
    
    @IBAction func didTapOnApplyBtn(_ sender: Any) {
        hotelPromocodeBool.toggle()
        delegate?.didTapOnApplyBtn(cell: self)
    }
    
    override func updateUI() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(promocodeapply), name: Notification.Name("promocodeapply"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(cancelpromo), name: Notification.Name("cancelpromo"), object: nil)
        
    }
    
    @objc func promocodeapply() {
        holderView.isHidden = true
    }
    
    @objc func cancelpromo() {
        holderView.isHidden = false
    }
    
    
//    @IBAction func didTapOnExpandViewBtnAction(_ sender: Any) {
//        showpromoBool.toggle()
//        if showpromoBool {
//            promoHolderView.isHidden = false
//        }else {
//            promoHolderView.isHidden = true
//        }
//    }
    
    
}



extension PromocodeTVCell {
    
    //MARK - UITextField Delegates
    //    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //        //For mobile numer validation
    //        if textField == mobileTF {
    //            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
    //            let characterSet = CharacterSet(charactersIn: string)
    //            return allowedCharacters.isSuperset(of: characterSet)
    //        }
    //        return true
    //    }
}
