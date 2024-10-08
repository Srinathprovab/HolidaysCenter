//
//  DashboardDealsTitleTVCell.swift
//  HolidaysCenter
//
//  Created by FCI on 18/05/23.
//

import UIKit

class DashboardDealsTitleTVCell: TableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func updateUI() {
        holderView.backgroundColor = .AppBGcolor
        setuplabels(lbl: titlelbl, text: cellInfo?.title ?? "", textcolor: .AppBtnColor, font: .OpenSansBold(size: 18), align: .center)
    }
    
}
