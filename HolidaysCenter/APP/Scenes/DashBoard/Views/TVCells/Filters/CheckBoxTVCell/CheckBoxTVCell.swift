//
//  CheckBoxTVCell.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit



protocol CheckBoxTVCellDelegate {
    func didTapOnCheckBoxDropDownBtn(cell:CheckBoxTVCell)
    func didTapOnShowMoreBtn(cell:CheckBoxTVCell)
    func didTapOnCheckBox(cell:checkOptionsTVCell)
    func didTapOnDeselectCheckBox(cell:checkOptionsTVCell)
    
}

class CheckBoxTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var checkOptionsTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var downImg: UIImageView!
    @IBOutlet weak var downBtn: UIButton!
    
    
    
    var selectedIndices = [IndexPath]()
    var timeArray = ["time1","time2","time3","time4"]
    var key = String()
    var b = true
    var nameArray = [String]()
    var tvheight = CGFloat()
    var showbool = true
    var delegate:CheckBoxTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupTV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
    
    override func prepareForReuse() {
        // tvHeight.constant = 0
    }
    
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        nameArray = cellInfo?.data as? [String] ?? []
        self.key = cellInfo?.key ?? ""
        
        if self.key == "hotel" {
            downImg.isHidden = true
            expand()
        }
        
        expand()
        
        
    }
    
    func setupUI() {
        // tvHeight.constant = 0
        expand()
        downImg.image = UIImage(named: "downarrow")
        holderView.backgroundColor = .WhiteColor
        titlelbl.textColor = .AppLabelColor
        titlelbl.font = UIFont.OswaldSemiBold(size: 16)
        titlelbl.numberOfLines = 0
        
        downBtn.setTitle("", for: .normal)
        downBtn.addTarget(self, action: #selector(didTapOnCheckBoxDropDownBtn(_:)), for: .touchUpInside)
        downBtn.isHidden = true
        
    }
    
    func setupTV() {
        checkOptionsTV.register(UINib(nibName: "checkOptionsTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        checkOptionsTV.delegate = self
        checkOptionsTV.dataSource = self
        checkOptionsTV.separatorStyle = .none
        checkOptionsTV.tableFooterView = UIView()
        checkOptionsTV.isScrollEnabled = false
        checkOptionsTV.allowsMultipleSelection = true
    }
    
    
    @objc func didTapOnCheckBoxDropDownBtn(_ sender: UIButton){
        delegate?.didTapOnCheckBoxDropDownBtn(cell: self)
    }
    
    
    func hide() {
        //tvHeight.constant = 0
    }
    func expand() {
        tvHeight.constant = CGFloat(nameArray.count * 50)
        checkOptionsTV.reloadData()
    }
    
}



extension CheckBoxTVCell: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! checkOptionsTVCell
        cell.selectionStyle = .none
        cell.titlelbl.text = nameArray[indexPath.row]
        cell.filtertitle = self.titlelbl.text ?? ""

        // Check if this indexPath is in the selectedIndices array
        if selectedIndices.contains(indexPath) {
            cell.checkImg.image = UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
        } else {
            cell.checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
        }

        // Explicitly set the cell's appearance here
        cell.setSelected(selectedIndices.contains(indexPath), animated: false)

        if let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            if tabselect == "Flight" {
                showSelectedFlightsFilterValues(cell: cell, indexPath: indexPath)
            } else {
                showSelectedHotelFilterValues(cell: cell, indexPath: indexPath)
            }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? checkOptionsTVCell {
            if !selectedIndices.contains(indexPath) {
                selectedIndices.append(indexPath)
                cell.checkImg.image = UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
            }
            delegate?.didTapOnCheckBox(cell: cell)
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? checkOptionsTVCell {
            if let index = selectedIndices.firstIndex(of: indexPath) {
                selectedIndices.remove(at: index)
                cell.checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
            }
            delegate?.didTapOnDeselectCheckBox(cell: cell)
        }
    }
}


extension CheckBoxTVCell{
    
    //MARK: - showSelectedFlightsFilterValues checkOptionsTVCell
    
    func showSelectedFlightsFilterValues(cell:checkOptionsTVCell,indexPath:IndexPath) {
        
        
        
        // Check the section title to determine which filter to apply
        switch titlelbl.text {
            
            
            
            
        case "No Of Stops":

            if !filterModel.noOfStops.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                 if let labelText = cell.titlelbl.text {
                    let words = labelText.components(separatedBy: " ")

                    // Check if any word in words exists in filterModel.noOfStops
                    if words.contains(where: { stop in
                        return filterModel.noOfStops.contains(stop)
                    }) {
                        DispatchQueue.main.async {
                            cell.checkImg.image = UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
                            self.selectedIndices.append(indexPath)
                            self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                        }
                        print("Selected: \(cell.titlelbl.text ?? "")")
                    } else {
                        DispatchQueue.main.async {
                            cell.checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
                        }
                        print("Deselected: \(cell.titlelbl.text ?? "")")
                    }
                }
            } else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
      
           
            
        case "Departure Time":
            if !filterModel.departureTime.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if filterModel.departureTime.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.checkImg.image = UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
            
        case "Arrival Time":
            if !filterModel.arrivalTime.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if filterModel.arrivalTime.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.checkImg.image = UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
            
            
        case "Cancellations Type":
            if !filterModel.refundableTypes.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if filterModel.refundableTypes.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.checkImg.image = UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
            
            
        case "Airlines":
            if !filterModel.airlines.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                if filterModel.airlines.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.checkImg.image = UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
            
        case "Connecting Flights":
            if !filterModel.connectingFlights.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                if filterModel.connectingFlights.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.checkImg.image = UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
        case "Connecting Airports":
            if !filterModel.connectingAirports.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                if filterModel.connectingAirports.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.checkImg.image = UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.checkImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
                }
            }
        default:
            break
        }
    }
    
    
    
    
    
    //MARK: - showSelectedHotelFilterValues checkOptionsTVCell
    
    func showSelectedHotelFilterValues(cell:checkOptionsTVCell,indexPath:IndexPath) {
        
        // Check the section title to determine which filter to apply
        switch titlelbl.text {
            
        case "Refundable Type":
            if !hotelfiltermodel.refundableTypes.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if hotelfiltermodel.refundableTypes.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.sele()
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.unselected() // Deselect the cell
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
            
            
        case "Hotel Location":
            if !hotelfiltermodel.nearByLocA.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if hotelfiltermodel.nearByLocA.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.sele()
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.unselected() // Deselect the cell
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
            
        case "Facilities":
            if !hotelfiltermodel.aminitiesA.isEmpty {
                // Check if the cell's title matches any value in the luggage array
                
                
                if hotelfiltermodel.aminitiesA.contains(cell.titlelbl.text ?? "") {
                    
                    DispatchQueue.main.async {
                        cell.sele()
                        self.selectedIndices.append(indexPath)
                        self.checkOptionsTV.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    }
                    print("Selected: \(cell.titlelbl.text ?? "")")
                } else {
                    
                    DispatchQueue.main.async {
                        cell.unselected() // Deselect the cell
                    }
                    print("Deselected: \(cell.titlelbl.text ?? "")")
                }
            }else {
                DispatchQueue.main.async {
                    cell.unselected() // Deselect the cell
                }
            }
            
            
            
        default:
            break
        }
    }
    
}
