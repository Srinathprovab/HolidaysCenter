//
//  NavBar.swift
//  AirportProject
//
//  Created by Codebele 09 on 21/06/22.
//

import UIKit
import Foundation

class NavBar: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var citylbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var travellerlbl: UILabel!
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var editImg: UIImageView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterImg: UIImageView!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var bg: UIImageView!
    
    var titleString = String()
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("NavBar", owner: self, options: nil)
        contentView.frame = self.bounds
        addSubview(contentView)
        
        setupuiview()
    }
    
    
    
    func setupuiview(){
        contentView.backgroundColor = .AppBackgroundColor
        bg.isHidden = true
        
        backBtn.setTitle("", for: .normal)
        editBtn.setTitle("", for: .normal)
        filterBtn.setTitle("", for: .normal)
        
        
        setuplabels(lbl: titlelbl, text: "", textcolor: .BtnTitleColor, font: .OpenSansMedium(size: 20), align: .center)
        setuplabels(lbl: citylbl, text: "", textcolor: .BtnTitleColor, font: .OpenSansMedium(size: 16), align: .center)
        setuplabels(lbl: datelbl, text: "", textcolor: .BtnTitleColor, font: .OpenSansRegular(size: 12), align: .center)
        setuplabels(lbl: travellerlbl, text: "", textcolor: .BtnTitleColor, font: .OpenSansRegular(size: 12), align: .center)
        backBtn.tintColor = .BtnTitleColor
      //  setupViews(v: editView, radius: 4, color: .WhiteColor.withAlphaComponent(0.40))
        editView.isHidden = true
       // editView.backgroundColor = .appbt
      //  setupViews(v: filterView, radius: 4, color: .WhiteColor.withAlphaComponent(0.40))

        filterView.isHidden = true
       // filterView.backgroundColor = .AppJournyTabSelectColor
        editImg.image = UIImage(named: "edit")?.withRenderingMode(.alwaysOriginal).withTintColor(.BtnTitleColor)
        filterImg.image = UIImage(named: "filter")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
        
        
        citylbl.isHidden = true
        datelbl.isHidden = true
        travellerlbl.isHidden = true
    }
    
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.2
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    
}



