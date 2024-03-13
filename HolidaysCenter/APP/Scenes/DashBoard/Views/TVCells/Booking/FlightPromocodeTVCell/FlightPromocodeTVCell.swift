//
//  FlightPromocodeTVCell.swift
//  HolidaysCenter
//
//  Created by FCI on 05/12/23.
//

import UIKit

protocol FlightPromocodeTVCellDelegate {
    func didTapOnApplyBtn(cell:FlightPromocodeTVCell)
    func editingTextField(tf:UITextField)
    func didTapOnExpandViewBtnAction(cell:FlightPromocodeTVCell)
}

class FlightPromocodeTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var promoHolderView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var promocodeTF: UITextField!
    @IBOutlet weak var applyBtn: UIButton!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var dropdownimg: UIImageView!
    
    var showpromoBool = Bool()
    var delegate:FlightPromocodeTVCellDelegate?
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
        promocodeTF.textColor = .AppLabelColor
        
        dropdownimg.image = UIImage(named: "down1")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
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
        // holderView.isHidden = true
        promoHolderView.isHidden = true
        dropdownimg.image = UIImage(named: "down1")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
    }
    
    @objc func cancelpromo() {
        //  holderView.isHidden = false
        promoHolderView.isHidden = true
        dropdownimg.image = UIImage(named: "down1")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
    }
    
    
    @IBAction func didTapOnExpandViewBtnAction(_ sender: Any) {
        togelpromoHolderView()
        delegate?.didTapOnExpandViewBtnAction(cell: self)
    }
    
    func togelpromoHolderView() {
        showpromoBool.toggle()
        if showpromoBool {
            promoHolderView.isHidden = false
            dropdownimg.image = UIImage(named: "downup")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
        }else {
            promoHolderView.isHidden = true
            dropdownimg.image = UIImage(named: "down1")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
        }
        
    }
    
    
}


