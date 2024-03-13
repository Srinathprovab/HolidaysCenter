//
//  PopoverVC.swift
//  HolidaysCenter
//
//  Created by FCI on 19/05/23.
//

import UIKit

class PopoverVC: BaseTableVC {
    
    var key = String()
    var tablerow = [TableRow]()
    static var newInstance: PopoverVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? PopoverVC
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        commonTableView.backgroundColor = .WhiteColor
        commonTableView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 6)
        commonTableView.registerTVCells(["TitleLblTVCell"])
        commonTableView.separatorStyle = .singleLine
        commonTableView.separatorColor = .AppBorderColor
        setupTVCells()
    }
    
    
    func setupTVCells() {
        tablerow.removeAll()
        
        if key == "eco" {
            tablerow.append(TableRow(title:"Economy",cellType:.TitleLblTVCell))
            tablerow.append(TableRow(title:"PremiumEconomy",cellType:.TitleLblTVCell))
            tablerow.append(TableRow(title:"Business",cellType:.TitleLblTVCell))
            tablerow.append(TableRow(title:"First class",cellType:.TitleLblTVCell))
            tablerow.append(TableRow(title:"all class",cellType:.TitleLblTVCell))
            
        }else {
            tablerow.append(TableRow(title:"748 air services",cellType:.TitleLblTVCell))
            tablerow.append(TableRow(title:"9 air",cellType:.TitleLblTVCell))
            tablerow.append(TableRow(title:"ab aviation",cellType:.TitleLblTVCell))
            tablerow.append(TableRow(title:"Accesrail",cellType:.TitleLblTVCell))
            tablerow.append(TableRow(title:"ACT havayallai",cellType:.TitleLblTVCell))
            tablerow.append(TableRow(title:"Advanced air",cellType:.TitleLblTVCell))
            tablerow.append(TableRow(title:"Aegean airlines",cellType:.TitleLblTVCell))
            
        }
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TitleLblTVCell {
            NotificationCenter.default.post(name: NSNotification.Name("eco"), object: self.key,userInfo: ["title":cell.titlelbl.text ?? ""])
            NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
            dismiss(animated: true)
        }
      
    }
    
    
}
