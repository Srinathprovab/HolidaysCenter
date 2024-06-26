//
//  SelectLanguageVC.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit

class SelectLanguageVC: BaseTableVC, SelectCurrencyViewModelDelgate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var langView: UIView!
    @IBOutlet weak var langlbl: UILabel!
    @IBOutlet weak var langUL: UIView!
    @IBOutlet weak var langBtn: UIButton!
    @IBOutlet weak var currencyView: UIView!
    @IBOutlet weak var currencylbl: UILabel!
    @IBOutlet weak var currencyUL: UIView!
    @IBOutlet weak var currencBtn: UIButton!
    
    
    static var newInstance: SelectLanguageVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectLanguageVC
        return vc
    }
    var tablerow = [TableRow]()
    var vm:SelectCurrencyViewModel?
    
    
    @objc func offline(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: false)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
//        callApi()
        
        getCurrencyList()
    }
    
    func callApi() {
      //  vm?.CALL_GET_CURRENCY_LIST_API(dictParam: [:])
    }
    
    
    
    func currencyList(response: SelectCurrencyModel) {
      //  clist = response.data ?? []
        DispatchQueue.main.async {[self] in
            setupCurencyTVCell()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        setupUI()
    //    vm = SelectCurrencyViewModel(self)
        
    }
    
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        //        v.layer.borderWidth = 0
        //        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    func setupUI() {
        
        setupViews(v: holderView, radius: 10, color: .WhiteColor)
        setupViews(v: langView, radius: 3, color: .WhiteColor)
        setupViews(v: currencyView, radius: 3, color: .WhiteColor)
        setupViews(v: langUL, radius: 0, color: .AppNavBackColor)
        setupViews(v: currencyUL, radius: 0, color: .WhiteColor)
        
       // setupLabels(lbl: titlelbl, text: "Select Language /Currency", textcolor: .AppLabelColor, font: .LatoRegular(size: 18))
        setupLabels(lbl: titlelbl, text: "Select Currency", textcolor: .AppLabelColor, font: .LatoRegular(size: 18))
        setupLabels(lbl: langlbl, text: "Currency", textcolor: .AppLabelColor, font: .LatoRegular(size: 16))
        setupLabels(lbl: currencylbl, text: "Currency", textcolor: .SubTitleColor, font: .LatoRegular(size: 16))
        
        langBtn.setTitle("", for: .normal)
        currencBtn.setTitle("", for: .normal)
        closeBtn.setTitle("", for: .normal)
        
        currencyView.isHidden = true
        commonTableView.registerTVCells(["SelectLanguageTVCell",
                                        "EmptyTVCell"])
        
    }
    
    
    func setuplanguageTVCell() {
        tablerow.removeAll()
        tablerow.append(TableRow(title:"English",subTitle: "",key:"lang",image: "english",cellType: .SelectLanguageTVCell))
        tablerow.append(TableRow(title:"Arabic",subTitle: "",key:"lang",image: "arabic",cellType: .SelectLanguageTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    func setupCurencyTVCell() {
        tablerow.removeAll()
        
        currencyListArray.forEach { i in
            tablerow.append(TableRow(title:"\(i.name ?? "")",
                                     subTitle: "\(i.symbol ?? "")",
                                     key:"lang1",
                                     text:  i.type,
                                     image: i.icon,
                                     cellType: .SelectLanguageTVCell))
            
        }
        
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    @IBAction func closeBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func didTapOnLanguageBtn(_ sender: Any) {
        //        langlbl.textColor = .AppBtnColor
        //        langUL.backgroundColor = .AppBtnColor
        //
        //        currencylbl.textColor = .AppLabelColor
        //        currencyUL.backgroundColor = .WhiteColor
        //
        //        setuplanguageTVCell()
        
        langlbl.textColor = .AppLabelColor
        langUL.backgroundColor = .WhiteColor
        
        currencylbl.textColor = .AppNavBackColor
        currencyUL.backgroundColor = .AppNavBackColor
        setupCurencyTVCell()
    }
    
    
    @IBAction func didTapOncurrencBtn(_ sender: Any) {
        langlbl.textColor = .AppLabelColor
        langUL.backgroundColor = .WhiteColor
        
        currencylbl.textColor = .AppNavBackColor
        currencyUL.backgroundColor = .AppNavBackColor
        setupCurencyTVCell()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SelectLanguageTVCell {
            cell.selected()
            defaults.set(cell.subTitlelbl.text, forKey: UserDefaultsKeys.selectedCurrency)
            defaults.set(cell.type, forKey: UserDefaultsKeys.selectedCurrencyType)
            defaults.set(cell.logoimg, forKey: UserDefaultsKeys.selectedCurrencyImg)
            NotificationCenter.default.post(name: NSNotification.Name("selectedCurrency"), object: nil)
            dismiss(animated: true)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SelectLanguageTVCell {
            cell.unselected()
        }
    }
    
    
    
    func getCurrencyList() {
        
        // Get the path to the clist.json file in the Xcode project
        if let jsonFilePath = Bundle.main.path(forResource: "currencylist", ofType: "json") {
            do {
                // Read the data from the file
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonFilePath))
                
                // Decode the JSON data into a dictionary
                let jsonDictionary = try JSONDecoder().decode([String: [SelectCurrencyData]].self, from: jsonData)
                
                // Access the array of currency using the "data" key
                if let currencyList = jsonDictionary["data"] {
                    currencyListArray = currencyList
                    DispatchQueue.main.async {[self] in
                        setupCurencyTVCell()
                    }
                } else {
                    print("Unable to find 'data' key in the JSON dictionary.")
                }
                
                
            } catch let error {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("Unable to find clist.json in the Xcode project.")
        }
        
    }
    
}
