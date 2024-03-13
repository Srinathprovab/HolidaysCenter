//
//  ItineraryTVCell.swift
//  QBBYTravelApp
//
//  Created by FCI on 10/01/23.
//

import UIKit

class ItineraryTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var inNolbl: UILabel!
    @IBOutlet weak var airlinecodelbl: UILabel!
    @IBOutlet weak var fromCityTimelbl: UILabel!
    @IBOutlet weak var fromCityNamelbl: UILabel!
    @IBOutlet weak var fromCityDatelbl: UILabel!
    @IBOutlet weak var toCityTimelbl: UILabel!
    @IBOutlet weak var toCityNamelbl: UILabel!
    @IBOutlet weak var toCityDatelbl: UILabel!
    @IBOutlet weak var hourslbl: UILabel!
    @IBOutlet weak var noOfStopslbl: UILabel!
//    @IBOutlet weak var round2: UIImageView!
//    @IBOutlet weak var round1: UIImageView!
//    @IBOutlet weak var round3: UIImageView!
    @IBOutlet weak var layoverView: UIView!
    @IBOutlet weak var layoverCitylbl: UILabel!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
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
        
        holderView.backgroundColor = .WhiteColor
      //  holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 6)
        logoImg.image = UIImage(named: "indigo")?.withRenderingMode(.alwaysOriginal)
        logoImg.contentMode = .scaleToFill
        setuplabels(lbl: inNolbl, text: "", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 12), align: .left)
        setuplabels(lbl: airlinecodelbl, text: "", textcolor: .AppLabelColor, font: .OpenSansBold(size: 14), align: .left)
        setuplabels(lbl: fromCityTimelbl, text: "", textcolor: .AppLabelColor, font: .OswaldSemiBold(size: 22), align: .left)
        setuplabels(lbl: toCityTimelbl, text: "", textcolor: .AppLabelColor, font: .OswaldSemiBold(size: 22), align: .right)
        setuplabels(lbl: fromCityDatelbl, text: "", textcolor: .AppLabelColor, font: .oswaldRegular(size: 12), align: .left)
        setuplabels(lbl: toCityDatelbl, text: "", textcolor: .AppLabelColor, font: .oswaldRegular(size: 12), align: .right)
        setuplabels(lbl: fromCityNamelbl, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 12), align: .left)
        setuplabels(lbl: toCityNamelbl, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 12), align: .right)
        setuplabels(lbl: hourslbl, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 12), align: .center)
        setuplabels(lbl: noOfStopslbl, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 12), align: .center)
        layoverView.backgroundColor = HexColor("#E6E8E7")
        setuplabels(lbl: layoverCitylbl, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 12), align: .center)

        
        fromCityNamelbl.numberOfLines = 1
        toCityNamelbl.numberOfLines = 1
        
        
        
    }
    
    
    func setHeight(){
        viewHeight.constant = 170
    }
    
    func setlayoverhideHeight(){
        viewHeight.constant = 124
    }
}
