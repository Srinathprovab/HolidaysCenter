//
//  SpecialRequestTVCell.swift
//  HolidaysCenterApp
//
//  Created by FCI on 11/03/24.
//

import UIKit

protocol SpecialRequestTVCellDelegate {
    func textViewDidChange(textView:UITextView)
}

class SpecialRequestTVCell: TableViewCell, UITextViewDelegate {
    
    
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var specialRequestTV: UITableView!
    @IBOutlet weak var commentsTextView: UITextView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    var placeHolder = String()
    var delegate: SpecialRequestTVCellDelegate?
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
        topView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        topView.layer.cornerRadius = 6
        
        setupTV()
        setupdescView()
    }
    
    override func updateUI() {
        updateHeight(height: 53)
    }
    
    
    func updateHeight(height:Int) {
        tvHeight.constant = CGFloat(specialReq.count * height)
        specialRequestTV.reloadData()
    }
    
    
    
}


extension SpecialRequestTVCell {
    func setupdescView() {
        
        commentsTextView.layer.cornerRadius = 6
        commentsTextView.clipsToBounds = true
        commentsTextView.layer.borderWidth = 1
        commentsTextView.layer.borderColor = UIColor.AppBorderColor.cgColor
        
        commentsTextView.text = ""
        commentsTextView.delegate = self
        commentsTextView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        commentsTextView.setPlaceholder11(ph: placeHolder)
    }
    
    @objc func textViewDidChange(_ textView: UITextView) {
        textView.checkPlaceholder11()
        delegate?.textViewDidChange(textView: textView)
    }
    
    
    
}


extension SpecialRequestTVCell:UITableViewDataSource, UITableViewDelegate{
    
    func setupTV() {
        specialRequestTV.register(UINib(nibName: "specialRequestInfoTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        specialRequestTV.delegate = self
        specialRequestTV.dataSource = self
        specialRequestTV.separatorStyle = .none
        specialRequestTV.tableFooterView = UIView()
        specialRequestTV.isScrollEnabled = false
        specialRequestTV.allowsMultipleSelection = true
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specialReq.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! specialRequestInfoTVCell
        cell.selectionStyle = .none
        
        
        cell.titlelbl.text = specialReq[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? specialRequestInfoTVCell {
            cell.checkimg.image = UIImage(named: "chk")
            selectedSpecialReqArray.append(cell.titlelbl.text ?? "")
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? specialRequestInfoTVCell {
            cell.checkimg.image = UIImage(named: "uncheck")
            
            
            // Remove the item from selectedSpecialReqArray
            if let selectedIndex = selectedSpecialReqArray.firstIndex(of: cell.titlelbl.text ?? "") {
                selectedSpecialReqArray.remove(at: selectedIndex)
            }
            
        }
    }
    
    
}
