//
//  WhatsappVC.swift
//  HolidaysCenter
//
//  Created by FCI on 29/03/24.
//

import UIKit

class WhatsappVC: UIViewController {
    
    
    let phoneNumber = "+61437214457"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
     //   openWhatsAppFromLink()
      // openWhatsApp()
        
        let alert = UIAlertController(title: "WhatsApp Account Found", message: "Would you like to continue to chat with \(phoneNumber)?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            self.openWhatsApp(with: self.phoneNumber)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            self.gotodashBoardScreen()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    
     func openWhatsApp() {
           // Replace with the phone number you want to open chat with
           
           // Check if WhatsApp is installed
           guard let whatsappURL = URL(string: "whatsapp://send?phone=\(phoneNumber)") else {
               return
           }

           if UIApplication.shared.canOpenURL(whatsappURL) {
               // Open WhatsApp with the specified phone number
               UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
           } else {
               // WhatsApp is not installed, handle accordingly (e.g., show alert)
               print("WhatsApp is not installed.")
           }
       }
    
    
    
    func openWhatsApp(with phoneNumber: String) {
        // Check if WhatsApp is installed
        guard let whatsappURL = URL(string: "whatsapp://send?phone=\(phoneNumber)") else {
            return
        }
        
        if UIApplication.shared.canOpenURL(whatsappURL) {
            // Open WhatsApp with the specified phone number
            UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
        } else {
            // WhatsApp is not installed, handle accordingly (e.g., show alert)
            print("WhatsApp is not installed.")
            showToast(message: "WhatsApp is not installed.")
        }
    }
    
    
    
    func gotodashBoardScreen() {
        guard let vc = DBTabbarController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        callapibool = true
        present(vc, animated: false)
    }
    
    
    
}
