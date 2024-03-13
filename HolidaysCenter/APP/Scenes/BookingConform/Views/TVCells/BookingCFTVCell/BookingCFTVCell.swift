//
//  BookingCFTVCell.swift
//  HolidaysCenter
//
//  Created by FCI on 16/06/23.
//

import UIKit

class BookingCFTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var bookingDetailsTV: UITableView!
    @IBOutlet weak var bookingDetailsTVHeight: NSLayoutConstraint!
    @IBOutlet weak var refundablelbl: UILabel!
    @IBOutlet weak var kwdlbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupTV(tv: bookingDetailsTV)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        bookingDetailsTVHeight.constant = (CGFloat(voucherSummery.count) * 130)
        bookingDetailsTV.reloadData()
    }
    
    
    func setupTV(tv:UITableView) {
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 5)
        tv.register(UINib(nibName: "VoucherFlightDetailsTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.tableFooterView = UIView()
        tv.isScrollEnabled = false
        tv.allowsMultipleSelection = true
    }
}


extension BookingCFTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return voucherSummery.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? VoucherFlightDetailsTVCell {
            
            
            let data = voucherSummery[indexPath.row]
            
            cell.airlinesnamelbl.text = data.operator_name
            cell.airlinescodelbl.text = "(\(data.operator_code ?? "")-\(data.flight_number ?? ""))"
            cell.logoImg.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            self.kwdlbl.text = "\(voucherCurrency):\(voucherPrice)"
            
            cell.fromtimelbl.text = data.origin?.time
            cell.totimelbl.text = data.destination?.time
            cell.fromcitylbl.text = data.origin?.city
            cell.tocitylbl.text = data.destination?.city
            cell.durationlbl.text = data.duration
            cell.noofstopslbl.text = "\(data.no_of_stops ?? 0) Stops"
            cell.datelbl.text = data.origin?.date
            cell.todatelbl.text = data.destination?.date
            
        
            if data.no_of_stops == 2 {
                cell.img1.isHidden = false
                cell.img2.isHidden = false
                cell.img3.isHidden = true
            }else if data.no_of_stops == 1 {
                cell.img1.isHidden = false
                cell.img2.isHidden = true
                cell.img3.isHidden = true
            }else {
                cell.img1.isHidden = true
                cell.img2.isHidden = true
                cell.img3.isHidden = true
            }
            
         
            
            c = cell
        }
        return c
    }
    
    
}
