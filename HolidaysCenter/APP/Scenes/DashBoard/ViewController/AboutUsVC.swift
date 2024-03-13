//
//  AboutUsVC.swift
//  QBBYTravelApp
//
//  Created by FCI on 05/04/23.
//

import UIKit

class AboutUsVC: BaseTableVC,AboutusViewModelDelegate {
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var holderView: UIView!
    
    static var newInstance: AboutUsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? AboutUsVC
        return vc
    }
    var tablerow = [TableRow]()
    var page_title = String()
    var page_description = String()
    var keystr = String()
    var vm:AboutusViewModel?
    
    override func viewWillDisappear(_ animated: Bool) {
        isFromVCBool = false
        BASE_URL = BASE_URL1
    }
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: false)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        callAPI()
    }
    
    func callAPI() {
        BASE_URL = ""
        switch keystr {
            
        case "aboutus":
            vm?.CALL_ABOUTUS_API(dictParam: [:], url: "\(BASE_URL1)general/cms/1")
            break
            
            
        case "terms":
            vm?.CALL_ABOUTUS_API(dictParam: [:], url: "\(BASE_URL1)general/cms/3")
            break
            
        case "pp":
            vm?.CALL_ABOUTUS_API(dictParam: [:], url: "\(BASE_URL1)general/cms/2")
            break
            
        default:
            break
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = AboutusViewModel(self)
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .AppHolderViewColor
        nav.backBtn.addTarget(self, action: #selector(backBtnAction(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["AboutustitleTVCell",
                                         "EmptyTVCell"])
        commonTableView.isScrollEnabled = true
    }
    
    
    @IBAction func gotoBackBtnAction(_ sender: Any) {
        isFromVCBool = false
        dismiss(animated: true)
    }
    
    
    func aboutusDetails(response: AboutusModel) {
        
        self.page_description = response.data?[0].page_description ?? ""
        
        setuplabels(lbl: nav.titlelbl, text: response.data?[0].page_title ?? "", textcolor: .BtnTitleColor, font: .LatoSemibold(size: 18), align: .center)
        
        DispatchQueue.main.async {[self] in
            setupTVCells()
        }
    }
    
    
    func setupTVCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:self.page_description,cellType:.AboutustitleTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    @objc func backBtnAction(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    
}

