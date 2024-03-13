//
//  HotelPurchaseSummaryTVCell.swift
//  KuwaitWays
//
//  Created by FCI on 04/05/23.
//

import UIKit

class HotelPurchaseSummaryTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderview: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var roomtypelbl: UILabel!
    @IBOutlet weak var roomtypeValuelbl: UILabel!
    @IBOutlet weak var noofguestlbl: UILabel!
    @IBOutlet weak var noofguestValuelbl: UILabel!
    @IBOutlet weak var noofadultslbl: UILabel!
    @IBOutlet weak var noofadultsValuelbl: UILabel!
    @IBOutlet weak var chackinlbl: UILabel!
    @IBOutlet weak var chackinValuelbl: UILabel!
    @IBOutlet weak var chockoutlbl: UILabel!
    @IBOutlet weak var chockoutValuelbl: UILabel!
    @IBOutlet weak var cancellationPolicylbl: UILabel!
    @IBOutlet weak var cancellationPolicyValuelbl: UILabel!
    @IBOutlet weak var totalpricelbl: UILabel!
    @IBOutlet weak var totalpriceValuelbl: UILabel!
    @IBOutlet weak var totalamountlbl: UILabel!
    @IBOutlet weak var totalamountValuelbl: UILabel!
    @IBOutlet weak var ulview: UIView!
    @IBOutlet weak var promocodeView: UIView!
    @IBOutlet weak var discountValuelbl: UILabel!
    
    
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
        
        titlelbl.text = cellInfo?.title
        roomtypeValuelbl.text = cellInfo?.subTitle
        noofguestValuelbl.text = cellInfo?.text
        noofadultsValuelbl.text = cellInfo?.headerText
        chackinValuelbl.text = cellInfo?.buttonTitle
        chockoutValuelbl.text = cellInfo?.key
        cancellationPolicyValuelbl.text = cellInfo?.key1
        totalpriceValuelbl.text = cellInfo?.questionBase
        
       
        
        if hotelPromocodeBool {
            totalamountValuelbl.text = grandTotal
        }else {
            totalamountValuelbl.text = newGrandTotal
        }
        
        if cancellationPolicyValuelbl.text == "Refundable" {
            setuplabels(lbl: cancellationPolicyValuelbl, text: cellInfo?.key1 ?? "", textcolor: HexColor("#35CB00"), font: UIFont.OpenSansRegular(size: 14), align: .left)
        }else {
            setuplabels(lbl: cancellationPolicyValuelbl, text: cellInfo?.key1 ?? "", textcolor: HexColor("#FF0808"), font: UIFont.OpenSansRegular(size: 14), align: .left)
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(promocodeapply), name: Notification.Name("promocodeapply"), object: nil)
        
    }
    
    
    @objc func promocodeapply() {
        
        promocodeView.isHidden = false
        totalamountValuelbl.text = grandTotal
        discountValuelbl.text = promocodeDiscountValue
        
    }
    

    
    func setupUI() {
        contentView.backgroundColor = .AppHolderViewColor
        holderview.backgroundColor = .WhiteColor
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: UIFont.OpenSansMedium(size: 16), align: .left)
        setuplabels(lbl: roomtypelbl, text: "Room Type", textcolor: .AppLabelColor, font: UIFont.OpenSansRegular(size: 14), align: .left)
        setuplabels(lbl: noofguestlbl, text: "No Of Guest ", textcolor: .AppLabelColor, font: UIFont.OpenSansRegular(size: 14), align: .left)
        setuplabels(lbl: noofadultslbl, text: "No Of Adults", textcolor: .AppLabelColor, font: UIFont.OpenSansRegular(size: 14), align: .left)
        setuplabels(lbl: chackinlbl, text: "Check-In", textcolor: .AppLabelColor, font: UIFont.OpenSansRegular(size: 14), align: .left)
        setuplabels(lbl: chockoutlbl, text: "Check-Out", textcolor: .AppLabelColor, font: UIFont.OpenSansRegular(size: 14), align: .left)
        setuplabels(lbl: cancellationPolicylbl, text: "Cancellation Policy:", textcolor: .AppLabelColor, font: UIFont.OpenSansRegular(size: 14), align: .left)
        setuplabels(lbl: totalpricelbl, text: "Total price", textcolor: .AppLabelColor, font: UIFont.OpenSansRegular(size: 14), align: .left)
        setuplabels(lbl: totalamountlbl, text: "Total Amount", textcolor: .AppLabelColor, font: UIFont.OpenSansRegular(size: 14), align: .left)
        
        
        setuplabels(lbl: roomtypeValuelbl, text: "", textcolor: .AppLabelColor, font: UIFont.OpenSansRegular(size: 14), align: .right)
        setuplabels(lbl: noofguestValuelbl, text: " ", textcolor: .AppLabelColor, font: UIFont.OpenSansRegular(size: 14), align: .right)
        setuplabels(lbl: noofadultsValuelbl, text: "", textcolor: .AppLabelColor, font: UIFont.OpenSansRegular(size: 14), align: .right)
        setuplabels(lbl: chackinValuelbl, text: "", textcolor: .AppLabelColor, font: UIFont.OpenSansRegular(size: 14), align: .right)
        setuplabels(lbl: chockoutValuelbl, text: "", textcolor: .AppLabelColor, font: UIFont.OpenSansRegular(size: 14), align: .right)
        setuplabels(lbl: cancellationPolicyValuelbl, text: "", textcolor: HexColor("#FF0808"), font: UIFont.OpenSansRegular(size: 14), align: .right)
        setuplabels(lbl: totalpriceValuelbl, text: "", textcolor: .AppLabelColor, font: UIFont.OpenSansRegular(size: 14), align: .right)
        setuplabels(lbl: totalamountValuelbl, text: "", textcolor: .AppLabelColor, font: UIFont.OpenSansBold(size: 14), align: .right)
        
        
    }
    
    
    
    @IBAction func didTapOnCancelPromocodeBtnAction(_ sender: Any) {
        promocodeView.isHidden = true
        NotificationCenter.default.post(name: NSNotification.Name("cancelpromo"), object: nil)
        totalamountValuelbl.text = newGrandTotal
    }
    
}
