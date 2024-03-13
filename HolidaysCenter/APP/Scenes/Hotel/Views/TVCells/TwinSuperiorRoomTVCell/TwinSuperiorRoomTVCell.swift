//
//  TwinSuperiorRoomTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 22/08/22.
//

import UIKit


protocol TwinSuperiorRoomTVCellDelegate {
    func didTapOnCancellationPolicyBtn(cell:TwinSuperiorRoomTVCell)
}

class TwinSuperiorRoomTVCell: UITableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var roomImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var cancellationPoloicyBtn: UIButton!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var noOfRoomslbl: UILabel!
    @IBOutlet weak var nonRefundablelbl: UILabel!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var kwdPricelbl: UILabel!
    @IBOutlet weak var radioImg: UIImageView!
    
    var cancellationPoloicy = [String]()
    var ratekey = String()
    var refundValue = String()
    var room_selected = String()
    var token = String()
    var delegate:TwinSuperiorRoomTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
//        if isSelected == true {
//            self.radioImg.image = UIImage(named: "radioSelected")
//
//        }else {
//            self.radioImg.image = UIImage(named: "radioUnselected")
//        }
    }
    
//    override func prepareForReuse() {
//        self.radioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
//    }
//
    
    func setupUI() {
        contentView.backgroundColor = .WhiteColor
        holderView.backgroundColor = .WhiteColor
        roomImg.image = UIImage(named: "hotel1")
        radioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
        cancellationPoloicyBtn.setTitle("", for: .normal)
        
        cancellationPoloicyBtn.addTarget(self, action: #selector(didTapOnCancellationPolicyBtn), for: .touchUpInside)
    }
    
    
    @objc func didTapOnCancellationPolicyBtn() {
        delegate?.didTapOnCancellationPolicyBtn(cell: self)
    }
    
}
