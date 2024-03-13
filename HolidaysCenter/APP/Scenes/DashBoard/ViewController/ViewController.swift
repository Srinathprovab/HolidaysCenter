//
//  ViewController.swift
//  BeeoonsApp
//
//  Created by MA673 on 12/08/22.
//

import UIKit




class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        executeOnce()
        
    }
    
    
    func gotodashBoardScreen() {
        guard let vc = DBTabbarController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        callapibool = true
        present(vc, animated: true)
    }
    
    func gotoLoginVC() {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        vc.isvcfrom = "ViewController"
        present(vc, animated: true)
    }
    
    
    func gotoBookingConfirmedVC(url:String) {
        TimerManager.shared.sessionStop()
        guard let vc = BookingCFVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.vocherurl = url
        callapibool = true
        present(vc, animated: true)
    }
    
}

extension ViewController {
    
    func executeOnce() {
        
        if !UserDefaults.standard.bool(forKey: "ExecuteOnceLoginVC") {
            ExecuteOnceBool = false
            self.getCountryList()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                self.gotoLoginVC()
            })
            
            UserDefaults.standard.set(true, forKey: "ExecuteOnceLoginVC")
        }
        
        
        if ExecuteOnceBool == true {
            
            getCountryList()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                
                self.gotodashBoardScreen()
                
                //                defaults.set("Hotel", forKey: UserDefaultsKeys.tabselect)
                //                self.gotoBookingConfirmedVC(url: "\(BASE_URL1)voucher/hotel/HOC-H-HB-11032024-0617-5528/PTBSID0000000044/BOOKING_CONFIRMED/show_voucher/1EV")
                
                
                //                                defaults.set("Flight", forKey: UserDefaultsKeys.tabselect)
                //                                self.gotoBookingConfirmedVC(url: "\(BASE_URL1)voucher/flight/HDC-F-TP-1204-3475/PTBSID0000000016/BOOKING_CONFIRMED/show_voucher/1EV")
                
                
            })
        }
        
        
        if !UserDefaults.standard.bool(forKey: "ExecuteOnce") {
            
            defaults.set("+61", forKey: UserDefaultsKeys.mobilecountrycode)
            
            defaults.set("Flight", forKey: UserDefaultsKeys.tabselect)
            defaults.set("oneway", forKey: UserDefaultsKeys.journeyType)
            defaults.set("USD", forKey: UserDefaultsKeys.selectedCurrency)
            defaults.set("USD", forKey: UserDefaultsKeys.selectedCurrencyType)
            defaults.set("https://holidayscenter.com/extras/system/template_list/template_v1/images/flag/USD.png", forKey: UserDefaultsKeys.selectedCurrencyImg)
            
            defaults.set("", forKey: UserDefaultsKeys.fromCity)
            defaults.set("", forKey: UserDefaultsKeys.toCity)
            defaults.set("", forKey: UserDefaultsKeys.calDepDate)
            // defaults.set("", forKey: UserDefaultsKeys.calRetDate)
            
            
            defaults.set("Economy", forKey: UserDefaultsKeys.selectClass)
            defaults.set("1", forKey: UserDefaultsKeys.adultCount)
            defaults.set("0", forKey: UserDefaultsKeys.childCount)
            defaults.set("0", forKey: UserDefaultsKeys.infantsCount)
            defaults.set("1", forKey: UserDefaultsKeys.totalTravellerCount)
            
            let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1") Traveller - \(defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "Economy")"
            defaults.set(totaltraverlers, forKey: UserDefaultsKeys.travellerDetails)
            
            
            defaults.set("1", forKey: UserDefaultsKeys.madultCount)
            defaults.set("0", forKey: UserDefaultsKeys.mchildCount)
            defaults.set("0", forKey: UserDefaultsKeys.minfantsCount)
            defaults.set("1", forKey: UserDefaultsKeys.totalTravellerCount)
            let totaltraverlers3 = "\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1") Traveller - \(defaults.string(forKey: UserDefaultsKeys.mselectClass) ?? "Economy")"
            defaults.set(totaltraverlers3, forKey: UserDefaultsKeys.mtravellerDetails)
            
            
            UserDefaults.standard.set(true, forKey: "ExecuteOnce")
        }
    }
}
