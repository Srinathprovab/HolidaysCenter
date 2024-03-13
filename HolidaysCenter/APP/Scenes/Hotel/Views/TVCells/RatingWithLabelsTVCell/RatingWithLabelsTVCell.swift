//
//  RatingWithLabelsTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 22/08/22.
//

import UIKit
import AARatingBar

class RatingWithLabelsTVCell: TableViewCell {

    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var ratingBar: AARatingBar!
    
    @IBOutlet weak var holderView: UIView!
    
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
        subtitlelbl.text = cellInfo?.subTitle
        ratingBar.value = CGFloat(cellInfo?.characterLimit ?? 0)
        
        if cellInfo?.key == "rating" {
            ratingBar.isHidden = false
            subtitlelbl.attributedText = cellInfo?.subTitle?.htmlToAttributedString
            subtitlelbl.textColor = .AppLabelColor
        }
        
        
        if cellInfo?.characterLimit == 0 {
            ratingBar.isHidden = true
        }else {
            ratingBar.isHidden = false
        }
    }
    
    func setupUI() {
        holderView.backgroundColor = .AppBGcolor
        setupLabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 18))
        setupLabels(lbl: subtitlelbl, text: "", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 14))
        ratingBar.maxValue = 5
        ratingBar.color = HexColor("#FABF35")
        ratingBar.isHidden = true
        ratingBar.isUserInteractionEnabled = false
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
    
    
}
