//
//  ViewFlightDetailsVC.swift
//  QBBYTravelApp
//
//  Created by FCI on 19/04/23.
//

import UIKit

class ViewFlightDetailsVC: BaseTableVC, FlightDetailsViewModelDelegate, TimerManagerDelegate {
    
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    
    static var newInstance: ViewFlightDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ViewFlightDetailsVC
        return vc
    }
    
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var vm:FlightDetailsViewModel?
    
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: false)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        DispatchQueue.main.async {[self] in
            setupItineraryTVCells()
        }
        
        TimerManager.shared.delegate = self
    }
    
    
    func timerDidFinish() {
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    func updateTimer() {
        
    }
    
    func callAPI() {
        payload.removeAll()
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        payload["booking_source"] = bookingsource
        payload["access_key"] = accesskey
        payload["search_id"] = searchid
        vm?.CALL_GET_FLIGHT_DETAILS_API(dictParam: payload)
    }
    
    
    
    func flightDetails(response: FlightDetailsModel) {
        fd = response.flightDetails ?? [[]]
        DispatchQueue.main.async {[self] in
            holderView.isHidden = false
            setupUI()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        vm = FlightDetailsViewModel(self)
    }
    
    
    func setupUI() {
        
        self.holderView.backgroundColor = .AppHolderViewColor
        nav.titlelbl.text = "Flight Details"
        nav.backBtn.addTarget(self, action: #selector(gotoBackScreen), for: .touchUpInside)
        if screenHeight > 835 {
            navHeight.constant = 130
        }else {
            navHeight.constant = 110
        }
        commonTableView.backgroundColor = .AppHolderViewColor
        commonTableView.registerTVCells(["AddItineraryTVCell",
                                         "EmptyTVCell"])
    }
    
    
    @objc func gotoBackScreen() {
        callapibool = true
        isvcfrom1 = "PayNowVC"
        dismiss(animated: true)
    }
    
    func setupItineraryTVCells() {
        tablerow.removeAll()
        tablerow.append(TableRow(height:40,bgColor: .AppHolderViewColor,cellType:.EmptyTVCell))
        fd.forEach { i in
            tablerow.append(TableRow(moreData:i,cellType:.AddItineraryTVCell))
        }
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @IBAction func didTapOnCloseBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
}
