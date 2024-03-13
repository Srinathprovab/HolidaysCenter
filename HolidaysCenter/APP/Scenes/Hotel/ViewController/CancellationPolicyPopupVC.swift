//
//  CancellationPolicyPopupVC.swift
//  KuwaitWays
//
//  Created by FCI on 09/06/23.
//

import UIKit

class CancellationPolicyPopupVC: UIViewController, GetCancellationViewModelDelegate {
    
    @IBOutlet weak var valuelbl: UILabel!
    
    static var newInstance: CancellationPolicyPopupVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? CancellationPolicyPopupVC
        return vc
    }
    
    var amount = String()
    var vm:GetCancellationViewModel?
    var payload = [String:Any]()
    override func viewWillAppear(_ animated: Bool) {
       
        valuelbl.text = ""
        
        if hbooking_source == "PTBSID0000000044" {
            callGetCancellationAPI()
        }else {
            valuelbl.text = amount
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black.withAlphaComponent(0.50)
        vm = GetCancellationViewModel(self)
        
    }
    
    @IBAction func didTapOnCloseBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
   
}

extension CancellationPolicyPopupVC {

    func callGetCancellationAPI() {
        payload.removeAll()
        
        payload["search_id"] = hsearch_id
        payload["rateplancode"] = rateplanecode
        payload["checkin"] = defaults.string(forKey: UserDefaultsKeys.checkin)
        payload["checkout"] = defaults.string(forKey: UserDefaultsKeys.checkout)
        payload["hotel_code"] = hotelcode
        
        vm?.CALL_GET_CANCELLATION_API(dictParam: payload)
    }
    
    func cancellationDetails(response: GetCancellationModel) {
        response.data?.forEach({ i in
            valuelbl.text! += "\(i)\n"
        })
    }
    

}
