//
//  SecureBookingViewMOdel.swift
//  HolidaysCenter
//
//  Created by FCI on 05/08/23.
//

import Foundation






protocol SecureBookingViewMOdelDelegate : BaseViewModelProtocol {
    func secureBookingDetails(response : sendToPaymentModel)
    func paymentSucess(response : sendToPaymentModel)
}

class SecureBookingViewMOdel {
    
    var view: SecureBookingViewMOdelDelegate!
    init(_ view: SecureBookingViewMOdelDelegate) {
        self.view = view
    }
    
    
    
    
    func CALL_HOTEL_PAYMENT_SUCESS_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: url,parameters: parms, resultType: sendToPaymentModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.paymentSucess(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    func CALL_SECURE_BOOKING_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: url,parameters: parms, resultType: sendToPaymentModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.secureBookingDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
}
