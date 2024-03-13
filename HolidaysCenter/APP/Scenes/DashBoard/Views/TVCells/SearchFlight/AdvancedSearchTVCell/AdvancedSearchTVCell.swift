//
//  AdvancedSearchTVCell.swift
//  HolidaysCenter
//
//  Created by FCI on 19/05/23.
//

import UIKit

protocol AdvancedSearchTVCellDelegate {
    func didTapOnAdvancedSearchBtnAction(cell:AdvancedSearchTVCell)
    func didTapOnAirlinesSelectBtnAction(cell:AdvancedSearchTVCell)
    func didTapOnEconomySelectBtnAction(cell:AdvancedSearchTVCell)
}

class AdvancedSearchTVCell: UITableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var advanceSearchBtn: UIButton!
    @IBOutlet weak var btnsView: UIStackView!
    @IBOutlet weak var AirlinesView: UIView!
    @IBOutlet weak var airlineslbl: UILabel!
    @IBOutlet weak var airlinesBtn: UIButton!
    @IBOutlet weak var economyView: UIView!
    @IBOutlet weak var economylbl: UILabel!
    @IBOutlet weak var economyBtn: UIButton!
    
    
    var showbool = true
    var delegate:AdvancedSearchTVCellDelegate?
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
        holderView.backgroundColor = HexColor("#F2F2F2",alpha: 0.50)
        advanceSearchBtn.setTitle("", for: .normal)
        advanceSearchBtn.addTarget(self, action: #selector(didTapOnAdvancedSearchBtnAction(_:)), for: .touchUpInside)
        btnsView.isHidden = true
        
        AirlinesView.backgroundColor = .AppBGcolor
        AirlinesView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        airlinesBtn.setTitle("", for: .normal)
        airlinesBtn.addTarget(self, action: #selector(didTapOnAirlinesSelectBtnAction(_:)), for: .touchUpInside)
        
        
        economyView.isHidden = true
        economyView.backgroundColor = .AppBGcolor
        economyView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        economyBtn.setTitle("", for: .normal)
        economyBtn.addTarget(self, action: #selector(didTapOnEconomySelectBtnAction(_:)), for: .touchUpInside)

        NotificationCenter.default.addObserver(self, selector: #selector(reload(_:)), name: NSNotification.Name("eco"), object: nil)
    }
    
    
    @objc func reload(_ notification: NSNotification){
        let key1 = notification.object as? String
        if key1 == "eco" {
            economylbl.text = notification.userInfo?["title"] as? String
        }else {
            airlineslbl.text = notification.userInfo?["title"] as? String
        }
    }
    
    
    @objc func didTapOnAdvancedSearchBtnAction(_ sender:UIButton) {
        delegate?.didTapOnAdvancedSearchBtnAction(cell: self)
    }
    
    @objc func didTapOnAirlinesSelectBtnAction(_ sender:UIButton) {
        delegate?.didTapOnAirlinesSelectBtnAction(cell: self)
    }
    
    @objc func didTapOnEconomySelectBtnAction(_ sender:UIButton) {
        delegate?.didTapOnEconomySelectBtnAction(cell: self)
    }
    
}
