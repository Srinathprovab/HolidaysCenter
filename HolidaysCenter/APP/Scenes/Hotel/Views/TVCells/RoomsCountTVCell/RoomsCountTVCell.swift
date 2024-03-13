//
//  RoomsCountTVCell.swift
//  roomscountLogicProject
//
//  Created by FCI on 09/04/23.
//

import UIKit
import DropDown

protocol RoomsCountTVCellDelegate {
    func didTapOnAddRoomBtnAction(cell:RoomsCountTVCell)
    func didTapOnCloseRoom(cell:RoomsCountTVCell)
    
    func adultsIncrementButtonAction(cell:RoomsCountTVCell)
    func adultsDecrementBtnAction(cell:RoomsCountTVCell)
    func childrenIncrementButtonAction(cell:RoomsCountTVCell)
    func childrenDecrementBtnAction(cell:RoomsCountTVCell)
    
    
    func adultsIncrementButtonAction2(cell:RoomsCountTVCell)
    func adultsDecrementBtnAction2(cell:RoomsCountTVCell)
    func childrenIncrementButtonAction2(cell:RoomsCountTVCell)
    func childrenDecrementBtnAction2(cell:RoomsCountTVCell)
    
    
    func adultsIncrementButtonAction3(cell:RoomsCountTVCell)
    func adultsDecrementBtnAction3(cell:RoomsCountTVCell)
    func childrenIncrementButtonAction3(cell:RoomsCountTVCell)
    func childrenDecrementBtnAction3(cell:RoomsCountTVCell)
    
    func adultsIncrementButtonAction4(cell:RoomsCountTVCell)
    func adultsDecrementBtnAction4(cell:RoomsCountTVCell)
    func childrenIncrementButtonAction4(cell:RoomsCountTVCell)
    func childrenDecrementBtnAction4(cell:RoomsCountTVCell)
    
}

class RoomsCountTVCell: UITableViewCell {
    
    @IBOutlet weak var roomView1: UIView!
    @IBOutlet weak var roomView2: UIView!
    @IBOutlet weak var roomView3: UIView!
    @IBOutlet weak var addRoomBtnView: UIView!
    @IBOutlet weak var addRoomlbl: UILabel!
    @IBOutlet weak var addRoomBtn: UIButton!
    @IBOutlet weak var room2Close: UIButton!
    @IBOutlet weak var room3Close: UIButton!
    
    @IBOutlet weak var titlelbl1: UILabel!
    @IBOutlet weak var adultslbl1: UILabel!
    @IBOutlet weak var adultsSubtitlelbl1: UILabel!
    @IBOutlet weak var aIncrementBtn1: UIButton!
    @IBOutlet weak var adultsCountlbl1: UILabel!
    @IBOutlet weak var aDecrementBtn1: UIButton!
    @IBOutlet weak var childrenlbl1: UILabel!
    @IBOutlet weak var childrenSubtitlelbl1: UILabel!
    @IBOutlet weak var cIncrementBtn1: UIButton!
    @IBOutlet weak var childrenCountlbl1: UILabel!
    @IBOutlet weak var cDecrementBtn1: UIButton!
    
    @IBOutlet weak var titlelbl2: UILabel!
    @IBOutlet weak var adultslbl2: UILabel!
    @IBOutlet weak var adultsSubtitlelbl2: UILabel!
    @IBOutlet weak var aIncrementBtn2: UIButton!
    @IBOutlet weak var adultsCountlbl2: UILabel!
    @IBOutlet weak var aDecrementBtn2: UIButton!
    @IBOutlet weak var childrenlbl2: UILabel!
    @IBOutlet weak var childrenSubtitlelbl2: UILabel!
    @IBOutlet weak var cIncrementBtn2: UIButton!
    @IBOutlet weak var childrenCountlbl2: UILabel!
    @IBOutlet weak var cDecrementBtn2: UIButton!
    
    @IBOutlet weak var titlelbl3: UILabel!
    @IBOutlet weak var adultslbl3: UILabel!
    @IBOutlet weak var adultsSubtitlelbl3: UILabel!
    @IBOutlet weak var aIncrementBtn3: UIButton!
    @IBOutlet weak var adultsCountlbl3: UILabel!
    @IBOutlet weak var aDecrementBtn3: UIButton!
    @IBOutlet weak var childrenlbl3: UILabel!
    @IBOutlet weak var childrenSubtitlelbl3: UILabel!
    @IBOutlet weak var cIncrementBtn3: UIButton!
    @IBOutlet weak var childrenCountlbl3: UILabel!
    @IBOutlet weak var cDecrementBtn3: UIButton!
    
    
    
    @IBOutlet weak var room2CloseView: UIView!
    @IBOutlet weak var room3CloseView: UIView!
    
    
    @IBOutlet weak var room1Height: NSLayoutConstraint!
    @IBOutlet weak var room1ChildageView1: UIView!
    @IBOutlet weak var childage1View: UIView!
    @IBOutlet weak var room1ChildageView2: UIView!
    @IBOutlet weak var childage2View: UIView!
    @IBOutlet weak var room1Child1Titlelbl: UILabel!
    @IBOutlet weak var room1childagevalue1lbl: UILabel!
    @IBOutlet weak var room1childageTapBtn1: UIButton!
    @IBOutlet weak var room1Child2Titlelbl: UILabel!
    @IBOutlet weak var room1childagevalue2lbl: UILabel!
    @IBOutlet weak var room1childageTapBtn2: UIButton!
    
    @IBOutlet weak var childage3View: UIView!
    @IBOutlet weak var room1ChildageView3: UIView!
    @IBOutlet weak var room1Child3Titlelbl: UILabel!
    @IBOutlet weak var room1childagevalue3lbl: UILabel!
    @IBOutlet weak var room1childageTapBtn3: UIButton!
    var room1ChildageTapDropDown3 = DropDown()
    
    @IBOutlet weak var room1child4child5Holder: UIStackView!
    
    @IBOutlet weak var childage4View: UIView!
    @IBOutlet weak var room1ChildageView4: UIView!
    @IBOutlet weak var room1Child4Titlelbl: UILabel!
    @IBOutlet weak var room1childagevalue4lbl: UILabel!
    @IBOutlet weak var room1childageTapBtn4: UIButton!
    var room1ChildageTapDropDown4 = DropDown()
    
    
    @IBOutlet weak var childage5View: UIView!
    @IBOutlet weak var room1ChildageView5: UIView!
    @IBOutlet weak var room1Child5Titlelbl: UILabel!
    @IBOutlet weak var room1childagevalue5lbl: UILabel!
    @IBOutlet weak var room1childageTapBtn5: UIButton!
    var room1ChildageTapDropDown5 = DropDown()
    
//==================================================== Room2
    
    @IBOutlet weak var room2Height: NSLayoutConstraint!
    @IBOutlet weak var room2ChildageView1: UIView!
    @IBOutlet weak var r2childage1View: UIView!
    @IBOutlet weak var room2ChildageView2: UIView!
    @IBOutlet weak var r2childage2View: UIView!
    @IBOutlet weak var room2Child1Titlelbl: UILabel!
    @IBOutlet weak var room2childagevalue1lbl: UILabel!
    @IBOutlet weak var room2childageTapBtn1: UIButton!
    @IBOutlet weak var room2Child2Titlelbl: UILabel!
    @IBOutlet weak var room2childagevalue2lbl: UILabel!
    @IBOutlet weak var room2childageTapBtn2: UIButton!
    
    @IBOutlet weak var room2childage3View: UIView!
    @IBOutlet weak var room2ChildageView3: UIView!
    @IBOutlet weak var room2Child3Titlelbl: UILabel!
    @IBOutlet weak var room2childagevalue3lbl: UILabel!
    @IBOutlet weak var room2childageTapBtn3: UIButton!
    var room2ChildageTapDropDown3 = DropDown()
    
    @IBOutlet weak var room2child4child5Holder: UIStackView!
    
    @IBOutlet weak var room2childage4View: UIView!
    @IBOutlet weak var room2ChildageView4: UIView!
    @IBOutlet weak var room2Child4Titlelbl: UILabel!
    @IBOutlet weak var room2childagevalue4lbl: UILabel!
    @IBOutlet weak var room2childageTapBtn4: UIButton!
    var room2ChildageTapDropDown4 = DropDown()
    
    
    @IBOutlet weak var room2childage5View: UIView!
    @IBOutlet weak var room2ChildageView5: UIView!
    @IBOutlet weak var room2Child5Titlelbl: UILabel!
    @IBOutlet weak var room2childagevalue5lbl: UILabel!
    @IBOutlet weak var room2childageTapBtn5: UIButton!
    var room2ChildageTapDropDown5 = DropDown()
    
//Room3 =============================================================
    @IBOutlet weak var room3Height: NSLayoutConstraint!
    @IBOutlet weak var room3ChildageView1: UIView!
    @IBOutlet weak var r3childage1View: UIView!
    @IBOutlet weak var room3ChildageView2: UIView!
    @IBOutlet weak var r3childage2View: UIView!
    @IBOutlet weak var room3Child1Titlelbl: UILabel!
    @IBOutlet weak var room3childagevalue1lbl: UILabel!
    @IBOutlet weak var room3childageTapBtn1: UIButton!
    @IBOutlet weak var room3Child2Titlelbl: UILabel!
    @IBOutlet weak var room3childagevalue2lbl: UILabel!
    @IBOutlet weak var room3childageTapBtn2: UIButton!
    
    
    @IBOutlet weak var room3childage3View: UIView!
    @IBOutlet weak var room3ChildageView3: UIView!
    @IBOutlet weak var room3Child3Titlelbl: UILabel!
    @IBOutlet weak var room3childagevalue3lbl: UILabel!
    @IBOutlet weak var room3childageTapBtn3: UIButton!
    var room3ChildageTapDropDown3 = DropDown()
    
    @IBOutlet weak var room3child4child5Holder: UIStackView!
    
    @IBOutlet weak var room3childage4View: UIView!
    @IBOutlet weak var room3ChildageView4: UIView!
    @IBOutlet weak var room3Child4Titlelbl: UILabel!
    @IBOutlet weak var room3childagevalue4lbl: UILabel!
    @IBOutlet weak var room3childageTapBtn4: UIButton!
    var room3ChildageTapDropDown4 = DropDown()
    
    
    @IBOutlet weak var room3childage5View: UIView!
    @IBOutlet weak var room3ChildageView5: UIView!
    @IBOutlet weak var room3Child5Titlelbl: UILabel!
    @IBOutlet weak var room3childagevalue5lbl: UILabel!
    @IBOutlet weak var room3childageTapBtn5: UIButton!
    var room3ChildageTapDropDown5 = DropDown()
    
    
    var adultcount = 2
    var childCount = Int()
    var adultcount2 = 1
    var childCount2 = Int()
    var adultcount3 = 1
    var childCount3 = Int()
    
    
    //Room1
    var room1ChildageTapDropDown1 = DropDown()
    var room1ChildageTapDropDown2 = DropDown()
   
    
    // Room2
    var room2ChildageTapDropDown1 = DropDown()
    var room2ChildageTapDropDown2 = DropDown()
    
    // Room3
    var room3ChildageTapDropDown1 = DropDown()
    var room3ChildageTapDropDown2 = DropDown()
    
    
    
    
    var roomCount = 1
    var delegate:RoomsCountTVCellDelegate?
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
        
        
        setuplabels(lbl: addRoomlbl, text: "+ Add Room", textcolor: .BtnTitleColor, font: .LatoSemibold(size: 16), align: .center)
        addRoomBtnView.backgroundColor = .AppBtnColor
        addRoomBtnView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 8)
        
        roomView1.isHidden = false
        roomView2.isHidden = true
        roomView3.isHidden = true
        addRoomBtn.setTitle("", for: .normal)
        room2Close.addTarget(self, action: #selector(didTapOnCloseRoom(_:)), for: .touchUpInside)
        room3Close.addTarget(self, action: #selector(didTapOnCloseRoom(_:)), for: .touchUpInside)
        //     room4Close.addTarget(self, action: #selector(didTapOnCloseRoom(_:)), for: .touchUpInside)
        room2Close.tag = 2
        room3Close.tag = 3
        
        room2CloseView.isHidden = true
        room3CloseView.isHidden = true
        
        
        
        
        //Room1
        room1Height.constant = 280
        childage1View.isHidden = true
        room1ChildageView1.backgroundColor = .WhiteColor
        room1ChildageView1.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 3)
        setuplabels(lbl: room1Child1Titlelbl, text: "Child 1", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
        setuplabels(lbl: room1childagevalue1lbl, text: "0", textcolor: .SubTitleColor, font: .LatoRegular(size: 14), align: .center)
        room1childageTapBtn1.setTitle("", for: .normal)
        room1childageTapBtn1.addTarget(self, action: #selector(didTapOnRoom1ChildAgeBtn1Action(_:)), for: .touchUpInside)
        setupRoom1ChildageTapDropDown1()

        childage2View.isHidden = true
        room1ChildageView2.backgroundColor = .WhiteColor
        room1ChildageView2.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 3)
        setuplabels(lbl: room1Child2Titlelbl, text: "Child 2", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
        setuplabels(lbl: room1childagevalue2lbl, text: "0", textcolor: .SubTitleColor, font: .LatoRegular(size: 14), align: .center)
        room1childageTapBtn2.setTitle("", for: .normal)
        room1childageTapBtn2.addTarget(self, action: #selector(didTapOnRoom1ChildAgeBtn2Action(_:)), for: .touchUpInside)
        setupRoom1ChildageTapDropDown2()

        childage3View.isHidden = true
        room1ChildageView3.backgroundColor = .WhiteColor
        room1ChildageView3.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 3)
        setuplabels(lbl: room1Child3Titlelbl, text: "Child 3", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
        setuplabels(lbl: room1childagevalue3lbl, text: "0", textcolor: .SubTitleColor, font: .LatoRegular(size: 14), align: .center)
        room1childageTapBtn3.setTitle("", for: .normal)
        room1childageTapBtn3.addTarget(self, action: #selector(didTapOnRoom1ChildAgeBtn3Action(_:)), for: .touchUpInside)
        setupRoom1ChildageTapDropDown3()
        
        childage4View.isHidden = true
        room1ChildageView4.backgroundColor = .WhiteColor
        room1ChildageView4.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 3)
        setuplabels(lbl: room1Child4Titlelbl, text: "Child 4", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
        setuplabels(lbl: room1childagevalue4lbl, text: "0", textcolor: .SubTitleColor, font: .LatoRegular(size: 14), align: .center)
        room1childageTapBtn4.setTitle("", for: .normal)
        room1childageTapBtn4.addTarget(self, action: #selector(didTapOnRoom1ChildAgeBtn4Action(_:)), for: .touchUpInside)
        setupRoom1ChildageTapDropDown4()
        
        childage5View.isHidden = true
        room1ChildageView5.backgroundColor = .WhiteColor
        room1ChildageView5.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 3)
        setuplabels(lbl: room1Child5Titlelbl, text: "Child 5", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
        setuplabels(lbl: room1childagevalue5lbl, text: "0", textcolor: .SubTitleColor, font: .LatoRegular(size: 14), align: .center)
        room1childageTapBtn5.setTitle("", for: .normal)
        room1childageTapBtn5.addTarget(self, action: #selector(didTapOnRoom1ChildAgeBtn5Action(_:)), for: .touchUpInside)
        setupRoom1ChildageTapDropDown5()
        
    
        
        
        //Room2 ===============================================
        room2Height.constant = 220
        r2childage1View.isHidden = true
        room2ChildageView1.backgroundColor = .WhiteColor
        room2ChildageView1.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 3)
        r2childage2View.isHidden = true
        room2ChildageView2.backgroundColor = .WhiteColor
        room2ChildageView2.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 3)
        
        setuplabels(lbl: room2Child1Titlelbl, text: "Child 1", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: room2Child2Titlelbl, text: "Child 2", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: room2childagevalue1lbl, text: "0", textcolor: .SubTitleColor, font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: room2childagevalue2lbl, text: "0", textcolor: .SubTitleColor, font: .LatoRegular(size: 14), align: .center)
        room2childageTapBtn1.setTitle("", for: .normal)
        room2childageTapBtn1.addTarget(self, action: #selector(didTapOnRoom2ChildAgeBtn1Action(_:)), for: .touchUpInside)
        room2childageTapBtn2.setTitle("", for: .normal)
        room2childageTapBtn2.addTarget(self, action: #selector(didTapOnRoom2ChildAgeBtn2Action(_:)), for: .touchUpInside)
        setupRoom2ChildageTapDropDown1()
        setupRoom2ChildageTapDropDown2()
        
        room2childage3View.isHidden = true
        room2ChildageView3.backgroundColor = .WhiteColor
        room2ChildageView3.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 3)
        setuplabels(lbl: room2Child3Titlelbl, text: "Child 3", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
        setuplabels(lbl: room2childagevalue3lbl, text: "0", textcolor: .SubTitleColor, font: .LatoRegular(size: 14), align: .center)
        room2childageTapBtn3.setTitle("", for: .normal)
        room2childageTapBtn3.addTarget(self, action: #selector(didTapOnRoom2ChildAgeBtn3Action(_:)), for: .touchUpInside)
        setupRoom2ChildageTapDropDown3()
        
        room2childage4View.isHidden = true
        room2ChildageView4.backgroundColor = .WhiteColor
        room2ChildageView4.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 3)
        setuplabels(lbl: room2Child4Titlelbl, text: "Child 4", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
        setuplabels(lbl: room2childagevalue4lbl, text: "0", textcolor: .SubTitleColor, font: .LatoRegular(size: 14), align: .center)
        room2childageTapBtn4.setTitle("", for: .normal)
        room2childageTapBtn4.addTarget(self, action: #selector(didTapOnRoom2ChildAgeBtn4Action(_:)), for: .touchUpInside)
        setupRoom2ChildageTapDropDown4()
        
        room2childage5View.isHidden = true
        room2ChildageView5.backgroundColor = .WhiteColor
        room2ChildageView5.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 3)
        setuplabels(lbl: room2Child5Titlelbl, text: "Child 5", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
        setuplabels(lbl: room2childagevalue5lbl, text: "0", textcolor: .SubTitleColor, font: .LatoRegular(size: 14), align: .center)
        room2childageTapBtn5.setTitle("", for: .normal)
        room2childageTapBtn5.addTarget(self, action: #selector(didTapOnRoom2ChildAgeBtn5Action(_:)), for: .touchUpInside)
        setupRoom2ChildageTapDropDown5()
        
        
        
        //Room3
        room3Height.constant = 220
        r3childage1View.isHidden = true
        room3ChildageView1.backgroundColor = .WhiteColor
        room3ChildageView1.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 3)
        r3childage2View.isHidden = true
        room3ChildageView2.backgroundColor = .WhiteColor
        room3ChildageView2.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 3)
        
        setuplabels(lbl: room3Child1Titlelbl, text: "Child 1", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: room3Child2Titlelbl, text: "Child 2", textcolor: .AppLabelColor, font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: room3childagevalue1lbl, text: "0", textcolor: .SubTitleColor, font: .LatoRegular(size: 14), align: .center)
        setuplabels(lbl: room3childagevalue2lbl, text: "0", textcolor: .SubTitleColor, font: .LatoRegular(size: 14), align: .center)
        room3childageTapBtn1.setTitle("", for: .normal)
        room3childageTapBtn1.addTarget(self, action: #selector(didTapOnRoom3ChildAgeBtn1Action(_:)), for: .touchUpInside)
        room3childageTapBtn2.setTitle("", for: .normal)
        room3childageTapBtn2.addTarget(self, action: #selector(didTapOnRoom3ChildAgeBtn2Action(_:)), for: .touchUpInside)
        setupRoom3ChildageTapDropDown1()
        setupRoom3ChildageTapDropDown2()
        
        
        room3childage3View.isHidden = true
        room3ChildageView3.backgroundColor = .WhiteColor
        room3ChildageView3.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 3)
        setuplabels(lbl: room3Child3Titlelbl, text: "Child 3", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
        setuplabels(lbl: room3childagevalue3lbl, text: "0", textcolor: .SubTitleColor, font: .LatoRegular(size: 14), align: .center)
        room3childageTapBtn3.setTitle("", for: .normal)
        room3childageTapBtn3.addTarget(self, action: #selector(didTapOnRoom3ChildAgeBtn3Action(_:)), for: .touchUpInside)
        setupRoom3ChildageTapDropDown3()
        
        room3childage4View.isHidden = true
        room3ChildageView4.backgroundColor = .WhiteColor
        room3ChildageView4.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 3)
        setuplabels(lbl: room3Child4Titlelbl, text: "Child 4", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
        setuplabels(lbl: room3childagevalue4lbl, text: "0", textcolor: .SubTitleColor, font: .LatoRegular(size: 14), align: .center)
        room3childageTapBtn4.setTitle("", for: .normal)
        room3childageTapBtn4.addTarget(self, action: #selector(didTapOnRoom3ChildAgeBtn4Action(_:)), for: .touchUpInside)
        setupRoom3ChildageTapDropDown4()
        
        room3childage5View.isHidden = true
        room3ChildageView5.backgroundColor = .WhiteColor
        room3ChildageView5.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 3)
        setuplabels(lbl: room3Child5Titlelbl, text: "Child 5", textcolor: .AppLabelColor, font: .LatoRegular(size: 12), align: .center)
        setuplabels(lbl: room3childagevalue5lbl, text: "0", textcolor: .SubTitleColor, font: .LatoRegular(size: 14), align: .center)
        room3childageTapBtn5.setTitle("", for: .normal)
        room3childageTapBtn5.addTarget(self, action: #selector(didTapOnRoom3ChildAgeBtn5Action(_:)), for: .touchUpInside)
        setupRoom3ChildageTapDropDown5()
        
        
        
        
        setupUI1()
        setupUI2()
        setupUI3()
    }
    
    
    func updateChildAgesArray(index: Int, age: String) {
        if index < childAgesArray.count {
            childAgesArray[index].append(age)
        } else {
            childAgesArray.append([age])
        }
    }
    
  
    
    
    
    //Room1
    @objc func didTapOnRoom1ChildAgeBtn1Action(_ sender:UIButton) {
        room1ChildageTapDropDown1.show()
    }
    
    @objc func didTapOnRoom1ChildAgeBtn2Action(_ sender:UIButton) {
        room1ChildageTapDropDown2.show()
    }
    
    @objc func didTapOnRoom1ChildAgeBtn3Action(_ sender:UIButton) {
        room1ChildageTapDropDown3.show()
    }
    
    @objc func didTapOnRoom1ChildAgeBtn4Action(_ sender:UIButton) {
        room1ChildageTapDropDown4.show()
    }
    
    @objc func didTapOnRoom1ChildAgeBtn5Action(_ sender:UIButton) {
        room1ChildageTapDropDown5.show()
    }
    
    
    func setupRoom1ChildageTapDropDown1() {
        self.room1childagevalue1lbl.text = "Age"
        room1ChildageTapDropDown1.textColor = .AppLabelColor
        room1ChildageTapDropDown1.dataSource = ["1","2","3","4","5","6","7","8","9","10","11"]
        room1ChildageTapDropDown1.direction = .any
        room1ChildageTapDropDown1.backgroundColor = .WhiteColor
        room1ChildageTapDropDown1.anchorView = self.childage1View
        room1ChildageTapDropDown1.bottomOffset = CGPoint(x: 0, y: childage1View.frame.size.height + 10)
        room1ChildageTapDropDown1.selectionAction = { [weak self] (index: Int, item: String) in
            self?.room1childagevalue1lbl.text = item
            self?.room1childagevalue1lbl.textColor = .AppLabelColor
            self?.updateChildAgesArray(index: 0, age: item)
        }
    }
    
    
    
    func setupRoom1ChildageTapDropDown2() {
        self.room1childagevalue2lbl.text = "Age"
        room1ChildageTapDropDown2.textColor = .AppLabelColor
        room1ChildageTapDropDown2.dataSource = ["1","2","3","4","5","6","7","8","9","10","11"]
        room1ChildageTapDropDown2.direction = .any
        room1ChildageTapDropDown2.backgroundColor = .WhiteColor
        room1ChildageTapDropDown2.anchorView = self.childage2View
        room1ChildageTapDropDown2.bottomOffset = CGPoint(x: 0, y: childage2View.frame.size.height + 10)
        room1ChildageTapDropDown2.selectionAction = { [weak self] (index: Int, item: String) in
            self?.room1childagevalue2lbl.text = item
            self?.room1childagevalue2lbl.textColor = .AppLabelColor
            self?.updateChildAgesArray(index: 0, age: item)
        }
    }
    
    
    func setupRoom1ChildageTapDropDown3() {
        self.room1childagevalue3lbl.text = "0"
        room1ChildageTapDropDown3.textColor = .AppLabelColor
        room1ChildageTapDropDown3.dataSource = ["1","2","3","4","5","6","7","8","9","10","11"]
        room1ChildageTapDropDown3.direction = .any
        room1ChildageTapDropDown3.backgroundColor = .WhiteColor
        room1ChildageTapDropDown3.anchorView = self.childage3View
        room1ChildageTapDropDown3.bottomOffset = CGPoint(x: 0, y: childage3View.frame.size.height + 10)
        room1ChildageTapDropDown3.selectionAction = { [weak self] (index: Int, item: String) in
            self?.room1childagevalue3lbl.text = item
            self?.room1childagevalue3lbl.textColor = .AppLabelColor
            self?.updateChildAgesArray(index: 0, age: item)
        }
    }
    
    
    func setupRoom1ChildageTapDropDown4() {
        self.room1childagevalue4lbl.text = "0"
        room1ChildageTapDropDown4.textColor = .AppLabelColor
        room1ChildageTapDropDown4.dataSource = ["1","2","3","4","5","6","7","8","9","10","11"]
        room1ChildageTapDropDown4.direction = .any
        room1ChildageTapDropDown4.backgroundColor = .WhiteColor
        room1ChildageTapDropDown4.anchorView = self.childage4View
        room1ChildageTapDropDown4.bottomOffset = CGPoint(x: 0, y: childage3View.frame.size.height + 10)
        room1ChildageTapDropDown4.selectionAction = { [weak self] (index: Int, item: String) in
            self?.room1childagevalue4lbl.text = item
            self?.room1childagevalue4lbl.textColor = .AppLabelColor
            self?.updateChildAgesArray(index: 0, age: item)
        }
    }
    
    
    func setupRoom1ChildageTapDropDown5() {
        self.room1childagevalue5lbl.text = "0"
        room1ChildageTapDropDown5.textColor = .AppLabelColor
        room1ChildageTapDropDown5.dataSource = ["1","2","3","4","5","6","7","8","9","10","11"]
        room1ChildageTapDropDown5.direction = .any
        room1ChildageTapDropDown5.backgroundColor = .WhiteColor
        room1ChildageTapDropDown5.anchorView = self.childage5View
        room1ChildageTapDropDown5.bottomOffset = CGPoint(x: 0, y: childage3View.frame.size.height + 10)
        room1ChildageTapDropDown5.selectionAction = { [weak self] (index: Int, item: String) in
            self?.room1childagevalue5lbl.text = item
            self?.room1childagevalue5lbl.textColor = .AppLabelColor
            self?.updateChildAgesArray(index: 0, age: item)
        }
    }
    
    
    //Room2 ========================================================
    @objc func didTapOnRoom2ChildAgeBtn1Action(_ sender:UIButton) {
        room2ChildageTapDropDown1.show()
    }
    
    @objc func didTapOnRoom2ChildAgeBtn2Action(_ sender:UIButton) {
        room2ChildageTapDropDown2.show()
    }
    
    @objc func didTapOnRoom2ChildAgeBtn3Action(_ sender:UIButton) {
        room2ChildageTapDropDown3.show()
    }
    
    @objc func didTapOnRoom2ChildAgeBtn4Action(_ sender:UIButton) {
        room2ChildageTapDropDown4.show()
    }
    
    @objc func didTapOnRoom2ChildAgeBtn5Action(_ sender:UIButton) {
        room2ChildageTapDropDown5.show()
    }
    
    func setupRoom2ChildageTapDropDown1() {
        self.room2childagevalue1lbl.text = "Age"
        room2ChildageTapDropDown1.textColor = .AppLabelColor
        room2ChildageTapDropDown1.dataSource = ["1","2","3","4","5","6","7","8","9","10","11"]
        room2ChildageTapDropDown1.direction = .any
        room2ChildageTapDropDown1.backgroundColor = .WhiteColor
        room2ChildageTapDropDown1.anchorView = self.r2childage1View
        room2ChildageTapDropDown1.bottomOffset = CGPoint(x: 0, y: r2childage1View.frame.size.height + 10)
        room2ChildageTapDropDown1.selectionAction = { [weak self] (index: Int, item: String) in
            self?.room2childagevalue1lbl.text = item
            self?.room2childagevalue1lbl.textColor = .AppLabelColor
            self?.updateChildAgesArray(index: 0, age: item)
        }
    }
    
    func setupRoom2ChildageTapDropDown2() {
        self.room2childagevalue2lbl.text = "Age"
        room2ChildageTapDropDown2.textColor = .AppLabelColor
        room2ChildageTapDropDown2.dataSource = ["1","2","3","4","5","6","7","8","9","10","11"]
        room2ChildageTapDropDown2.direction = .any
        room2ChildageTapDropDown2.backgroundColor = .WhiteColor
        room2ChildageTapDropDown2.anchorView = self.r2childage2View
        room2ChildageTapDropDown2.bottomOffset = CGPoint(x: 0, y: r2childage2View.frame.size.height + 10)
        room2ChildageTapDropDown2.selectionAction = { [weak self] (index: Int, item: String) in
            self?.room2childagevalue2lbl.text = item
            self?.room2childagevalue2lbl.textColor = .AppLabelColor
            self?.updateChildAgesArray(index: 0, age: item)
        }
    }
    
    
    
    func setupRoom2ChildageTapDropDown3() {
        self.room2childagevalue3lbl.text = "0"
        room2ChildageTapDropDown3.textColor = .AppLabelColor
        room2ChildageTapDropDown3.dataSource = ["1","2","3","4","5","6","7","8","9","10","11"]
        room2ChildageTapDropDown3.direction = .any
        room2ChildageTapDropDown3.backgroundColor = .WhiteColor
        room2ChildageTapDropDown3.anchorView = self.room2childage3View
        room2ChildageTapDropDown3.bottomOffset = CGPoint(x: 0, y: room2childage3View.frame.size.height + 10)
        room2ChildageTapDropDown3.selectionAction = { [weak self] (index: Int, item: String) in
            self?.room2childagevalue3lbl.text = item
            self?.room2childagevalue3lbl.textColor = .AppLabelColor
            self?.updateChildAgesArray(index: 0, age: item)
        }
    }
    
    func setupRoom2ChildageTapDropDown4() {
        self.room2childagevalue4lbl.text = "0"
        room2ChildageTapDropDown4.textColor = .AppLabelColor
        room2ChildageTapDropDown4.dataSource = ["1","2","3","4","5","6","7","8","9","10","11"]
        room2ChildageTapDropDown4.direction = .any
        room2ChildageTapDropDown4.backgroundColor = .WhiteColor
        room2ChildageTapDropDown4.anchorView = self.room2childage4View
        room2ChildageTapDropDown4.bottomOffset = CGPoint(x: 0, y: room2childage4View.frame.size.height + 10)
        room2ChildageTapDropDown4.selectionAction = { [weak self] (index: Int, item: String) in
            self?.room2childagevalue4lbl.text = item
            self?.room2childagevalue4lbl.textColor = .AppLabelColor
            self?.updateChildAgesArray(index: 0, age: item)
        }
    }
    
    func setupRoom2ChildageTapDropDown5() {
        self.room2childagevalue5lbl.text = "0"
        room2ChildageTapDropDown5.textColor = .AppLabelColor
        room2ChildageTapDropDown5.dataSource = ["1","2","3","4","5","6","7","8","9","10","11"]
        room2ChildageTapDropDown5.direction = .any
        room2ChildageTapDropDown5.backgroundColor = .WhiteColor
        room2ChildageTapDropDown5.anchorView = self.room2childage5View
        room2ChildageTapDropDown5.bottomOffset = CGPoint(x: 0, y: room2childage5View.frame.size.height + 10)
        room2ChildageTapDropDown5.selectionAction = { [weak self] (index: Int, item: String) in
            self?.room2childagevalue5lbl.text = item
            self?.room2childagevalue5lbl.textColor = .AppLabelColor
            self?.updateChildAgesArray(index: 0, age: item)
        }
    }
    
    
    
    //Room3
    @objc func didTapOnRoom3ChildAgeBtn1Action(_ sender:UIButton) {
        room3ChildageTapDropDown1.show()
    }
    
    @objc func didTapOnRoom3ChildAgeBtn2Action(_ sender:UIButton) {
        room3ChildageTapDropDown2.show()
    }
    
    @objc func didTapOnRoom3ChildAgeBtn3Action(_ sender:UIButton) {
        room3ChildageTapDropDown3.show()
    }
    
    @objc func didTapOnRoom3ChildAgeBtn4Action(_ sender:UIButton) {
        room3ChildageTapDropDown4.show()
    }
    
    @objc func didTapOnRoom3ChildAgeBtn5Action(_ sender:UIButton) {
        room3ChildageTapDropDown5.show()
    }
    
    
    func setupRoom3ChildageTapDropDown1() {
        self.room3childagevalue1lbl.text = "Age"
        room3ChildageTapDropDown1.textColor = .AppLabelColor
        room3ChildageTapDropDown1.dataSource = ["1","2","3","4","5","6","7","8","9","10","11"]
        room3ChildageTapDropDown1.direction = .any
        room3ChildageTapDropDown1.backgroundColor = .WhiteColor
        room3ChildageTapDropDown1.anchorView = self.r3childage1View
        room3ChildageTapDropDown1.bottomOffset = CGPoint(x: 0, y: r3childage1View.frame.size.height + 10)
        room3ChildageTapDropDown1.selectionAction = { [weak self] (index: Int, item: String) in
            self?.room3childagevalue1lbl.text = item
            self?.room3childagevalue1lbl.textColor = .AppLabelColor
            self?.updateChildAgesArray(index: 0, age: item)
        }
    }
    
    func setupRoom3ChildageTapDropDown2() {
        self.room3childagevalue2lbl.text = "Age"
        room3ChildageTapDropDown2.textColor = .AppLabelColor
        room3ChildageTapDropDown2.dataSource = ["1","2","3","4","5","6","7","8","9","10","11"]
        room3ChildageTapDropDown2.direction = .any
        room3ChildageTapDropDown2.backgroundColor = .WhiteColor
        room3ChildageTapDropDown2.anchorView = self.r3childage2View
        room3ChildageTapDropDown2.bottomOffset = CGPoint(x: 0, y: r3childage2View.frame.size.height + 10)
        room3ChildageTapDropDown2.selectionAction = { [weak self] (index: Int, item: String) in
            self?.room3childagevalue2lbl.text = item
            self?.room3childagevalue2lbl.textColor = .AppLabelColor
            self?.updateChildAgesArray(index: 0, age: item)
        }
    }
    
    
    func setupRoom3ChildageTapDropDown3() {
        self.room3childagevalue3lbl.text = "0"
        room3ChildageTapDropDown3.textColor = .AppLabelColor
        room3ChildageTapDropDown3.dataSource = ["1","2","3","4","5","6","7","8","9","10","11"]
        room3ChildageTapDropDown3.direction = .any
        room3ChildageTapDropDown3.backgroundColor = .WhiteColor
        room3ChildageTapDropDown3.anchorView = self.room3childage3View
        room3ChildageTapDropDown3.bottomOffset = CGPoint(x: 0, y: room3childage3View.frame.size.height + 10)
        room3ChildageTapDropDown3.selectionAction = { [weak self] (index: Int, item: String) in
            self?.room3childagevalue3lbl.text = item
            self?.room3childagevalue3lbl.textColor = .AppLabelColor
            self?.updateChildAgesArray(index: 0, age: item)
        }
    }
    
    func setupRoom3ChildageTapDropDown4() {
        self.room3childagevalue4lbl.text = "0"
        room3ChildageTapDropDown4.textColor = .AppLabelColor
        room3ChildageTapDropDown4.dataSource = ["1","2","3","4","5","6","7","8","9","10","11"]
        room3ChildageTapDropDown4.direction = .any
        room3ChildageTapDropDown4.backgroundColor = .WhiteColor
        room3ChildageTapDropDown4.anchorView = self.room3childage4View
        room3ChildageTapDropDown4.bottomOffset = CGPoint(x: 0, y: room3childage4View.frame.size.height + 10)
        room3ChildageTapDropDown4.selectionAction = { [weak self] (index: Int, item: String) in
            self?.room3childagevalue4lbl.text = item
            self?.room3childagevalue4lbl.textColor = .AppLabelColor
            self?.updateChildAgesArray(index: 0, age: item)
        }
    }
    
    func setupRoom3ChildageTapDropDown5() {
        self.room3childagevalue5lbl.text = "0"
        room3ChildageTapDropDown5.textColor = .AppLabelColor
        room3ChildageTapDropDown5.dataSource = ["1","2","3","4","5","6","7","8","9","10","11"]
        room3ChildageTapDropDown5.direction = .any
        room3ChildageTapDropDown5.backgroundColor = .WhiteColor
        room3ChildageTapDropDown5.anchorView = self.room3childage5View
        room3ChildageTapDropDown5.bottomOffset = CGPoint(x: 0, y: room3childage5View.frame.size.height + 10)
        room3ChildageTapDropDown5.selectionAction = { [weak self] (index: Int, item: String) in
            self?.room3childagevalue5lbl.text = item
            self?.room3childagevalue5lbl.textColor = .AppLabelColor
            self?.updateChildAgesArray(index: 0, age: item)
        }
    }
    
    
    
    
    
    func setupUI1() {
        
        setuplabels(lbl: titlelbl1, text: "Room 1", textcolor: .SubTitleColor, font: .LatoRegular(size: 16), align: .left)
        setuplabels(lbl: adultslbl1, text: "Adult", textcolor: .AppLabelColor, font: .LatoRegular(size: 18), align: .left)
        setuplabels(lbl: adultsSubtitlelbl1, text: "+12 yrs", textcolor: .SubTitleColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: adultsCountlbl1, text: "2", textcolor: .AppLabelColor, font: .LatoRegular(size: 18), align: .center)
        aIncrementBtn1.setTitle("", for: .normal)
        aDecrementBtn1.setTitle("", for: .normal)
        
        setuplabels(lbl: childrenlbl1, text: "Child", textcolor: .AppLabelColor, font: .LatoRegular(size: 18), align: .left)
        setuplabels(lbl: childrenSubtitlelbl1, text: "+2-12 yrs", textcolor: .SubTitleColor, font: .LatoRegular(size: 13), align: .left)
        setuplabels(lbl: childrenCountlbl1, text: "0", textcolor: .AppLabelColor, font: .LatoRegular(size: 18), align: .center)
        cIncrementBtn1.setTitle("", for: .normal)
        cDecrementBtn1.setTitle("", for: .normal)
        
        aIncrementBtn1.addTarget(self, action: #selector(adultsIncrementButtonAction(_:)), for: .touchUpInside)
        aDecrementBtn1.addTarget(self, action: #selector(adultsDecrementBtnAction(_:)), for: .touchUpInside)
        cIncrementBtn1.addTarget(self, action: #selector(childrenIncrementButtonAction(_:)), for: .touchUpInside)
        cDecrementBtn1.addTarget(self, action: #selector(childrenDecrementBtnAction(_:)), for: .touchUpInside)
        
    }
    
    
    func setupUI2() {
        
        setuplabels(lbl: titlelbl2, text: "Room 2", textcolor: .SubTitleColor, font: .LatoRegular(size: 16), align: .left)
        setuplabels(lbl: adultslbl2, text: "Adult", textcolor: .AppLabelColor, font: .LatoRegular(size: 18), align: .left)
        setuplabels(lbl: adultsSubtitlelbl2, text: "+12 yrs", textcolor: .SubTitleColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: adultsCountlbl2, text: "1", textcolor: .AppLabelColor, font: .LatoRegular(size: 18), align: .center)
        aIncrementBtn1.setTitle("", for: .normal)
        aDecrementBtn1.setTitle("", for: .normal)
        
        setuplabels(lbl: childrenlbl2, text: "Child", textcolor: .AppLabelColor, font: .LatoRegular(size: 18), align: .left)
        setuplabels(lbl: childrenSubtitlelbl2, text: "+2-12 yrs", textcolor: .SubTitleColor, font: .LatoRegular(size: 13), align: .left)
        setuplabels(lbl: childrenCountlbl2, text: "0", textcolor: .AppLabelColor, font: .LatoRegular(size: 18), align: .center)
        cIncrementBtn1.setTitle("", for: .normal)
        cDecrementBtn1.setTitle("", for: .normal)
        
        aIncrementBtn2.addTarget(self, action: #selector(adultsIncrementButtonAction2(_:)), for: .touchUpInside)
        aDecrementBtn2.addTarget(self, action: #selector(adultsDecrementBtnAction2(_:)), for: .touchUpInside)
        cIncrementBtn2.addTarget(self, action: #selector(childrenIncrementButtonAction2(_:)), for: .touchUpInside)
        cDecrementBtn2.addTarget(self, action: #selector(childrenDecrementBtnAction2(_:)), for: .touchUpInside)
        
    }
    
    
    func setupUI3() {
        
        setuplabels(lbl: titlelbl3, text: "Room 3", textcolor: .SubTitleColor, font: .LatoRegular(size: 16), align: .left)
        setuplabels(lbl: adultslbl3, text: "Adult", textcolor: .AppLabelColor, font: .LatoRegular(size: 18), align: .left)
        setuplabels(lbl: adultsSubtitlelbl3, text: "+12 yrs", textcolor: .SubTitleColor, font: .LatoRegular(size: 14), align: .left)
        setuplabels(lbl: adultsCountlbl3, text: "1", textcolor: .AppLabelColor, font: .LatoRegular(size: 18), align: .center)
        aIncrementBtn1.setTitle("", for: .normal)
        aDecrementBtn1.setTitle("", for: .normal)
        
        setuplabels(lbl: childrenlbl3, text: "Child", textcolor: .AppLabelColor, font: .LatoRegular(size: 18), align: .left)
        setuplabels(lbl: childrenSubtitlelbl3, text: "+2-12 yrs", textcolor: .SubTitleColor, font: .LatoRegular(size: 13), align: .left)
        setuplabels(lbl: childrenCountlbl3, text: "0", textcolor: .AppLabelColor, font: .LatoRegular(size: 18), align: .center)
        cIncrementBtn1.setTitle("", for: .normal)
        cDecrementBtn1.setTitle("", for: .normal)
        
        aIncrementBtn3.addTarget(self, action: #selector(adultsIncrementButtonAction3(_:)), for: .touchUpInside)
        aDecrementBtn3.addTarget(self, action: #selector(adultsDecrementBtnAction3(_:)), for: .touchUpInside)
        cIncrementBtn3.addTarget(self, action: #selector(childrenIncrementButtonAction3(_:)), for: .touchUpInside)
        cDecrementBtn3.addTarget(self, action: #selector(childrenDecrementBtnAction3(_:)), for: .touchUpInside)
        
    }
    
    
    
    @objc func didTapOnCloseRoom(_ sender:UIButton) {
        
        roomCount -= 1
        addRoomBtnView.isHidden = false
        switch sender.tag {
        case 2:
            roomView1.isHidden = false
            roomView2.isHidden = true
            roomView3.isHidden = true
            
            room2CloseView.isHidden = true
            room3CloseView.isHidden = true
            //     room4CloseView.isHidden = true
            break
            
        case 3:
            roomView1.isHidden = false
            roomView2.isHidden = false
            roomView3.isHidden = true
            //      roomView4.isHidden = true
            
            room2CloseView.isHidden = false
            room3CloseView.isHidden = true
            //      room4CloseView.isHidden = true
            
            break
            
        case 4:
            roomView1.isHidden = false
            roomView2.isHidden = false
            roomView3.isHidden = false
            //       roomView4.isHidden = true
            
            room2CloseView.isHidden = true
            room3CloseView.isHidden = false
            //      room4CloseView.isHidden = true
            
            break
        default:
            break
        }
        
        delegate?.didTapOnCloseRoom(cell: self)
    }
    
    
    @IBAction func didTapOnAddRoomBtnAction(_ sender: Any) {
        self.roomCount += 1
        
        if self.roomCount > 3 {
            self.addRoomBtn.isHidden = true
        }else {
            
            switch self.roomCount {
            case 2:
                
                
                self.roomView1.isHidden = false
                self.roomView2.isHidden = false
                self.roomView3.isHidden = true
                //      self.roomView4.isHidden = true
                
                room2CloseView.isHidden = false
                room3CloseView.isHidden = true
                //        room4CloseView.isHidden = true
                
                adultcount2 = 1
                adultsCountlbl2.text = "1"
                childrenCountlbl2.text = "0"
                childCount2 = 0
                
                r2childage1View.isHidden = true
                r2childage2View.isHidden = true
                room2childage3View.isHidden = true
                room2childage4View.isHidden = true
                room2childage5View.isHidden = true
               
                r3childage1View.isHidden = true
                r3childage2View.isHidden = true
                room3childage3View.isHidden = true
                room3childage4View.isHidden = true
                room3childage5View.isHidden = true
                
                break
                
            case 3:
                self.roomView1.isHidden = false
                self.roomView2.isHidden = false
                self.roomView3.isHidden = false
                //    self.roomView4.isHidden = true
                
                room2CloseView.isHidden = true
                room3CloseView.isHidden = false
                //   room4CloseView.isHidden = true
                
                adultcount3 = 1
                childCount3 = 0
                adultsCountlbl3.text = "1"
                childrenCountlbl3.text = "0"
                
              
                
              
                r3childage1View.isHidden = true
                r3childage2View.isHidden = true
                room3childage3View.isHidden = true
                room3childage4View.isHidden = true
                room3childage5View.isHidden = true
                self.addRoomBtnView.isHidden = true
                //                r4childage1View.isHidden = true
                //                r4childage2View.isHidden = true
                break
                
                
                //                room2CloseView.isHidden = true
                //                room3CloseView.isHidden = true
                
                
                
            default:
                break
            }
            
        }
        
        delegate?.didTapOnAddRoomBtnAction(cell: self)
    }
    
    
    //====room 1
    @objc func adultsIncrementButtonAction(_ sender:UIButton){
        delegate?.adultsIncrementButtonAction(cell: self)
    }
    
    @objc func adultsDecrementBtnAction(_ sender:UIButton){
        delegate?.adultsDecrementBtnAction(cell: self)
    }
    
    @objc func childrenIncrementButtonAction(_ sender:UIButton){
        delegate?.childrenIncrementButtonAction(cell: self)
    }
    
    @objc func childrenDecrementBtnAction(_ sender:UIButton){
        delegate?.childrenDecrementBtnAction(cell: self)
    }
    
    
    
    
    //====room 2
    @objc func adultsIncrementButtonAction2(_ sender:UIButton){
        delegate?.adultsIncrementButtonAction2(cell: self)
    }
    
    @objc func adultsDecrementBtnAction2(_ sender:UIButton){
        delegate?.adultsDecrementBtnAction2(cell: self)
    }
    
    @objc func childrenIncrementButtonAction2(_ sender:UIButton){
        delegate?.childrenIncrementButtonAction2(cell: self)
    }
    
    @objc func childrenDecrementBtnAction2(_ sender:UIButton){
        delegate?.childrenDecrementBtnAction2(cell: self)
    }
    
    
    //====room 3
    
    @objc func adultsIncrementButtonAction3(_ sender:UIButton){
        delegate?.adultsIncrementButtonAction3(cell: self)
    }
    
    @objc func adultsDecrementBtnAction3(_ sender:UIButton){
        delegate?.adultsDecrementBtnAction3(cell: self)
    }
    
    @objc func childrenIncrementButtonAction3(_ sender:UIButton){
        delegate?.childrenIncrementButtonAction3(cell: self)
    }
    
    @objc func childrenDecrementBtnAction3(_ sender:UIButton){
        delegate?.childrenDecrementBtnAction3(cell: self)
    }
    
    
    
    
    
}
