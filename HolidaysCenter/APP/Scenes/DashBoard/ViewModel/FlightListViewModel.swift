//
//  FlightListViewModel.swift
//  KuwaitWays
//
//  Created by FCI on 24/04/23.
//

import Foundation



protocol FlightListViewModelDelegate : BaseViewModelProtocol {
    func flightList(response : FlightListModel)
    func multicityAirlinelist(response : MulticityModel)

}

class FlightListViewModel {
    
    var view: FlightListViewModelDelegate!
    init(_ view: FlightListViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_GET_FLIGHT_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.mobilepreflightsearch,urlParams: parms as? Dictionary<String, String> , parameters: parms, resultType: FlightListModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.flightList(response: response)
                } else {
                    // Show alert
                    NotificationCenter.default.post(name: NSNotification.Name("nointernet"), object: errorMessage)
                    //  print("error === \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    

    func CALL_GET_AIRLINE_MULTICITY_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
          self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.mobilepreflightsearch , urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: MulticityModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                   self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.multicityAirlinelist(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
}
