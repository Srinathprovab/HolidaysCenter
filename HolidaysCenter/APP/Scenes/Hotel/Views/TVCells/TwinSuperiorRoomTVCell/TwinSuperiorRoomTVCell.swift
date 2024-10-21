//
//  TwinSuperiorRoomTVself.swift
//  BeeoonsApp
//
//  Created by MA673 on 22/08/22.
//

import UIKit


protocol TwinSuperiorRoomTVCellDelegate {
    func didTapOnCancellationPolicyBtn(cell:TwinSuperiorRoomTVCell)
}

class TwinSuperiorRoomTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var cancellationPoloicyBtn: UIButton!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var noOfRoomslbl: UILabel!
    @IBOutlet weak var nonRefundablelbl: UILabel!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var kwdPricelbl: UILabel!
    @IBOutlet weak var radioImg: UIImageView!
    
    
    var selectedindex = 0
    var room : Rooms?
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
        if isSelected == true {
            self.radioImg.image = UIImage(named: "radioSelected")
        }else {
            self.radioImg.image = UIImage(named: "radioUnselected")
        }
    }
    

    
    
    override func prepareForReuse() {
        
//        if selectedindex == (Int(cellInfo?.title ?? "") ?? 0) {
//            self.radioImg.image = UIImage(named: "radioSelected")
//        }else {
//            self.radioImg.image = UIImage(named: "radioUnselected")
//        }
    }
    
    override func updateUI() {
        room = cellInfo?.moreData as? Rooms
        
        
        self.room_selected = "\(room?.room_selected ?? 0)"
        self.titlelbl.text = room?.name
        
        self.kwdlbl.text = room?.currency
        self.kwdPricelbl.text = room?.roomPrice
        self.cancellationPoloicy = room?.cancellationPolicies ?? []
        self.noOfRoomslbl.text = "Avail Rooms: \(room?.rooms ?? 1)"
        self.token = room?.token ?? ""
        self.ratekey = room?.rateKey ?? ""
        
        
        if room?.refund == true {
            self.nonRefundablelbl.text = "Refundable"
            self.nonRefundablelbl.textColor = .AppBtnColor
        }else {
            self.nonRefundablelbl.text = "Non Refundable"
            self.nonRefundablelbl.textColor = HexColor("#FF0808")
        }
        
        
    }
    
    func setupUI() {
        contentView.backgroundColor = .WhiteColor
        holderView.backgroundColor = .WhiteColor
        radioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
        cancellationPoloicyBtn.setTitle("", for: .normal)
        
        cancellationPoloicyBtn.addTarget(self, action: #selector(didTapOnCancellationPolicyBtn), for: .touchUpInside)
    }
    
    
    @objc func didTapOnCancellationPolicyBtn() {
        delegate?.didTapOnCancellationPolicyBtn(cell: self)
    }
    
}
