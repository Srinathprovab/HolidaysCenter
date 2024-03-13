//
//  ContactusViewModel.swift
//  HolidaysCenter
//
//  Created by FCI on 02/11/23.
//

import Foundation


protocol ContactusViewModelDelegate : BaseViewModelProtocol {
    func contactusResponse(response : ContactusModel)
    func cruiseContactusResponse(response : CursiModel)
}

class ContactusViewModel {
    
    var view: ContactusViewModelDelegate!
    init(_ view: ContactusViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_CONTACT_US_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_contactus_email, parameters: parms, resultType: ContactusModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.contactusResponse(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    func CALL_CONTACT_CRUISE_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_mobile_cruise_enquiry, parameters: parms, resultType: CursiModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.cruiseContactusResponse(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
