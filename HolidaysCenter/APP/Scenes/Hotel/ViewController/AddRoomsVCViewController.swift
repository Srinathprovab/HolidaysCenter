//
//  AddRoomsVCViewController.swift
//  BabSafar
//
//  Created by FCI on 10/04/23.
//

import UIKit

class AddRoomsVCViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RoomsCountTVCellDelegate, ButtonTVCellDelegate {
    func btnAction(cell: ButtonTVCell) {
        
    }
    
    
    //    @IBOutlet weak var titleView: UIView!
    //    @IBOutlet weak var titlelbl: UILabel!
    //    @IBOutlet weak var closeBtn: UIButton!
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var tv: UITableView!
    
    
    var totalAdults = Int()
    var totalChildren = Int()
    static var newInstance: AddRoomsVCViewController? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? AddRoomsVCViewController
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
        self.view.backgroundColor = .black.withAlphaComponent(0.4)
        nav.titlelbl.text = "Select Adults, Rooms"
        nav.backBtn.addTarget(self, action: #selector(closeBtnAction(_:)), for: .touchUpInside)
        
       
        tv.delegate = self
        tv.dataSource = self
        tv.register(UINib(nibName: "RoomsCountTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        tv.register(UINib(nibName: "ButtonTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
        tv.separatorStyle = .none
        tv.showsHorizontalScrollIndicator = false
        tv.showsVerticalScrollIndicator = false
        tv.bounces = false
        
    }
    
    @objc func closeBtnAction(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    
    func didTapOnAddRoomBtnAction(cell: RoomsCountTVCell) {
        tv.reloadData()
    }
    
    func didTapOnAddRoomBtnAction(cell: ButtonTVCell) {
        
    }
    
    
    
    func didTapOnCloseRoom(cell: RoomsCountTVCell) {
        tv.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
       
        
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? RoomsCountTVCell {
                cell.delegate = self
                ccell.selectionStyle = .none
                
                ccell = cell
            }
        }
        
//        else {
//            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? ButtonTVCell {
//                cell.delegate = self
//                cell.titlelbl.text = "Done"
//                cell.btnView.backgroundColor = .AppNavBackColor
//                ccell = cell
//            }
//        }
        
        return ccell
    }
    
    
    //MARK: -Room1 ========
    func adultsIncrementButtonAction(cell: RoomsCountTVCell) {
        
        if cell.adultcount >= 1 &&  cell.adultcount < 12{
            cell.adultcount += 1
            cell.adultsCountlbl1.text = "\(cell.adultcount)"
            
        }else {
            showToast(message: "Adults Not More Than 12")
        }
        
    }
    
    func adultsDecrementBtnAction(cell: RoomsCountTVCell) {
        
        if cell.adultcount > 1 {
            cell.adultcount -= 1
            cell.adultsCountlbl1.text = "\(cell.adultcount)"
        }else {
            // showToast(message: "")
        }
        
        
    }
    
    func childrenIncrementButtonAction(cell: RoomsCountTVCell) {
        if cell.childCount >= 0 &&  cell.childCount < 5{
            cell.childCount += 1
            cell.childrenCountlbl1.text = "\(cell.childCount)"
            
            
            
            switch cell.childCount {
            case 1:
                cell.room1Height.constant = 260
                cell.childage1View.isHidden = false
                cell.childage2View.isHidden = true
                cell.childage3View.isHidden = true
                cell.room1childagevalue1lbl.text = "0"
                break
                
            case 2:
                cell.room1Height.constant = 260
                cell.childage1View.isHidden = false
                cell.childage2View.isHidden = false
                cell.childage3View.isHidden = true
                cell.room1childagevalue2lbl.text = "0"
                break
                
            case 3:
                cell.room1Height.constant = 260
                cell.childage1View.isHidden = false
                cell.childage2View.isHidden = false
                cell.childage3View.isHidden = false
                cell.room1childagevalue3lbl.text = "0"
                
                cell.room1child4child5Holder.isHidden = true
                break
                
            case 4:
                cell.room1Height.constant = 290
                cell.childage1View.isHidden = false
                cell.childage2View.isHidden = false
                cell.childage3View.isHidden = false
                cell.room1child4child5Holder.isHidden = false
                cell.childage4View.isHidden = false
                cell.childage5View.isHidden = true
                cell.room1childagevalue4lbl.text = "0"
                
            case 5:
                cell.room1Height.constant = 290
                cell.childage1View.isHidden = false
                cell.childage2View.isHidden = false
                cell.childage3View.isHidden = false
                cell.room1child4child5Holder.isHidden = false
                cell.childage4View.isHidden = false
                cell.childage5View.isHidden = false
                cell.room1childagevalue5lbl.text = "0"
                
                break
            default:
                break
            }
            
        }else {
            showToast(message: "Childerns Not More Than 5")
        }
        
        tv.reloadData()
    }
    
    func childrenDecrementBtnAction(cell: RoomsCountTVCell) {
        if cell.childCount > 0 {
            cell.childCount -= 1
            cell.childrenCountlbl1.text = "\(cell.childCount)"
            if cell.childCount == 0 {
                
            }else{
                
            }
            
            switch cell.childCount {
                
            case 0:
                cell.room1Height.constant = 260
                cell.childage1View.isHidden = true
                cell.childage2View.isHidden = true
                cell.childage3View.isHidden = true
                cell.childage4View.isHidden = true
                cell.childage5View.isHidden = true
                cell.room1childagevalue1lbl.text = "0"
                break
                
            case 1:
                cell.room1Height.constant = 260
                cell.childage1View.isHidden = false
                cell.childage2View.isHidden = true
                cell.childage3View.isHidden = true
                cell.childage4View.isHidden = true
                cell.childage5View.isHidden = true
                cell.room1childagevalue2lbl.text = "0"
                break
                
            case 2:
                cell.room1Height.constant = 260
                cell.childage1View.isHidden = false
                cell.childage2View.isHidden = false
                cell.childage3View.isHidden = true
                cell.childage4View.isHidden = true
                cell.childage5View.isHidden = true
                cell.room1childagevalue3lbl.text = "0"
                break
                
            case 3:
                cell.room1Height.constant = 290
                cell.childage1View.isHidden = false
                cell.childage2View.isHidden = false
                cell.childage3View.isHidden = false
                cell.childage4View.isHidden = true
                cell.childage5View.isHidden = true
                cell.room1childagevalue4lbl.text = "0"
                break
                
                
            case 4:
                cell.room1Height.constant = 290
                cell.childage1View.isHidden = false
                cell.childage2View.isHidden = false
                cell.childage3View.isHidden = false
                cell.childage4View.isHidden = false
                cell.childage5View.isHidden = true
                cell.room1childagevalue5lbl.text = "0"
                break
                
                
            default:
                break
            }
            
            
        }else {
            showToast(message: "")
        }
        tv.reloadData()
    }
    
    
    
    //MARK: -Room2 ========
    
    func adultsIncrementButtonAction2(cell: RoomsCountTVCell) {
        
        if cell.adultcount2 >= 1 &&  cell.adultcount2 < 12{
            cell.adultcount2 += 1
            cell.adultsCountlbl2.text = "\(cell.adultcount2)"
            
        }else {
            showToast(message: "Adults Not More Than 12")
        }
        tv.reloadData()
        
        
    }
    
    func adultsDecrementBtnAction2(cell: RoomsCountTVCell) {
        
        if cell.adultcount2 > 1 {
            cell.adultcount2 -= 1
            cell.adultsCountlbl2.text = "\(cell.adultcount2)"
        }else {
            // showToast(message: "")
        }
        
        
    }
    
    func childrenIncrementButtonAction2(cell: RoomsCountTVCell) {
        if cell.childCount2 >= 0 &&  cell.childCount2 < 5{
            cell.childCount2 += 1
            cell.childrenCountlbl2.text = "\(cell.childCount2)"
            
            
            
            switch cell.childCount2 {
            case 1:
                cell.room2Height.constant = 260
                cell.r2childage1View.isHidden = false
                cell.r2childage2View.isHidden = true
                cell.room2childage3View.isHidden = true
                cell.room2childagevalue1lbl.text = "0"
                break
                
            case 2:
                cell.room2Height.constant = 260
                cell.r2childage1View.isHidden = false
                cell.r2childage2View.isHidden = false
                cell.room2childage3View.isHidden = true
                cell.room2childagevalue2lbl.text = "0"
                break
                
            case 3:
                cell.room2Height.constant = 260
                cell.r2childage1View.isHidden = false
                cell.r2childage2View.isHidden = false
                cell.room2childage3View.isHidden = false
                cell.room2childagevalue3lbl.text = "0"
                
                cell.room2child4child5Holder.isHidden = true
                break
                
            case 4:
                cell.room2Height.constant = 290
                cell.r2childage1View.isHidden = false
                cell.r2childage2View.isHidden = false
                cell.room2childage3View.isHidden = false
                cell.room2child4child5Holder.isHidden = false
                cell.room2childage4View.isHidden = false
                cell.room2childage5View.isHidden = true
                cell.room2childagevalue4lbl.text = "0"
                
            case 5:
                cell.room2Height.constant = 290
                cell.r2childage1View.isHidden = false
                cell.r2childage2View.isHidden = false
                cell.room2childage3View.isHidden = false
                cell.room2child4child5Holder.isHidden = false
                cell.room2childage4View.isHidden = false
                cell.room2childage5View.isHidden = false
                cell.room2childagevalue5lbl.text = "0"
                
                break
            default:
                break
            }
            
        }else {
            showToast(message: "Childerns Not More Than 5")
        }
        
        tv.reloadData()
    }
    
    func childrenDecrementBtnAction2(cell: RoomsCountTVCell) {
        if cell.childCount2 > 0 {
            cell.childCount2 -= 1
            cell.childrenCountlbl2.text = "\(cell.childCount2)"
            if cell.childCount2 == 0 {
                
            }else{
                
            }
            
            switch cell.childCount2 {
                
            case 0:
                cell.room2Height.constant = 260
                cell.r2childage1View.isHidden = true
                cell.r2childage2View.isHidden = true
                cell.room2childage3View.isHidden = true
                cell.room2childage4View.isHidden = true
                cell.room2childage5View.isHidden = true
                cell.room2childagevalue1lbl.text = "0"
                break
                
            case 1:
                cell.room2Height.constant = 260
                cell.r2childage1View.isHidden = false
                cell.r2childage2View.isHidden = true
                cell.room2childage3View.isHidden = true
                cell.room2childage4View.isHidden = true
                cell.room2childage5View.isHidden = true
                cell.room2childagevalue2lbl.text = "0"
                break
                
            case 2:
                cell.room2Height.constant = 260
                cell.r2childage1View.isHidden = false
                cell.r2childage2View.isHidden = false
                cell.room2childage3View.isHidden = true
                cell.room2childage4View.isHidden = true
                cell.room2childage5View.isHidden = true
                cell.room2childagevalue3lbl.text = "0"
                break
                
            case 3:
                cell.room2Height.constant = 290
                cell.r2childage1View.isHidden = false
                cell.r2childage2View.isHidden = false
                cell.room2childage3View.isHidden = false
                cell.room2childage4View.isHidden = true
                cell.room2childage5View.isHidden = true
                cell.room2childagevalue4lbl.text = "0"
                break
                
                
            case 4:
                cell.room1Height.constant = 290
                cell.r2childage1View.isHidden = false
                cell.r2childage2View.isHidden = false
                cell.room2childage3View.isHidden = false
                cell.room2childage4View.isHidden = false
                cell.room2childage5View.isHidden = true
                cell.room2childagevalue5lbl.text = "0"
                break
                
                
            default:
                break
            }
            
            
        }else {
            showToast(message: "")
        }
        tv.reloadData()
    }
    
    
    //MARK: -Room3 ========
    func adultsIncrementButtonAction3(cell: RoomsCountTVCell) {
        
        if cell.adultcount3 >= 1 &&  cell.adultcount3 < 12{
            cell.adultcount3 += 1
            cell.adultsCountlbl3.text = "\(cell.adultcount3)"
            
        }else {
            showToast(message: "Adults Not More Than 12")
        }
        tv.reloadData()
        
        
    }
    
    func adultsDecrementBtnAction3(cell: RoomsCountTVCell) {
        
        if cell.adultcount3 > 1 {
            cell.adultcount3 -= 1
            cell.adultsCountlbl3.text = "\(cell.adultcount3)"
        }else {
            // showToast(message: "")
        }
        
        
    }
    
    func childrenIncrementButtonAction3(cell: RoomsCountTVCell) {
        if cell.childCount3 >= 0 &&  cell.childCount3 < 5{
            cell.childCount3 += 1
            cell.childrenCountlbl3.text = "\(cell.childCount3)"
            
            
            
            switch cell.childCount3 {
            case 1:
                cell.room3Height.constant = 260
                cell.r3childage1View.isHidden = false
                cell.r3childage2View.isHidden = true
                cell.room3childage3View.isHidden = true
                cell.room3childagevalue1lbl.text = "0"
                break
                
            case 2:
                cell.room3Height.constant = 260
                cell.r3childage1View.isHidden = false
                cell.r3childage2View.isHidden = false
                cell.room3childage3View.isHidden = true
                cell.room3childagevalue2lbl.text = "0"
                break
                
            case 3:
                cell.room3Height.constant = 260
                cell.r3childage1View.isHidden = false
                cell.r3childage2View.isHidden = false
                cell.room3childage3View.isHidden = false
                cell.room3childagevalue3lbl.text = "0"
                
                cell.room3child4child5Holder.isHidden = true
                break
                
            case 4:
                cell.room3Height.constant = 290
                cell.r3childage1View.isHidden = false
                cell.r3childage2View.isHidden = false
                cell.room3childage3View.isHidden = false
                cell.room3child4child5Holder.isHidden = false
                cell.room3childage4View.isHidden = false
                cell.room3childage5View.isHidden = true
                cell.room3childagevalue4lbl.text = "0"
                
            case 5:
                cell.room3Height.constant = 290
                cell.r3childage1View.isHidden = false
                cell.r3childage2View.isHidden = false
                cell.room3childage3View.isHidden = false
                cell.room3child4child5Holder.isHidden = false
                cell.room3childage4View.isHidden = false
                cell.room3childage5View.isHidden = false
                cell.room3childagevalue5lbl.text = "0"
                
                break
            default:
                break
            }
            
        }else {
            showToast(message: "Childerns Not More Than 5")
        }
        
        tv.reloadData()
    }
    
    func childrenDecrementBtnAction3(cell: RoomsCountTVCell) {
        if cell.childCount3 > 0 {
            cell.childCount3 -= 1
            cell.childrenCountlbl3.text = "\(cell.childCount3)"
            if cell.childCount3 == 0 {
                
            }else{
                
            }
            
            switch cell.childCount3 {
                
            case 0:
                cell.room3Height.constant = 260
                cell.r3childage1View.isHidden = true
                cell.r3childage2View.isHidden = true
                cell.room3childage3View.isHidden = true
                cell.room3childage4View.isHidden = true
                cell.room3childage5View.isHidden = true
                cell.room3childagevalue1lbl.text = "0"
                break
                
            case 1:
                cell.room3Height.constant = 260
                cell.r3childage1View.isHidden = false
                cell.r3childage2View.isHidden = true
                cell.room3childage3View.isHidden = true
                cell.room3childage4View.isHidden = true
                cell.room3childage5View.isHidden = true
                cell.room3childagevalue2lbl.text = "0"
                break
                
            case 2:
                cell.room3Height.constant = 260
                cell.r3childage1View.isHidden = false
                cell.r3childage2View.isHidden = false
                cell.room3childage3View.isHidden = true
                cell.room3childage4View.isHidden = true
                cell.room3childage5View.isHidden = true
                cell.room3childagevalue3lbl.text = "0"
                break
                
            case 3:
                cell.room3Height.constant = 290
                cell.r3childage1View.isHidden = false
                cell.r3childage2View.isHidden = false
                cell.room3childage3View.isHidden = false
                cell.room3childage4View.isHidden = true
                cell.room3childage5View.isHidden = true
                cell.room3childagevalue4lbl.text = "0"
                break
                
                
            case 4:
                cell.room3Height.constant = 290
                cell.r3childage1View.isHidden = false
                cell.r3childage2View.isHidden = false
                cell.room3childage3View.isHidden = false
                cell.room3childage4View.isHidden = false
                cell.room3childage5View.isHidden = true
                cell.room3childagevalue5lbl.text = "0"
                break
                
                
            default:
                break
            }
            
            
        }else {
            showToast(message: "")
        }
        tv.reloadData()
    }
    
    @IBAction func didTapOnDoneBtnActon(_ sender: Any) {
        
        
        if let cell = tv.cellForRow(at: IndexPath(item: 0, section: 0)) as? RoomsCountTVCell {
            adtArray.removeAll()
            chArray.removeAll()
            totalRooms = cell.roomCount
            //  totalAdults = (cell.adultcount + cell.adultcount2)
            
            
            
            if totalRooms == 1 {
                
                totalAdults = (cell.adultcount)
                totalChildren = (cell.childCount)
                
                adtArray.append("\(cell.adultcount)")
                chArray.append("\(cell.childCount)")
                
                
                
                
            }
            
            if totalRooms == 2 {
                
                totalAdults = (cell.adultcount + cell.adultcount2)
                totalChildren = (cell.childCount + cell.childCount2)
                
                
                adtArray.append("\(cell.adultcount)")
                chArray.append("\(cell.childCount)")
                
                adtArray.append("\(cell.adultcount2)")
                chArray.append("\(cell.childCount2)")
                
                
            }
            
            
            if totalRooms == 3 {
                totalAdults = (cell.adultcount + cell.adultcount2 + cell.adultcount3)
                totalChildren = (cell.childCount + cell.childCount2 + cell.childCount3)
                adtArray.append("\(cell.adultcount)")
                chArray.append("\(cell.childCount)")
                
                adtArray.append("\(cell.adultcount2)")
                chArray.append("\(cell.childCount2)")
                
                adtArray.append("\(cell.adultcount3)")
                chArray.append("\(cell.childCount3)")
            }
            
            
            
            
        }
        
        
        
        print("totalRooms ==== \(totalRooms)")
        print("totalAdults ==== \(totalAdults)")
        print("totalChildren ==== \(totalChildren)")
        
        print("adtArray ==== \(adtArray)")
        print("chArray ==== \(chArray)")
        
        defaults.set(totalRooms, forKey: UserDefaultsKeys.roomcount)
        defaults.set(totalAdults, forKey: UserDefaultsKeys.hoteladultscount)
        defaults.set(totalChildren, forKey: UserDefaultsKeys.hotelchildcount)
        defaults.set((totalChildren + totalAdults), forKey: UserDefaultsKeys.guestcount)
        print("guestcount ==== \(totalChildren + totalAdults)")
        
        
        if totalChildren == 0 {
            defaults.set("Rooms \(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? ""):Adults \(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "")", forKey: UserDefaultsKeys.selectPersons)
        }else {
            defaults.set("Rooms \(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? ""):Adults \(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? ""),Children \(defaults.string(forKey: UserDefaultsKeys.hotelchildcount) ?? "")", forKey: UserDefaultsKeys.selectPersons)
        }
        
        
        
        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
        dismiss(animated: true)
        
    }
    
    
    
    
    //MARK: -
    //    func btnAction(cell: ButtonTVCell) {
    //        if let cell = tv.cellForRow(at: IndexPath(item: 0, section: 0)) as? RoomsCountTVCell {
    //            adtArray.removeAll()
    //            chArray.removeAll()
    //            totalRooms = cell.roomCount
    //            //  totalAdults = (cell.adultcount + cell.adultcount2)
    //
    //
    //
    //            if totalRooms == 1 {
    //
    //                totalAdults = (cell.adultcount)
    //                totalChildren = (cell.childCount)
    //
    //                adtArray.append("\(cell.adultcount)")
    //                chArray.append("\(cell.childCount)")
    //
    //
    //
    //
    //            }
    //
    //            if totalRooms == 2 {
    //
    //                totalAdults = (cell.adultcount + cell.adultcount2)
    //                totalChildren = (cell.childCount + cell.childCount2)
    //
    //
    //                adtArray.append("\(cell.adultcount)")
    //                chArray.append("\(cell.childCount)")
    //
    //                adtArray.append("\(cell.adultcount2)")
    //                chArray.append("\(cell.childCount2)")
    //
    //
    //            }
    //
    //
    //            if totalRooms == 3 {
    //                totalAdults = (cell.adultcount + cell.adultcount2 + cell.adultcount3)
    //                totalChildren = (cell.childCount + cell.childCount2 + cell.childCount3)
    //                adtArray.append("\(cell.adultcount)")
    //                chArray.append("\(cell.childCount)")
    //
    //                adtArray.append("\(cell.adultcount2)")
    //                chArray.append("\(cell.childCount2)")
    //
    //                adtArray.append("\(cell.adultcount3)")
    //                chArray.append("\(cell.childCount3)")
    //            }
    //
    //
    //
    //
    //        }
    //
    //
    //
    //        print("totalRooms ==== \(totalRooms)")
    //        print("totalAdults ==== \(totalAdults)")
    //        print("totalChildren ==== \(totalChildren)")
    //
    //        print("adtArray ==== \(adtArray)")
    //        print("chArray ==== \(chArray)")
    //
    //        defaults.set(totalRooms, forKey: UserDefaultsKeys.roomcount)
    //        defaults.set(totalAdults, forKey: UserDefaultsKeys.hoteladultscount)
    //        defaults.set(totalChildren, forKey: UserDefaultsKeys.hotelchildcount)
    //        defaults.set((totalChildren + totalAdults), forKey: UserDefaultsKeys.guestcount)
    //        print("guestcount ==== \(totalChildren + totalAdults)")
    //
    //
    //        if totalChildren == 0 {
    //            defaults.set("Rooms \(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? ""):Adults \(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "")", forKey: UserDefaultsKeys.selectPersons)
    //        }else {
    //            defaults.set("Rooms \(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? ""):Adults \(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? ""),Children \(defaults.string(forKey: UserDefaultsKeys.hotelchildcount) ?? "")", forKey: UserDefaultsKeys.selectPersons)
    //        }
    //
    //
    //
    //        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
    //        dismiss(animated: true)
    //
    //    }
    
    func didTapOnDualBtn1(cell: ButtonTVCell) {
        
    }
    
    func didTapOnDualBtn2(cell: ButtonTVCell) {
        
    }
    
    func adultsIncrementButtonAction4(cell: RoomsCountTVCell) {
        
    }
    
    func adultsDecrementBtnAction4(cell: RoomsCountTVCell) {
        
    }
    
    func childrenIncrementButtonAction4(cell: RoomsCountTVCell) {
        
    }
    
    func childrenDecrementBtnAction4(cell: RoomsCountTVCell) {
        
    }
    
    
    
    
}
