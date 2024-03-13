//
//  FromCityTVCell.swift
//  BabSafar
//
//  Created by MA673 on 20/07/22.
//

import UIKit

class FromCityTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var plainImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subTitlelbl: UILabel!
    
    var cityname = String()
    var id = String()
    var label = String()
    var citycode = String()
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
        plainImg.image = UIImage(named: "flight")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#9C7945"))
        setuplabels(lbl: titlelbl, text: cellInfo?.title ?? "", textcolor: .AppBtnColor, font: .OpenSansRegular(size: 16), align: .left)

        titlelbl.numberOfLines = 1
    }
    
    
    
    func setAttributedString(str1:String,str2:String) {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.AppBtnColor,NSAttributedString.Key.font:UIFont.OpenSansLight(size: 13)] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:UIColor.AppBtnColor,NSAttributedString.Key.font:UIFont.OpenSansRegular(size: 13)] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
       
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        
        subTitlelbl.attributedText = combination
        
    }
    
}
