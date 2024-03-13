//
//  RoomsTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 22/08/22.
//

import UIKit
protocol RoomsTVCellDelegate {
    func didTapOnCancellationPolicyBtn(cell:TwinSuperiorRoomTVCell)
    func didTapOnRoomTvcell(cell:TwinSuperiorRoomTVCell)
}

class RoomsTVCell: TableViewCell, TwinSuperiorRoomTVCellDelegate {
    
    
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var roomsTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    var initiallySelectedIndexPath: IndexPath?
    var selectedIndexPaths = Set<IndexPath>()
    var rooms = [[Rooms]]()
    var delegate:RoomsTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setInitiallySelectedIndexPath()
        setupTV()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setInitiallySelectedIndexPath() {
        // Set the initially selected index path, e.g., the first row of the first section
        initiallySelectedIndexPath = IndexPath(row: 0, section: 0)
    }
    
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        
        if let rooms1 = cellInfo?.moreData as? [[Rooms]] {
            rooms = rooms1
        }
        
        updateHeight()
    }
    
    
    func updateHeight() {
        tvHeight.constant = CGFloat(rooms.count * 130)
        roomsTV.reloadData()
    }
    
    
    func setupTV() {
        contentView.backgroundColor = .AppBGcolor
        roomsTV.register(UINib(nibName: "TwinSuperiorRoomTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        roomsTV.delegate = self
        roomsTV.dataSource = self
        roomsTV.tableFooterView = UIView()
        roomsTV.separatorStyle = .none
        roomsTV.backgroundColor = .WhiteColor
        roomsTV.isScrollEnabled = true
        roomsTV.layer.cornerRadius = 6
        roomsTV.clipsToBounds = true
        roomsTV.layer.borderWidth = 1
        roomsTV.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        roomsTV.isScrollEnabled = false
    }
    
    
    func didTapOnCancellationPolicyBtn(cell: TwinSuperiorRoomTVCell) {
        delegate?.didTapOnCancellationPolicyBtn(cell: cell)
    }
    
}



extension RoomsTVCell:UITableViewDataSource,UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return rooms.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms[section].count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TwinSuperiorRoomTVCell {
            cell.selectionStyle = .none
            cell.delegate = self
            
            if indexPath.section < rooms.count && indexPath.row < rooms[indexPath.section].count {
                
                
                let section = indexPath.section
                let row = indexPath.row
                let data = rooms[section][row]
                
                
                cell.room_selected = "\(data.room_selected ?? 0)"
                cell.titlelbl.text = data.name
                
                cell.kwdlbl.text = data.currency
                cell.kwdPricelbl.text = data.roomPrice
                cell.cancellationPoloicy = data.cancellationPolicies ?? []
                cell.noOfRoomslbl.text = "Avail Rooms: \(data.rooms ?? 1)"
                cell.token = data.token ?? ""
                cell.ratekey = data.rateKey ?? ""
                
                
                if data.refund == true {
                    cell.nonRefundablelbl.text = "Refundable"
                    cell.nonRefundablelbl.textColor = .AppBtnColor
                }else {
                    cell.nonRefundablelbl.text = "Non Refundable"
                    cell.nonRefundablelbl.textColor = HexColor("#FF0808")
                }
                
                
                
                // Check if the current indexPath is the initially selected indexPath
                if indexPath == initiallySelectedIndexPath {
                    
                    roomPrice = cell.kwdPricelbl.text ?? ""
                    room_selected = "0"
                    
                    cell.radioImg.image = UIImage(named: "radioSelected")
                    
                    defaults.set(cell.titlelbl.text, forKey: UserDefaultsKeys.roomType)
                    defaults.set(cell.nonRefundablelbl.text, forKey: UserDefaultsKeys.refundtype)
                    
                    
                    tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                    tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
                } else {
                    cell.radioImg.image = UIImage(named: "radioUnselected")
                }
                
            } else {
                print("Index out of range error: indexPath = \(indexPath)")
            }
            
            
            
            
            c = cell
        }
        return c
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TwinSuperiorRoomTVCell {
            cell.radioImg.image = UIImage(named: "radioSelected")
            
            defaults.set(cell.titlelbl.text, forKey: UserDefaultsKeys.roomType)
            defaults.set(cell.nonRefundablelbl.text, forKey: UserDefaultsKeys.refundtype)
            
            delegate?.didTapOnRoomTvcell(cell: cell)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TwinSuperiorRoomTVCell {
            cell.radioImg.image = UIImage(named: "radioUnselected")
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
