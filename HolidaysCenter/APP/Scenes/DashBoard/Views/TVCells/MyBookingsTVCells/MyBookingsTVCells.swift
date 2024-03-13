//
//  MyBookingsTVCells.swift
//  KuwaitWays
//
//  Created by FCI on 08/05/23.
//

import UIKit

protocol MyBookingsTVCellsDelegate {
    func didTapOnViewVocherBtnAction(cell:MyBookingsTVCells)
}

class MyBookingsTVCells: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var inNolbl: UILabel!
    @IBOutlet weak var fromCityTimelbl: UILabel!
    @IBOutlet weak var fromCityNamelbl: UILabel!
    @IBOutlet weak var fromDatelbl: UILabel!
    @IBOutlet weak var toCityTimelbl: UILabel!
    @IBOutlet weak var toCityNamelbl: UILabel!
    @IBOutlet weak var toDatelbl: UILabel!
    @IBOutlet weak var hourslbl: UILabel!
    @IBOutlet weak var noOfStopslbl: UILabel!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var totalPricelbl: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var viewVocherBtnView: UIView!
    @IBOutlet weak var viewVocherlbl: UILabel!
    @IBOutlet weak var viewVocherBtn: UIButton!
    @IBOutlet weak var round2: UIImageView!
    @IBOutlet weak var round1: UIImageView!
    @IBOutlet weak var round3: UIImageView!
    
    var access_key1 = String()
    var delegate:MyBookingsTVCellsDelegate?
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
        
        access_key1 = cellInfo?.title ?? ""
        inNolbl.text = cellInfo?.airlinesCode
        fromCityTimelbl.text = cellInfo?.fromTime
        fromCityNamelbl.text = cellInfo?.fromCity
        toCityTimelbl.text = cellInfo?.toTime
        toCityNamelbl.text = cellInfo?.toCity
        hourslbl.text = cellInfo?.travelTime
        noOfStopslbl.text = cellInfo?.noosStops
        kwdlbl.text = cellInfo?.kwdprice
        fromDatelbl.text = convertDateFormat(inputDate: cellInfo?.fromdate ?? "", f1: "dd MMM yyyy", f2: "dd-MM-yyyy")
        toDatelbl.text = convertDateFormat(inputDate: cellInfo?.todate ?? "", f1: "dd MMM yyyy", f2: "dd-MM-yyyy")
        
        logoImg.sd_setImage(with: URL(string: cellInfo?.airlineslogo ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        
        
        switch cellInfo?.noosStops {
        case "0 Stops":
            round1.isHidden = true
            round2.isHidden = true
            round3.isHidden = true
            break
        case "1 Stops":
            round1.isHidden = false
            round2.isHidden = true
            round3.isHidden = true
            break
        case "2 Stops":
            round1.isHidden = false
            round2.isHidden = false
            round3.isHidden = true
            break
        default:
            break
        }
        
        if cellInfo?.key == "completed" {
            bottomView.isHidden = false
        }
        
        
    }
    
    func setupUI() {
        bottomView.isHidden = true
        contentView.backgroundColor = .AppHolderViewColor
        
        
//        round1.isHidden = true
//        round2.isHidden = true
//        round3.isHidden = true
        
        viewVocherBtnView.backgroundColor = .AppNavBackColor
        viewVocherBtnView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 3)
        setuplabels(lbl: totalPricelbl, text: "Total Price", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 14), align: .right)
        setuplabels(lbl: kwdlbl, text: "", textcolor: .AppLabelColor, font: .oswaldRegular(size: 18), align: .right)
        setuplabels(lbl: viewVocherlbl, text: "View Vocher", textcolor: .WhiteColor, font: .OpenSansBold(size: 16), align: .center)
        
        viewVocherBtn.addTarget(self, action: #selector(didTapOnViewVocherBtnAction(_:)), for: .touchUpInside)
        
        
        bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner] // Bottom left corner, Bottom right corner respectively
        bottomView.layer.cornerRadius = 6
        bottomView.clipsToBounds = true
        
        
        
    }
    
    
    @objc func didTapOnViewVocherBtnAction(_ sender:UIButton) {
        delegate?.didTapOnViewVocherBtnAction(cell: self)
    }
    
    
}
