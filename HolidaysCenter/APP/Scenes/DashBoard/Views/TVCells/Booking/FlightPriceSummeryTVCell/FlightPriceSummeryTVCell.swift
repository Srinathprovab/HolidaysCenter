//
//  FlightPriceSummeryTVCell.swift
//  HolidaysCenter
//
//  Created by FCI on 05/12/23.
//

import UIKit

class FlightPriceSummeryTVCell: TableViewCell {
    
    
    @IBOutlet weak var fareTypelbl: UILabel!
    @IBOutlet weak var basefarelbl: UILabel!
    @IBOutlet weak var taxlbl: UILabel!
    @IBOutlet weak var discountlbl: UILabel!
    @IBOutlet weak var grandTotallbl: UILabel!
    @IBOutlet weak var promocodeView: UIView!
    
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
        
        fareTypelbl.text = defaults.string(forKey: UserDefaultsKeys.flightrefundtype) ?? ""
        basefarelbl.text = String(format: "%.2f", Double(totalBaseFare) ?? 0.0)
        taxlbl.text = String(format: "%.2f", Double(totaltax) ?? 0.0)
        
        discountlbl.text = String(format: "%.2f", Double(promocodeDiscountValue) ?? 0.0)
        grandTotallbl.text = String(format: "%.2f", Double(totalTripCost) ?? 0.0)
        
       
        
        if fareTypelbl.text == "Refundable" {
            fareTypelbl.textColor = .Refundcolor
        }else {
            fareTypelbl.textColor = HexColor("#F00073")
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(promocodeapply), name: Notification.Name("promocodeapply"), object: nil)

    }
    
    @objc func promocodeapply() {
        promocodeView.isHidden = false
        
        grandTotallbl.text = grandTotal
        discountlbl.text = promocodeDiscountValue
    }
    
    
    @IBAction func didTapOnCancelPromocodeBtnAction(_ sender: Any) {
        promocodeView.isHidden = true
        NotificationCenter.default.post(name: NSNotification.Name("cancelpromo"), object: nil)
    }
    
    
}
