//
//  HotelNameSearchVM.swift
//  HolidaysCenter
//
//  Created by FCI on 07/05/24.
//

import Foundation
protocol HotelNameSearchVMDelegatr : BaseViewModelProtocol {
    func hotelNameSearchDetails(response:HotelListModel)
}

class HotelNameSearchVM {
    
    var view: HotelNameSearchVMDelegatr!
    init(_ view: HotelNameSearchVMDelegatr) {
        self.view = view
    }
    
    
    //MARK:  Get voucher Details API
    func CALL_GET_HOTEL_NAME_SEARCH_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
     //   self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_search_by_hotel,urlParams: parms as? Dictionary<String, String>,parameters: parms ,resultType: HotelListModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
             //   self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.hotelNameSearchDetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    
}
