//
//  TravellerEconomyVC.swift
//  AirportProject
//
//  Created by Codebele 09 on 26/06/22.
//

import UIKit
import CoreData

class TravellerEconomyVC: BaseTableVC {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    
    
    var tableRow = [TableRow]()
    var count = 1
    var keyString = String()
    var adultsCount = 1
    var childCount = 0
    var infantsCount = 0
    var roomCountArray = [Int]()
    static var newInstance: TravellerEconomyVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? TravellerEconomyVC
        return vc
    }
    
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: false)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        
        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.tabselect){
            if selectedTab == "Flight" {
                
                if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                    if journeyType == "oneway" {
                        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                        childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                        infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                    }else if journeyType == "circle" {
                        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                        childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                        infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                    }else {
                        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1") ?? 0
                        childCount = Int(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "0") ?? 0
                        infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.minfantsCount) ?? "0") ?? 0
                    }
                }
                
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.view.backgroundColor = .black.withAlphaComponent(0.3)
        holderView.backgroundColor = .black.withAlphaComponent(0.3)
        nav.backBtn.addTarget(self, action: #selector(gotoBackScreen), for: .touchUpInside)
        nav.titlelbl.text = "Select Traveller , Class"
        
        
        
        commonTableView.backgroundColor = .WhiteColor
        commonTableView.registerTVCells(["RadioButtonTVCell",
                                         "TravellerEconomyTVCell",
                                         "TitleLblTVCell",
                                         "EmptyTVCell",
                                         "ButtonTVCell",
                                         "CommonTVCell",
                                         "checkOptionsTVCell"])
        
        setupSearchFlightEconomyTVCells()
        
        
    }
    
    func setupSearchFlightEconomyTVCells(){
        
        tableRow.removeAll()
        
        
        
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                tableRow.append(TableRow(title:"Adult",subTitle: "12+",text: "\(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1")",cellType:.TravellerEconomyTVCell))
                tableRow.append(TableRow(title:"Child",subTitle: "2-11",text: "\(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0")",cellType:.TravellerEconomyTVCell))
                tableRow.append(TableRow(title:"Infant",subTitle: "0-2",text: "\(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0")",cellType:.TravellerEconomyTVCell))
            }else if journeyType == "circle" {
                tableRow.append(TableRow(title:"Adult",subTitle: "12+",text: "\(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1")",cellType:.TravellerEconomyTVCell))
                tableRow.append(TableRow(title:"Child",subTitle: "2-11",text: "\(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0")",cellType:.TravellerEconomyTVCell))
                tableRow.append(TableRow(title:"Infant",subTitle: "0-2",text: "\(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0")",cellType:.TravellerEconomyTVCell))
            }else {
                tableRow.append(TableRow(title:"Adult",subTitle: "12+",text: "\(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1")",cellType:.TravellerEconomyTVCell))
                tableRow.append(TableRow(title:"Child",subTitle: "2-11",text: "\(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "0")",cellType:.TravellerEconomyTVCell))
                tableRow.append(TableRow(title:"Infant",subTitle: "0-2",text: "\(defaults.string(forKey: UserDefaultsKeys.minfantsCount) ?? "0")",cellType:.TravellerEconomyTVCell))
            }
        }
        
        
        
        
        tableRow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tableRow.append(TableRow(title:"Choose Class",cellType:.TitleLblTVCell))
        tableRow.append(TableRow(cellType:.CommonTVCell))
        
        tableRow.append(TableRow(height:30,cellType:.EmptyTVCell))
        tableRow.append(TableRow(title:"Done",cellType:.ButtonTVCell))
        tableRow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        
        commonTVData = tableRow
        commonTableView.reloadData()
        
    }
    
    
    @objc func gotoBackScreen() {
        self.dismiss(animated: true)
    }
    
    
    
    
    override func didTapOnIncrementButton(cell: TravellerEconomyTVCell) {
        if cell.titlelbl.text == "Infant" {
            // Increment the infant count if it's less than the number of adults
            if infantsCount < adultsCount {
                infantsCount += 1
                cell.count += 1
                cell.countlbl.text = "\(cell.count)"
            }
            
            
        } else if cell.titlelbl.text == "Adult" {
            // Increment adults, but don't exceed 9 travelers in total
            if (adultsCount + childCount) < 9 {
                adultsCount += 1
                cell.count += 1
                cell.countlbl.text = "\(cell.count)"
            }
        } else {
            if (adultsCount + childCount) < 9 {
                // Increment children, but don't exceed 9 travelers in total
                if cell.count >= 0 {
                    cell.count += 1
                    cell.countlbl.text = "\(cell.count)"
                }
                if cell.titlelbl.text == "Child" {
                    childCount = cell.count
                }
            }
        }
        
        updateTotalTravelerCount()
    }
    
    override func didTapOnDecrementButton(cell: TravellerEconomyTVCell) {
        if cell.titlelbl.text == "Infant" {
            // Decrement the infant count if it's greater than 0
            if infantsCount > 0 {
                infantsCount -= 1
                cell.count -= 1
                cell.countlbl.text = "\(cell.count)"
            }
        } else if cell.titlelbl.text == "Adult" {
            // Decrement adults, but don't go below 1
            if adultsCount > 1 {
                adultsCount -= 1
                cell.count -= 1
                cell.countlbl.text = "\(cell.count)"
                
                // Set child count to 0
                if let infantCell = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? TravellerEconomyTVCell {
                    infantCell.count = 0
                    infantCell.countlbl.text = "\(infantCell.count)"
                    infantsCount = 0
                }
                
            }
            
        } else {
            // Decrement children
            if cell.count > 0 {
                cell.count -= 1
                cell.countlbl.text = "\(cell.count)"
            }
            if cell.titlelbl.text == "Child" {
                childCount = cell.count
            }
        }
        
        updateTotalTravelerCount()
    }
    
    
    
    
    func updateTotalTravelerCount() {
        let totalTravelers = adultsCount + childCount + infantsCount
        print("Total Count === \(totalTravelers)")
        defaults.set(totalTravelers, forKey: UserDefaultsKeys.totalTravellerCount)
    }
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RadioButtonTVCell {
            cell.radioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBackgroundColor)
            
            defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.selectClass)

            
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RadioButtonTVCell {
            cell.radioImg.image = UIImage(named: "radioUnselected")
        }
    }
    
    func gotoBookFlightVC() {
        

        let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1") Traveller - \(defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "Economy")"
        defaults.set(totaltraverlers, forKey: UserDefaultsKeys.travellerDetails)
        
        
        NotificationCenter.default.post(name: NSNotification.Name("calreloadTV"), object: nil)
        self.dismiss(animated: true)
    }
    
    
    
    override func btnAction(cell: ButtonTVCell) {
        print("button tap ...")
        print("adultsCount \(adultsCount)")
        print("childCount \(childCount)")
        print("infantsCount \(infantsCount)")
        if cell.titlelbl.text == "Done" {
            if let selectedTab = defaults.string(forKey: UserDefaultsKeys.tabselect){
                if selectedTab == "Flight" {
                    
                    if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                        if journeyType == "oneway" {
                            defaults.set(adultsCount, forKey: UserDefaultsKeys.adultCount)
                            defaults.set(childCount, forKey: UserDefaultsKeys.childCount)
                            defaults.set(infantsCount, forKey: UserDefaultsKeys.infantsCount)
                        }else if journeyType == "circle" {
                            defaults.set(adultsCount, forKey: UserDefaultsKeys.adultCount)
                            defaults.set(childCount, forKey: UserDefaultsKeys.childCount)
                            defaults.set(infantsCount, forKey: UserDefaultsKeys.infantsCount)
                        }else {
                            defaults.set(adultsCount, forKey: UserDefaultsKeys.madultCount)
                            defaults.set(childCount, forKey: UserDefaultsKeys.mchildCount)
                            defaults.set(infantsCount, forKey: UserDefaultsKeys.minfantsCount)
                        }
                    }
                    
                    gotoBookFlightVC()
                }
            }
        }
    }
    
    
    
    
}


