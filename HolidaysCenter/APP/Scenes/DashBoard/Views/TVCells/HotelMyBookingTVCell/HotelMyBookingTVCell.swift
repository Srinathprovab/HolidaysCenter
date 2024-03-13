//
//  HotelMyBookingTVCell.swift
//  HolidaysCenter
//
//  Created by FCI on 18/12/23.
//

import UIKit
protocol HotelMyBookingTVCellDelegate {
    func didTapOnVoucherBtnAction(cell:HotelMyBookingTVCell)
}

class HotelMyBookingTVCell: TableViewCell {
    
    @IBOutlet weak var hotelnamelbl: UILabel!
    @IBOutlet weak var hotelAddresslbl: UILabel!
    @IBOutlet weak var checkinlbl: UILabel!
    @IBOutlet weak var checkoutlbl: UILabel!
    @IBOutlet weak var voucherBtn: UIButton!
    
    
    var pdfUrlString = String()
    var delegate:HotelMyBookingTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        contentView.backgroundColor = .AppHolderViewColor
        
        hotelnamelbl.text = cellInfo?.title ?? ""
        hotelAddresslbl.text = cellInfo?.subTitle ?? ""
        pdfUrlString = cellInfo?.tempText ?? ""
        checkinlbl.text = convertDateFormat(inputDate: cellInfo?.buttonTitle ?? "",
                                            f1: "yyyy-MM-dd",
                                            f2: "dd MMM,yyyy")
        
        checkoutlbl.text = convertDateFormat(inputDate: cellInfo?.text ?? "",
                                             f1: "yyyy-MM-dd",
                                             f2: "dd MMM,yyyy")
        
        voucherBtn.layer.cornerRadius = 4
        
        voucherBtn.addTarget(self, action: #selector(didTapOnVoucherBtnAction(_:)), for: .touchUpInside)
        
        
        //        if cellInfo?.key == "completed" {
        //            voucherBtnView.isHidden = false
        //        }else {
        //            voucherBtnView.isHidden = true
        //        }
    }
    
    
    @objc func didTapOnVoucherBtnAction(_ sender:UIButton) {
        delegate?.didTapOnVoucherBtnAction(cell: self)
    }
    
}
