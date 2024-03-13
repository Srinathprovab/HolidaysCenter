//
//  NatinalityTVCell.swift
//  HolidaysCenter
//
//  Created by FCI on 19/05/23.
//

import UIKit

protocol NatinalityTVCellDelegate {
    func didTapOnNationalityBtnAction(cell:NatinalityTVCell)
    func didTapOnDirectFlightBtnAction(cell:NatinalityTVCell)
}

class NatinalityTVCell: UITableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nationalityView: UIView!
    @IBOutlet weak var nationalitylbl: UILabel!
    @IBOutlet weak var nationalityBtn: UIButton!
    @IBOutlet weak var directFlightsView: UIView!
    @IBOutlet weak var checkImg: UIImageView!
    @IBOutlet weak var dirctFlightlbl: UILabel!
    @IBOutlet weak var directFlightBtn: UIButton!
    
    var chkbool = true
    var delegate:NatinalityTVCellDelegate?
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
        holderView.backgroundColor = .AppHolderViewColor
        nationalityView.backgroundColor = .AppBGcolor
        nationalityView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        setuplabels(lbl: nationalitylbl, text: "Nationality", textcolor: .AppSubTitleColor, font: .OpenSansRegular(size: 14), align: .left)
        nationalityBtn.setTitle("", for: .normal)
        nationalityBtn.addTarget(self, action: #selector(didTapOnNationalityBtnAction(_:)), for: .touchUpInside)
        
        directFlightsView.backgroundColor = .clear
        setuplabels(lbl: dirctFlightlbl, text: "Direct Flights Only", textcolor: .AppSubTitleColor, font: .OpenSansRegular(size: 14), align: .left)
        directFlightBtn.setTitle("", for: .normal)
        directFlightBtn.addTarget(self, action: #selector(didTapOnDirectFlightBtnAction(_:)), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
    }
    
    @objc func reload(notification: NSNotification){
        self.nationalitylbl.text = notification.object as? String
    }
    
    
    @objc func didTapOnNationalityBtnAction(_ sender:UIButton) {
        delegate?.didTapOnNationalityBtnAction(cell: self)
    }
    
    @objc func didTapOnDirectFlightBtnAction(_ sender:UIButton) {
        
        if chkbool == true {
            checkImg.image = UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
            chkbool = false
        }else {
            checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
            chkbool = true
        }
        delegate?.didTapOnDirectFlightBtnAction(cell: self)
    }
    
}
