//
//  noInternetConnectionVC.swift
//  BabSafar
//
//  Created by MA673 on 08/08/22.
//

import UIKit

class NoInternetConnectionVC: UIViewController {
    
    
    @IBOutlet weak var wifiImg: UIImageView!
    @IBOutlet weak var closeImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subTitlelbl: UILabel!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var btnlbl: UILabel!
    @IBOutlet weak var tryAgainBtn: UIButton!
    
    
    var key = ""
    static var newInstance: NoInternetConnectionVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? NoInternetConnectionVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if key == "noseat" {
            noseatsSetup()
        }else if key == "noresult" {
            noresultSetup()
        }else {
            setupUI()
        }
    }
    
    func noresultSetup(){
        wifiImg.image = UIImage(named: "oops")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
        setupLabels(lbl: titlelbl, text: "NO AVAILABILITY FOR THIS REQUEST", textcolor: .AppLabelColor, font: .LatoMedium(size: 18))
        setupLabels(lbl: subTitlelbl, text: "Please Search Again", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: btnlbl, text: "Search Again", textcolor: .BtnTitleColor, font: .LatoSemibold(size: 20))
    }
    
    
    func noseatsSetup(){
        wifiImg.image = UIImage(named: "oops")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
        setupLabels(lbl: titlelbl, text: "Booking Failed Please Contact Kuwatways Customer Service", textcolor: .AppLabelColor, font: .LatoMedium(size: 18))
        setupLabels(lbl: subTitlelbl, text: "Please Search Again", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: btnlbl, text: "Search Again", textcolor: .BtnTitleColor, font: .LatoSemibold(size: 20))
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        wifiImg.image = UIImage(named: "wifi")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
        closeImg.image = UIImage(named: "close1")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppImgColor)
        
        setupLabels(lbl: titlelbl, text: "No Internet Connection", textcolor: .AppLabelColor, font: .LatoMedium(size: 18))
        setupLabels(lbl: subTitlelbl, text: "Please Check Your Internet Connection", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: btnlbl, text: "Try Again", textcolor: .BtnTitleColor, font: .LatoSemibold(size: 20))
        tryAgainBtn.setTitle("", for: .normal)
        setupViews(v: btnView, radius: 4, color: .AppNavBackColor)
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.clear.cgColor
    }
    
    @IBAction func didTapOnTryAgainBtn(_ sender: Any) {
        
        TimerManager.shared.stopTimer()
        
        if key == "noresult" {
            
            if let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect),tabselect == "Flight" {
                gotoBookFlightVC()
            }else {
                gotoBookHotelVC()
            }
            
        }else if key == "noseat" {
            if let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect),tabselect == "Flight" {
                // searchFlightAgain()
                gotoBookFlightVC()
            }else {
                
            }
        }else {
            NotificationCenter.default.post(name: NSNotification.Name("reloadTV"), object: nil)
            dismiss(animated: false)
        }
    }
    
    
    
    func gotoBookFlightVC() {
        guard let vc = BookFlightVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    
    func gotoBookHotelVC() {
        guard let vc = BookHotelVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    
}


