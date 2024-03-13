//
//  MulticityFromToTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 19/08/22.
//

import UIKit
protocol MulticityFromToTVCellDelegate {
    
    func didTapOnFromBtn(cell:MulticityFromToTVCell)
    func didTapOnToBtn(cell:MulticityFromToTVCell)
    func didTapOndateBtn(cell:MulticityFromToTVCell)
    func didTapOnCloseBtn(cell:MulticityFromToTVCell)
}

class MulticityFromToTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var fromlbl: UILabel!
    @IBOutlet weak var fromBtn: UIButton!
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var tolbl: UILabel!
    @IBOutlet weak var toBtn: UIButton!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var dateBtn: UIButton!
    @IBOutlet weak var closeView: UIView!
    @IBOutlet weak var closeImg: UIImageView!
    @IBOutlet weak var closeBtn: UIButton!
    
    
    var delegate:MulticityFromToTVCellDelegate?
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
       // setupViews(v: holderView, radius: 0, color: .AppBGColor)
        holderView.backgroundColor = .AppHolderViewColor
        setupViews(v: fromView, radius: 4, color: .AppBGcolor)
        setupViews(v: toView, radius: 4, color: .AppBGcolor)
        setupViews(v: dateView, radius: 4, color: .AppBGcolor)
        setupViews(v: closeView, radius: 10, color: .clear)
        setupLabels(lbl: fromlbl, text: "From", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 16))
        setupLabels(lbl: tolbl, text: "To", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 16))
        setupLabels(lbl: datelbl, text: "Date", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 16))
        fromBtn.setTitle("", for: .normal)
        toBtn.setTitle("", for: .normal)
        dateBtn.setTitle("", for: .normal)
        closeBtn.setTitle("", for: .normal)
        closeImg.image = UIImage(named: "close")
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
    
    
    @IBAction func didTapOnFromBtn(_ sender: Any) {
        delegate?.didTapOnFromBtn(cell: self)
    }
    
    
    @IBAction func didTapOnToBtn(_ sender: Any) {
        delegate?.didTapOnToBtn(cell: self)
    }
    
    
    @IBAction func didTapOndateBtn(_ sender: Any) {
        delegate?.didTapOndateBtn(cell: self)
    }
    
    @IBAction func didTapOnCloseBtn(_ sender: Any) {
        delegate?.didTapOnCloseBtn(cell: self)
    }
    
    
}
