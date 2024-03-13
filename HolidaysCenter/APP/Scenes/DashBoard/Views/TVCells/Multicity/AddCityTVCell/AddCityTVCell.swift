//
//  AddCityTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 19/08/22.
//

import UIKit

protocol AddCityTVCellDelegate {
    
    func didTapOnFromBtn(cell:MulticityFromToTVCell)
    func didTapOnToBtn(cell:MulticityFromToTVCell)
    func didTapOndateBtn(cell:MulticityFromToTVCell)
    func didTapOnCloseBtn(cell:MulticityFromToTVCell)
    func didTapOnAddCityBtn(cell:AddCityTVCell)
    func didTapOnAddTravellerEconomy(cell:AddCityTVCell)
    func didTapOnMultiCityTripSearchFlight(cell:AddCityTVCell)
    func didTapOnAdvanceSearchBtn(cell:AddCityTVCell)
    func didTapOnNationalityBtn(cell:AddCityTVCell)
    func didTapOnAirlinesBtnAction(cell:AddCityTVCell)
    func didTapOnselectClassBtnAction(cell:AddCityTVCell)
    
    
}

class AddCityTVCell: TableViewCell, MulticityFromToTVCellDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var addCityTV: UITableView!
    @IBOutlet weak var addCityTVHeight: NSLayoutConstraint!
    @IBOutlet weak var addCityBtn: UIButton!
    @IBOutlet weak var traView: UIView!
    @IBOutlet weak var tralbl: UILabel!
    @IBOutlet weak var searchFlightView: UIView!
    @IBOutlet weak var nationalityView: UIView!
    @IBOutlet weak var advanceSearchHeight: NSLayoutConstraint!
    @IBOutlet weak var airlinesView: UIView!
    @IBOutlet weak var economyView: UIView!
    @IBOutlet weak var advanceSearchView: UIStackView!
    @IBOutlet weak var directFlightCheckimg: UIImageView!
    @IBOutlet weak var nationalitylbl: UILabel!
    @IBOutlet weak var selectedAirlineslbl: UILabel!
    @IBOutlet weak var selectedClasslbl: UILabel!

    
    var count = 0
    var advanchsearchbool = true
    
    var delegate:AddCityTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        nationalitylbl.text = defaults.string(forKey: UserDefaultsKeys.mnationality) ?? "Nationality"
        tralbl.text = defaults.string(forKey: UserDefaultsKeys.mtravellerDetails) ?? ""

        NotificationCenter.default.addObserver(self, selector: #selector(reload(_:)), name: NSNotification.Name("eco"), object: nil)

    }
    
    @objc func reload(_ notification: NSNotification){
        let key1 = notification.object as? String
        if key1 == "eco" {
            selectedClasslbl.text = notification.userInfo?["title"] as? String
        }else {
            selectedAirlineslbl.text = notification.userInfo?["title"] as? String
        }
    }
    
  
    func setupUI() {
        
        addCityTVHeight.constant = 120
        addCityBtn.setTitle("+ Add City", for: .normal)
        addCityBtn.setTitleColor(.AppBackgroundColor, for: .normal)
        traView.layer.borderColor = UIColor.AppBorderColor.cgColor
        traView.layer.borderWidth = 1
        nationalityView.layer.borderColor = UIColor.AppBorderColor.cgColor
        nationalityView.layer.borderWidth = 1
        airlinesView.layer.borderColor = UIColor.AppBorderColor.cgColor
        airlinesView.layer.borderWidth = 1
        economyView.layer.borderColor = UIColor.AppBorderColor.cgColor
        economyView.layer.borderWidth = 1
        advanceSearchHeight.constant = 0
        advanceSearchView.isHidden = true
        
        searchFlightView.addCornerRadiusWithShadow(color: HexColor("#000000",alpha: 0.36), borderColor: .clear, cornerRadius: 20)
        
        setupTV()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
    }
    
    
    @objc func reload(notification: NSNotification){
        updateheight()
    }
    
    
    func setupTV() {
        addCityTV.register(UINib(nibName: "MulticityFromToTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        addCityTV.delegate = self
        addCityTV.dataSource = self
        addCityTV.tableFooterView = UIView()
        addCityTV.separatorStyle = .none
        addCityTV.backgroundColor = .AppHolderViewColor
    }
    
    
    func didTapOnFromBtn(cell: MulticityFromToTVCell) {
        defaults.set(cell.fromBtn.tag, forKey: UserDefaultsKeys.cellTag)
        delegate?.didTapOnFromBtn(cell: cell)
    }
    
    func didTapOnToBtn(cell: MulticityFromToTVCell) {
        defaults.set(cell.toBtn.tag, forKey: UserDefaultsKeys.cellTag)
        delegate?.didTapOnToBtn(cell: cell)
    }
    
    func didTapOndateBtn(cell: MulticityFromToTVCell) {
        defaults.set(cell.dateBtn.tag, forKey: UserDefaultsKeys.cellTag)
        delegate?.didTapOndateBtn(cell: cell)
    }
    
    
    
    
    func updateheight() {
        addCityTVHeight.constant = CGFloat(55 * (fromCityCodeArray.count))
        addCityTV.reloadData()
    }
    
    @IBAction func didTapOnAddCityBtn(_ sender: Any) {
        count += 1
        print("count \(count)")
        print("fromCityNameArray count \(fromCityCodeArray.count)")
        if fromCityCodeArray.count >= 5 {
            addCityBtn.isHidden = true
            
        }else {
            
            fromCityCodeArray.append("Origen")
            toCitycodeArray.append("Destination")
            fromlocidArray.append("")
            tolocidArray.append("")
            depatureDatesArray.append("Date")
            
            fromCityNameArray.append("")
            toCityNameArray.append("")
            
            DispatchQueue.main.async {[self] in
                updateheight()
                NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
            }
            
            
            if fromCityCodeArray.count == 5 {
                addCityBtn.isHidden = true
            }
            
        }
        
        delegate?.didTapOnAddCityBtn(cell: self)
    }
    
    
    
    
    func didTapOnCloseBtn(cell: MulticityFromToTVCell) {
        
        fromCityCodeArray.remove(at: cell.closeBtn.tag)
        toCitycodeArray.remove(at: cell.closeBtn.tag)
        depatureDatesArray.remove(at: cell.closeBtn.tag)
        fromlocidArray.remove(at: cell.closeBtn.tag)
        tolocidArray.remove(at: cell.closeBtn.tag)
        
        fromCityNameArray.remove(at: cell.closeBtn.tag)
        toCityNameArray.remove(at: cell.closeBtn.tag)
        
        
        //---------------
        
        addCityTV.deleteRows(at: [IndexPath(item: cell.closeBtn.tag, section: 0)], with: .automatic)
        DispatchQueue.main.async {[self] in
            if fromCityCodeArray.count < 5 {
                addCityBtn.isHidden = false
            }
        }
        
        updateheight()
        NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
    }
    
    
    
    @IBAction func didTapOnAddTravellerBtnAction(_ sender: Any) {
        delegate?.didTapOnAddTravellerEconomy(cell: self)
    }
    
    
    @IBAction func didTapOnNationalityBtn(_ sender: Any) {
        delegate?.didTapOnNationalityBtn(cell: self)
    }
    
    
    var directflightsBool = true
    @IBAction func didTapOnDirectFlightsBtn(_ sender: Any) {
        if directflightsBool == true {
            directFlightCheckimg.image = UIImage(named: "chk")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
            directflightsBool = false
        }else {
            directFlightCheckimg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
            directflightsBool = true
        }
    }
    
    
    @IBAction func didTapOnAdvanceSearchBtn(_ sender: Any) {
        if advanchsearchbool == true {
            advanceSearchHeight.constant = 45
            advanceSearchView.isHidden = false
            advanchsearchbool = false
        }else {
            advanceSearchHeight.constant = 0
            advanceSearchView.isHidden = true
            advanchsearchbool = true
        }
        
        delegate?.didTapOnAdvanceSearchBtn(cell: self)
    }
    
    
    @IBAction func didTapOnAirlinesBtnAction(_ sender: Any) {
        delegate?.didTapOnAirlinesBtnAction(cell: self)
    }
    
    
    
    @IBAction func didTapOnselectClassBtnAction(_ sender: Any) {
        delegate?.didTapOnselectClassBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnSearchFlightBtnAction(_ sender: Any) {
        delegate?.didTapOnMultiCityTripSearchFlight(cell: self)
    }
    
    
}


extension AddCityTVCell:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fromCityCodeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MulticityFromToTVCell {
            cell.selectionStyle = .none
            cell.delegate = self
            
            if indexPath.row == 0 || indexPath.row == 1{
                cell.closeView.isHidden = true
            }else {
                cell.closeView.isHidden = false
            }
            
            
            
            cell.fromlbl.text = fromCityCodeArray[indexPath.row]
            cell.tolbl.text = toCitycodeArray[indexPath.row]
            cell.datelbl.text = depatureDatesArray[indexPath.row]
            
            
            cell.fromBtn.tag = indexPath.row
            cell.toBtn.tag = indexPath.row
            cell.dateBtn.tag = indexPath.row
            cell.closeBtn.tag = indexPath.row
            
            c = cell
        }
        return c
    }
    
    
}
