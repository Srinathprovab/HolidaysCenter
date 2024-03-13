//
//  GetCancellationViewModel.swift
//  HolidaysCenterApp
//
//  Created by FCI on 11/03/24.
//

import Foundation

protocol GetCancellationViewModelDelegate : BaseViewModelProtocol {
    func cancellationDetails(response:GetCancellationModel)
}

class GetCancellationViewModel {
    
    var view: GetCancellationViewModelDelegate!
    init(_ view: GetCancellationViewModelDelegate) {
        self.view = view
    }
    
    
    //MARK:  Get voucher Details API
    func CALL_GET_CANCELLATION_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
       // self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.hotel_get_Cancellation_new,parameters: parms ,resultType: GetCancellationModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
             //   self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.cancellationDetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    
}
