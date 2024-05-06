//
//  SearchFlightTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 17/08/22.
//

import UIKit


protocol SearchFlightTVCellDelegate {
    
    func didTapOnFromCity(cell:HolderViewTVCell)
    func didTapOnToCity(cell:HolderViewTVCell)
    func didTapOnSelectDepDateBtn(cell:DualViewTVCell)
    func didTapOnSelectRepDateBtn(cell:DualViewTVCell)
    func didTapOnAddTravelerEconomy(cell:HolderViewTVCell)
    func didTapOnSearchFlightsBtn(cell:SearchFlightTVCell)
    func didTapOnLocationOrCityBtn(cell:HolderViewTVCell)
    func didTapOnAddRooms(cell:HolderViewTVCell)
    func didtapOnCheckInBtn(cell:DualViewTVCell)
    func didtapOnCheckOutBtn(cell:DualViewTVCell)
    func didTapOnSearchHotelsBtn(cell:ButtonTVCell)
    func didTapOnNationalityBtnAction(cell:NatinalityTVCell)
    func didTapOnAirlinesSelectBtnAction(cell:AdvancedSearchTVCell)
    func didTapOnEconomySelectBtnAction(cell:AdvancedSearchTVCell)
    
    func didTapOnHotelNationalityBtnAction(cell:HolderViewTVCell)
    
    func donedatePicker(cell:SearchFlightTVCell)
    func cancelDatePicker(cell:SearchFlightTVCell)
}

class SearchFlightTVCell: TableViewCell,DualViewTVCellDelegate,ButtonTVCellDelegate, NatinalityTVCellDelegate, AdvancedSearchTVCellDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var searchFlightTV: UITableView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    
    let depDatePicker = UIDatePicker()
    let retdepDatePicker = UIDatePicker()
    let retDatePicker = UIDatePicker()
    var countryNameArray = [String]()
    var key = String()
    var delegate:SearchFlightTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupTV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        self.key = cellInfo?.key ?? ""
        if self.key == "hotel" {
            viewHeight.constant = 350
        }else {
            viewHeight.constant = 420
        }
        
        countrylist.forEach { i in
            countryNameArray.append(i.name ?? "")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name("reload"), object: nil)
        searchFlightTV.reloadData()
    }
    
    @objc func reload(){
        searchFlightTV.reloadData()
    }
    
    
    
    func setupTV() {
        
        holderView.backgroundColor = .AppBGcolor
        searchFlightTV.layer.cornerRadius = 10
        searchFlightTV.clipsToBounds = true
        searchFlightTV.layer.borderWidth = 1
        searchFlightTV.layer.borderColor = UIColor.AppBorderColor.cgColor
        searchFlightTV.backgroundColor = .AppHolderViewColor
        searchFlightTV.register(UINib(nibName: "HolderViewTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        searchFlightTV.register(UINib(nibName: "HolderViewTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
        searchFlightTV.register(UINib(nibName: "DualViewTVCell", bundle: nil), forCellReuseIdentifier: "cell2")
        searchFlightTV.register(UINib(nibName: "HolderViewTVCell", bundle: nil), forCellReuseIdentifier: "cell3")
        searchFlightTV.register(UINib(nibName: "HolderViewTVCell", bundle: nil), forCellReuseIdentifier: "cell5")
        searchFlightTV.register(UINib(nibName: "NatinalityTVCell", bundle: nil), forCellReuseIdentifier: "cell55")
        searchFlightTV.register(UINib(nibName: "AdvancedSearchTVCell", bundle: nil), forCellReuseIdentifier: "cell66")
        searchFlightTV.register(UINib(nibName: "ButtonTVCell", bundle: nil), forCellReuseIdentifier: "cell4")
        searchFlightTV.separatorStyle = .none
        searchFlightTV.delegate = self
        searchFlightTV.dataSource = self
        searchFlightTV.tableFooterView = UIView()
        searchFlightTV.showsHorizontalScrollIndicator = false
        searchFlightTV.isScrollEnabled = false
        
    }
    
    func didTapOnSelectDepDateBtn(cell: DualViewTVCell) {
        delegate?.didTapOnSelectDepDateBtn(cell: cell)
    }
    
    func didTapOnSelectRepDateBtn(cell: DualViewTVCell) {
        delegate?.didTapOnSelectRepDateBtn(cell: cell)
    }
    
    @objc func didTapOnFromCity(cell:HolderViewTVCell){
        delegate?.didTapOnFromCity(cell: cell)
    }
    @objc func didTapOnToCity(cell:HolderViewTVCell){
        delegate?.didTapOnToCity(cell: cell)
    }
    
    func btnAction(cell: ButtonTVCell) {
        delegate?.didTapOnSearchFlightsBtn(cell: self)
    }
    
    @objc func didTapOnLocationOrCityBtn(cell:HolderViewTVCell){
        delegate?.didTapOnLocationOrCityBtn(cell: cell)
    }
    
    @objc func didtapOnCheckInBtn(cell:DualViewTVCell){
        delegate?.didtapOnCheckInBtn(cell: cell)
    }
    
    @objc func didtapOnCheckOutBtn(cell:DualViewTVCell){
        delegate?.didtapOnCheckOutBtn(cell: cell)
    }
    
    @objc func didTapOnAddTravelerEconomy(cell:HolderViewTVCell){
        delegate?.didTapOnAddTravelerEconomy(cell: cell)
    }
    
    
    @objc func didTapOnAddRooms(cell:HolderViewTVCell){
        delegate?.didTapOnAddRooms(cell: cell)
    }
    
    @objc func didTapOnSelectNationality(cell:HolderViewTVCell){
        delegate?.didTapOnHotelNationalityBtnAction(cell: cell)
    }
    
    
    @objc func didTapOnSearchHotelsBtn(cell:ButtonTVCell){
        delegate?.didTapOnSearchHotelsBtn(cell: cell)
    }
    
    func didTapOnAdvancedSearchBtnAction(cell: AdvancedSearchTVCell) {
        
        
        if cell.showbool == true {
            viewHeight.constant = 500
            cell.btnsView.isHidden = false
            cell.showbool = false
        }else {
            viewHeight.constant = 460
            cell.btnsView.isHidden = true
            cell.showbool = true
        }
        NotificationCenter.default.post(name: NSNotification.Name("AdvancedSearchTVCellreload"), object: nil)
        
        searchFlightTV.beginUpdates()
        searchFlightTV.endUpdates()
    }
    
    func didTapOnNationalityBtnAction(cell: NatinalityTVCell) {
        delegate?.didTapOnNationalityBtnAction(cell: cell)
    }
    
    func didTapOnDirectFlightBtnAction(cell: NatinalityTVCell) {
        print("didTapOnDirectFlightBtnAction")
    }
    
    
    
    func didTapOnAirlinesSelectBtnAction(cell: AdvancedSearchTVCell) {
        delegate?.didTapOnAirlinesSelectBtnAction(cell: cell)
    }
    
    func didTapOnEconomySelectBtnAction(cell: AdvancedSearchTVCell) {
        delegate?.didTapOnEconomySelectBtnAction(cell: cell)
    }
    
    
    
}


extension SearchFlightTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.key == "hotel" {
            return 5
        }else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        
        if self.key == "hotel" {
            
            if indexPath.row == 0 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HolderViewTVCell {
                    cell.selectionStyle = .none
                    cell.titlelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.locationcity) ?? "City/Location")"
                    cell.locImg.image = UIImage(named: "loc")?.withRenderingMode(.alwaysOriginal)
                    cell.dropdownimg.isHidden = true
                    cell.fromBtn.addTarget(self, action: #selector(didTapOnLocationOrCityBtn(cell:)), for: .touchUpInside)
                    cell.tag = 1
                    cell.swipeView.isHidden = true
                    c = cell
                }
            }else  if indexPath.row == 1 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? DualViewTVCell {
                    cell.selectionStyle = .none
                    cell.delegate = self
                    cell.deplbl.text = defaults.string(forKey: UserDefaultsKeys.checkin) ?? "Check In"
                    cell.returnlbl.text = defaults.string(forKey: UserDefaultsKeys.checkout) ?? "Check Out"
                    cell.depBtn.addTarget(self, action: #selector(didtapOnCheckInBtn(cell:)), for: .touchUpInside)
                    cell.returnBtn.addTarget(self, action: #selector(didtapOnCheckOutBtn(cell:)), for: .touchUpInside)
                    
                    cell.showReturnView()
                    
                    
                    cell.depTF.isHidden = false
                    cell.retTF.isHidden = false
                    showreturndepDatePicker(cell: cell)
                    showretDatePicker(cell: cell)
                    
                    c = cell
                }
            }else  if indexPath.row == 2 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell3") as? HolderViewTVCell {
                    cell.selectionStyle = .none
                    cell.titlelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectPersons) ?? "+ Add Rooms")"
                    cell.locImg.image = UIImage(named: "tra")?.withRenderingMode(.alwaysOriginal)
                    cell.dropdownimg.isHidden = false
                    cell.fromBtn.addTarget(self, action: #selector(didTapOnAddRooms(cell:)), for: .touchUpInside)
                    cell.tag = 3
                    cell.swipeView.isHidden = true
                    c = cell
                }
            }else  if indexPath.row == 3 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell5") as? HolderViewTVCell {
                    cell.selectionStyle = .none
                    cell.titlelbl.text = defaults.string(forKey: UserDefaultsKeys.hnationality) ?? "Nationality"
                    cell.dropdownimg.isHidden = false
                    //                    cell.setupDropDown()
                    //                    cell.dropDown.dataSource = countryNameArray
                    cell.fromBtn.addTarget(self, action: #selector(didTapOnSelectNationality(cell:)), for: .touchUpInside)
                    cell.swipeView.isHidden = true
                    cell.locImg.image = UIImage(named: "na")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#9C7945"))
                    
                    c = cell
                }
            }else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell4") as? ButtonTVCell {
                    cell.selectionStyle = .none
                    cell.titlelbl.text = "Search Hotels"
                    cell.holderView.backgroundColor = .AppHolderViewColor
                    cell.btnView.layer.cornerRadius = 25
                    cell.btnView.clipsToBounds = true
                    cell.btnLeftConstraint.constant = 16
                    cell.delegate = self
                    cell.btn.addTarget(self, action: #selector(didTapOnSearchHotelsBtn(cell:)), for: .touchUpInside)
                    c = cell
                }
            }
            
        }else {
            
            if indexPath.row == 0 {
                
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HolderViewTVCell {
                    cell.selectionStyle = .none
                    cell.locImg.image = UIImage(named: "loc")?.withRenderingMode(.alwaysOriginal)
                    cell.toView.isHidden = false
                    cell.swipeView.isHidden = false
                    cell.fromBtn.addTarget(self, action: #selector(didTapOnFromCity(cell:)), for: .touchUpInside)
                    cell.toBtn.addTarget(self, action: #selector(didTapOnToCity(cell:)), for: .touchUpInside)
                    
                    if self.key == "roundtrip" {
                        //                        cell.titlelbl.text = defaults.string(forKey: UserDefaultsKeys.rfromCity) ?? "From"
                        //                        cell.tolabel.text = defaults.string(forKey: UserDefaultsKeys.rtoCity) ?? "To"
                        
                        if let fromstr = defaults.string(forKey: UserDefaultsKeys.fromCity) {
                            if fromstr.isEmpty == true {
                                cell.titlelbl.text = "From"
                                cell.tolabel.text =  "To"
                            }else {
                                cell.titlelbl.text = defaults.string(forKey: UserDefaultsKeys.fromCity) ?? "From"
                                cell.tolabel.text = defaults.string(forKey: UserDefaultsKeys.toCity) ?? "To"
                            }
                        }
                        
                    }else {
                        //                        cell.titlelbl.text = defaults.string(forKey: UserDefaultsKeys.fromCity) ?? "From"
                        //                        cell.tolabel.text = defaults.string(forKey: UserDefaultsKeys.toCity) ?? "To"
                        if let fromstr = defaults.string(forKey: UserDefaultsKeys.fromCity) {
                            if fromstr.isEmpty == true {
                                cell.titlelbl.text = "From"
                                cell.tolabel.text =  "To"
                            }else {
                                cell.titlelbl.text = defaults.string(forKey: UserDefaultsKeys.fromCity) ?? "From"
                                cell.tolabel.text = defaults.string(forKey: UserDefaultsKeys.toCity) ?? "To"
                            }
                        }
                    }
                    
                    
                    cell.tag = 1
                    c = cell
                }
            }else  if indexPath.row == 1 {
                
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? DualViewTVCell {
                    cell.selectionStyle = .none
                    cell.delegate = self
                    cell.hideRetView()
                    if self.key == "roundtrip" {
                        cell.showReturnView()
                        
                        
                        if let datestr1 = defaults.string(forKey: UserDefaultsKeys.calDepDate), let datestr2 = defaults.string(forKey: UserDefaultsKeys.calRetDate){
                            if datestr1.isEmpty == true {
                                cell.deplbl.text =  "Select Date"
                                //cell.returnlbl.text =  "Select Date"
                            }
                            
                            if datestr2.isEmpty == true{
                                //cell.deplbl.text =  "Select Date"
                                cell.returnlbl.text =  "Select Date"
                            }
                            
                            if datestr1.isEmpty == false &&  datestr1.isEmpty == false{
                                cell.deplbl.text = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "Select Date"
                                cell.returnlbl.text = defaults.string(forKey: UserDefaultsKeys.calRetDate) ?? "Select Date"
                            }
                        }
                        
                        
                        cell.depTF.isHidden = false
                        cell.retTF.isHidden = false
                        showreturndepDatePicker(cell: cell)
                        showretDatePicker(cell: cell)
                    }else {
                        
                        if let datestr1 = defaults.string(forKey: UserDefaultsKeys.calDepDate){
                            if datestr1.isEmpty == true {
                                cell.deplbl.text =  "Select Date"
                            }
                            if datestr1.isEmpty == false &&  datestr1.isEmpty == false{
                                cell.deplbl.text = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? ""
                            }
                        }
                        
                        
                        cell.depTF.isHidden = false
                        cell.retTF.isHidden = true
                        showdepDatePicker(cell: cell)
                    }
                    
                    c = cell
                }
            }else  if indexPath.row == 2 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell3") as? HolderViewTVCell {
                    cell.selectionStyle = .none
                    cell.locImg.image = UIImage(named: "tra")?.withRenderingMode(.alwaysOriginal)
                    cell.dropdownimg.isHidden = false
                    cell.fromBtn.addTarget(self, action: #selector(didTapOnAddTravelerEconomy(cell:)), for: .touchUpInside)
                    cell.tag = 3
                    cell.swipeView.isHidden = true
                    
                    
                    if self.key == "roundtrip" {
                        cell.titlelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "+ Add Traveller")"
                    }else {
                        cell.titlelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "+ Add Traveller")"
                    }
                    
                    c = cell
                }
            }
            
            
            else  if indexPath.row == 3 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell66") as? AdvancedSearchTVCell {
                    cell.selectionStyle = .none
                    cell.delegate = self
                    
                    if self.key == "roundtrip" {
                        cell.airlineslbl.text = "\(defaults.string(forKey: UserDefaultsKeys.nationality) ?? "ALL")"
                    }else {
                        cell.airlineslbl.text = "\(defaults.string(forKey: UserDefaultsKeys.nationality) ?? "ALL")"
                    }
                    c = cell
                }
            }else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell4") as? ButtonTVCell {
                    cell.selectionStyle = .none
                    cell.titlelbl.text = "Search Flights"
                    cell.holderView.backgroundColor = .AppHolderViewColor
                    cell.btnView.layer.cornerRadius = 25
                    cell.btnView.clipsToBounds = true
                    cell.btnLeftConstraint.constant = 16
                    cell.delegate = self
                    c = cell
                }
            }
        }
        
        
        
        return c
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? HolderViewTVCell {
            switch cell.tag {
            case 1:
                delegate?.didTapOnFromCity(cell: cell)
                break
                
            case 2:
                delegate?.didTapOnToCity(cell: cell)
                break
                
            case 3:
                delegate?.didTapOnAddTravelerEconomy(cell: cell)
                break
                
            default:
                break
            }
        }
    }
    
    
    
}



extension SearchFlightTVCell {
    
    
    //MARK: - showdepDatePicker
    func showdepDatePicker(cell:DualViewTVCell){
        //Formate Date
        depDatePicker.datePickerMode = .date
        depDatePicker.minimumDate = Date()
        depDatePicker.preferredDatePickerStyle = .wheels
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if let calDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "") {
            depDatePicker.date = calDepDate
            
            if cell.returnlbl.text == "Select Date" {
                retdepDatePicker.date = calDepDate
            }
            
        }
        
        
        
        
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        cell.depTF.inputAccessoryView = toolbar
        cell.depTF.inputView = depDatePicker
        
    }
    
    
    
    //MARK: - showreturndepDatePicker
    func showreturndepDatePicker(cell:DualViewTVCell){
        //Formate Date
        retdepDatePicker.datePickerMode = .date
        retdepDatePicker.minimumDate = Date()
        retdepDatePicker.preferredDatePickerStyle = .wheels
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        
        if key == "hotel" {
            
            if let checkinDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "")  {
                retdepDatePicker.date = checkinDate
                
                
                if defaults.string(forKey: UserDefaultsKeys.checkin) == nil {
                    retdepDatePicker.date = checkinDate
                }
            }
            
        }else {
            if let rcalDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "")  {
                retdepDatePicker.date = rcalDepDate
                
                
                if defaults.string(forKey: UserDefaultsKeys.calRetDate) == nil || cell.returnlbl.text == "Select Date" {
                    retdepDatePicker.date = rcalDepDate
                }
            }
        }
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        cell.depTF.inputAccessoryView = toolbar
        cell.depTF.inputView = retdepDatePicker
        
    }
    
    
    
    //MARK: - showretDatePicker
    func showretDatePicker(cell:DualViewTVCell){
        //Formate Date
        retDatePicker.datePickerMode = .date
        //        retDatePicker.minimumDate = Date()
        // Set minimumDate for retDatePicker based on depDatePicker or retdepDatePicker
        let selectedDate = cell.depTF.isFirstResponder ? depDatePicker.date : retdepDatePicker.date
        retDatePicker.minimumDate = selectedDate

        retDatePicker.preferredDatePickerStyle = .wheels
        
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if key == "hotel" {
            if let checkoutDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "") {
                retDatePicker.date = checkoutDate
            }
        }else {
            
            
            if let calDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "") {
                
                if cell.returnlbl.text == "Select Date" {
                    retDatePicker.date = calDepDate
                    
                }else {
                    if let rcalRetDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.calRetDate) ?? "") {
                        retDatePicker.date = rcalRetDate
                    }
                }
            }
        }
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        cell.retTF.inputAccessoryView = toolbar
        cell.retTF.inputView = retDatePicker
        
        
    }
    
    
    @objc func donedatePicker(){
        delegate?.donedatePicker(cell:self)
    }
    
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell:self)
    }
    
}
