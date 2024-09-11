//
//  MapLocationViewModel.swift
//  HolidaysCenter
//
//  Created by Admin on 30/08/24.
//

import Foundation


protocol MapLocationViewModelDelegate : BaseViewModelProtocol {
    func locationsResponse(response:[MapLocationModel])
}

class MapLocationViewModel {
    
    var view: MapLocationViewModelDelegate!
    init(_ view: MapLocationViewModelDelegate) {
        self.view = view
    }
    
    
    //MARK:  Get voucher Details API
    func CALL_GET_MAP_LOCATIONS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_all_map_location,parameters: parms ,resultType: [MapLocationModel].self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.locationsResponse(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    
}
