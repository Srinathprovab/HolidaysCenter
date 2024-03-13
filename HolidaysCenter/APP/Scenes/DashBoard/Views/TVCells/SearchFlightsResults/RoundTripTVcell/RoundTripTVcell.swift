//
//  RoundTripTVcell.swift
//  QBBYTravelApp
//
//  Created by FCI on 10/01/23.
//

import UIKit


protocol RoundTripTVcellDelegate {
    func didTaponRoundTripCell(cell:RoundTripTVcell)
}

class RoundTripTVcell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var flightDetailsTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var refundView: UIView!
    @IBOutlet weak var refundlbl: UILabel!
    @IBOutlet weak var kwdPricelbl: UILabel!
    
    
    var refundString = String()
    var delegate:RoundTripTVcellDelegate?
    var count = Int()
    var summery1 = [Summary]()
    var access_key1 = String()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setuUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        refundString = cellInfo?.refundable ?? ""
        access_key1 = cellInfo?.title ?? ""
        count = cellInfo?.characterLimit ?? 0
        kwdPricelbl.text = "Total Cost:\(cellInfo?.kwdprice ?? "")"
        refundlbl.text = "Total Pax:\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1")"
        
        summery1 = cellInfo?.moreData as! [Summary]
        tvHeight.constant = CGFloat((summery1.count * 115))
        flightDetailsTV.reloadData()
    }
    
    
    
    func setuUI() {
        
        contentView.backgroundColor = .AppHolderViewColor
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 6)
        setupTV()
        refundView.backgroundColor = .AppBtnColor
        refundView.layer.cornerRadius = 6
        refundView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        refundView.clipsToBounds = true
        setuplabels(lbl: kwdPricelbl, text: "", textcolor: .BtnTitleColor, font: .OpenSansBold(size: 16), align: .right)
        setuplabels(lbl: refundlbl, text: "", textcolor: .BtnTitleColor, font: .OpenSansMedium(size: 13), align: .left)
        
    }
    
    
    
    func setupTV() {
        flightDetailsTV.register(UINib(nibName: "RoundTripInfoTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        flightDetailsTV.delegate = self
        flightDetailsTV.dataSource = self
        flightDetailsTV.tableFooterView = UIView()
        flightDetailsTV.showsHorizontalScrollIndicator = false
        flightDetailsTV.separatorStyle = .singleLine
        flightDetailsTV.isScrollEnabled = false
    }
    
    
    
    
}


extension RoundTripTVcell:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return summery1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? RoundTripInfoTVCell {
            
            cell.selectionStyle = .none
            let data = summery1[indexPath.row]
            
            cell.refundlbl.text = cellInfo?.refundable ?? ""
            
            cell.fromCityTimelbl.text = data.origin?.time
            cell.fromCityNamelbl.text = "\(data.origin?.city ?? "")(\(data.origin?.loc ?? ""))"
            cell.toCityTimelbl.text = data.destination?.time
            cell.toCityNamelbl.text = "\(data.destination?.city ?? "")(\(data.destination?.loc ?? ""))"
            cell.hourslbl.text = data.duration
            cell.noOfStopslbl.text = "\(data.no_of_stops ?? 0) Stops"
            //   cell.inNolbl.text = "(\(data.operator_code ?? "")-\(data.operator_name ?? ""))"
            cell.logoImg.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            
            setAttributedText(str1: "\(data.operator_code ?? "")-\(data.flight_number ?? "") ",
                              str2: data.operator_name ?? "",
                              lbl: cell.inNolbl,
                              color1: UIColor.AppLabelColor,
                              color2: UIColor.SubTitleColor,
                              font1: UIFont.OpenSansRegular(size: 14),
                              font2: UIFont.OpenSansRegular(size: 12))
            
            c = cell
            
        }
        return c
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTaponRoundTripCell(cell: self)
    }
    
}
