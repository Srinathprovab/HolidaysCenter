//
//  HolderViewTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 17/08/22.
//

import UIKit
import DropDown


class HolderViewTVCell: UITableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var locImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var dropdownimg: UIImageView!
    @IBOutlet weak var fromBtn: UIButton!
    
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var locImg1: UIImageView!
    @IBOutlet weak var tolabel: UILabel!
    @IBOutlet weak var toBtn: UIButton!
    
    @IBOutlet weak var swipeView: UIView!
    @IBOutlet weak var swipeImg: UIImageView!
    @IBOutlet weak var swipeBtn: UIButton!
    
    
    var nationalityCode = String()
    let dropDown = DropDown()
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
        
        contentView.backgroundColor = .AppHolderViewColor
        setupViews(v: holderView, radius: 4, color: HexColor("#E6E8E7",alpha: 0.20))
        setupLabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 16))
        locImg.image = UIImage(named: "loc")?.withRenderingMode(.alwaysOriginal)
        dropdownimg.image = UIImage(named: "downarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
        dropdownimg.isHidden = true
        
        setupViews(v: toView, radius: 4, color: HexColor("#E6E8E7",alpha: 0.20))
        setupLabels(lbl: tolabel, text: "To", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 16))
        locImg1.image = UIImage(named: "loc")?.withRenderingMode(.alwaysOriginal)
        toView.isHidden = true
       
        swipeBtn.setTitle("", for: .normal)
        swipeBtn.addTarget(self, action: #selector(swapCity(_:)), for: .touchUpInside)
        
        fromBtn.setTitle("", for: .normal)
        toBtn.setTitle("", for: .normal)
        
        
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    @objc func swapCity(_ sender:UIButton) {
        
        let a = self.titlelbl.text
        let b = self.tolabel.text
        let c = defaults.string(forKey: UserDefaultsKeys.fromlocid)
        let d = defaults.string(forKey: UserDefaultsKeys.tolocid)
        let e = defaults.string(forKey: UserDefaultsKeys.fromcityname)
        let f = defaults.string(forKey: UserDefaultsKeys.tocityname)
        
        self.titlelbl.text = b
        self.tolabel.text = a
        
        defaults.set(self.titlelbl.text, forKey: UserDefaultsKeys.fromCity)
        defaults.set(self.tolabel.text, forKey: UserDefaultsKeys.toCity)
        defaults.set(d, forKey: UserDefaultsKeys.fromlocid)
        defaults.set(c, forKey: UserDefaultsKeys.tolocid)
        defaults.set(f, forKey: UserDefaultsKeys.fromcityname)
        defaults.set(e, forKey: UserDefaultsKeys.tocityname)
        
    }
    
    
    func setupDropDown() {
        self.titlelbl.textColor = .SubTitleColor
        dropDown.textColor = .AppLabelColor
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.holderView
        dropDown.bottomOffset = CGPoint(x: 0, y: holderView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.titlelbl.text = item
            self?.titlelbl.textColor = .AppLabelColor
            
            starRatingInputArray.removeAll()
          
            
            switch self?.titlelbl.text {
                
            case "Select Star":
                starRatingInputArray.removeAll()
                break
                
                
            case "1 star to less":
                starRatingInputArray.append("1")
                break
                
            case "2 star to less":
                for i in 1...2 {
                    starRatingInputArray.append("\(i)")
                }
                break
                
            case "3 star to less":
                for i in 1...3 {
                    starRatingInputArray.append("\(i)")
                }
                break
                
            case "4 star to less":
                for i in 1...4 {
                    starRatingInputArray.append("\(i)")
                }
                break
                
            case "5 star to less":
                for i in 1...5 {
                    starRatingInputArray.append("\(i)")
                }
                break
                
                
                
            case "1 star to more":
               
                for i in 1...5 {
                    starRatingInputArray.append("\(i)")
                }
                break
                
            case "2 star to more":
                for i in 2...5 {
                    starRatingInputArray.append("\(i)")
                }
                break
                
            case "3 star to more":
                for i in 3...5 {
                    starRatingInputArray.append("\(i)")
                }
                break
                
            case "4 star to more":
                for i in 4...5 {
                    starRatingInputArray.append("\(i)")
                }
                break
                
            case "5 star to more":
                starRatingInputArray.append("5")
                break
                
            default:
                break
            }
            
            
            defaults.setValue(item, forKey: UserDefaultsKeys.starInputString)
            
        }
        
    }
    
    
    
    
    
    @IBAction func didTapONFromBtn(_ sender: Any) {
        dropDown.show()
    }
    
    
    @IBAction func didTapONToBtn(_ sender: Any) {
        
    }
    
}
