//
//  SelectTabCVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 16/08/22.
//

import UIKit

class SelectTabCVCell: UICollectionViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var tabImg: UIImageView!
   
    @IBOutlet weak var titlelbl: UILabel!
    
    var tabtitle = String()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        holderView.backgroundColor = .clear
       
    }

}
