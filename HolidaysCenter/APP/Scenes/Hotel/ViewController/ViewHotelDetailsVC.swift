//
//  ViewHotelDetailsVC.swift
//  KuwaitWays
//
//  Created by FCI on 04/05/23.
//

import UIKit

class ViewHotelDetailsVC: BaseTableVC, HotelDetailsViewModelDelegate {
    
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    
    var kwdprice = String()
    var isVcFrom = String()
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var vm:HotelDetailsViewModel?
    
    
    static var newInstance: ViewHotelDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ViewHotelDetailsVC
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
        if callapibool == true {
            //            holderView.isHidden = true
            //callAPI()
            self.setupTVCells(hotelDetails: hd!)
        }
    }
    
    func callAPI() {
        payload["booking_source"] = hbooking_source
        payload["hotel_id"] = hotelid
        payload["search_id"] = hsearch_id
        vm?.CALL_GET_HOTEL_DETAILS_API(dictParam: payload)
    }
    
    
    func hotelDetails(response: HotelDetailsModel) {
        print(" ====== hotelDetails ====== ")
        holderView.isHidden = false
        //        titlelbl.text = "\(response.currency_obj?.to_currency ?? "") \(response.currency_obj?.conversion_rate ?? "")"
        //        htoken = response.hotel_details?.token ?? ""
        //        htokenkey = response.hotel_details?.tokenKey ?? ""
        
        DispatchQueue.main.async {
            self.setupTVCells(hotelDetails: response)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        vm = HotelDetailsViewModel(self)
    }
    
    func setupUI() {
        
        self.view.backgroundColor = .WhiteColor
        self.holderView.backgroundColor = .AppHolderViewColor
        nav.titlelbl.text = "Hotel Details"
        nav.backBtn.addTarget(self, action: #selector(backbtnAction(_:)), for: .touchUpInside)
        
        
        if screenHeight > 835 {
            navHeight.constant = 130
        }else {
            navHeight.constant = 110
        }
        
        
        
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "HotelSearchResultTVCell",
                                         "RatingWithLabelsTVCell",
                                         "FacilitiesTVCell",
                                         "HotelImagesTVCell",
                                         "RoomsTVCell"])
        
        
    }
    
    
    @objc func backbtnAction(_ sender:UIButton) {
        isFromVCBool = false
        dismiss(animated: true)
    }
    
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.2
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    
    override func didTapOnCancellationPolicyBtn(cell: TwinSuperiorRoomTVCell) {
        
    }
    
    
    override func didTapOnRoomTvcell(cell:TwinSuperiorRoomTVCell) {
        //        ratekeyArray.removeAll()
        //        ratekeyArray.append(cell.ratekey)
    }
    
    //    @objc func didTapOnBookNowBtn(_ sender:UIButton) {
    //        guard let vc = PayNowVC.newInstance.self else {return}
    //        vc.modalPresentationStyle = .fullScreen
    //        isFromVCBool = true
    //        self.present(vc, animated: false)
    //
    //    }
    //
    
}



extension ViewHotelDetailsVC {
    
    func setupTVCells(hotelDetails:HotelDetailsModel) {
        tablerow.removeAll()
        
        
        
        
        tablerow.append(TableRow(title:hotelDetails.hotel_details?.name,
                                 subTitle: hotelDetails.hotel_details?.address,
                                 key: "rating",
                                 characterLimit: Int(hotelDetails.hotel_details?.star_rating ?? "0"),
                                 cellType:.RatingWithLabelsTVCell))
        
        
        tablerow.append(TableRow(height:20,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
        
        
        
        
        tablerow.append(TableRow(title:hotelDetails.hotel_details?.hotel_desc ?? "",
                                 image:hotelDetails.hotel_details?.image,
                                 moreData: hotelDetails.hotel_details?.images,
                                 cellType:.HotelImagesTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
}
