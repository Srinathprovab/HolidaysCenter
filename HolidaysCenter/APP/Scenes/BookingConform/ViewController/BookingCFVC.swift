//
//  BookingCFVC.swift
//  HolidaysCenter
//
//  Created by FCI on 16/06/23.
//

import UIKit

class BookingCFVC: BaseTableVC {
    
    
    @IBOutlet weak var titlelbl: UILabel!
    
    
    static var newInstance: BookingCFVC? {
        let storyboard = UIStoryboard(name: Storyboard.BookingConform.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookingCFVC
        return vc
    }
    var viewmodel:VocherDetailsViewModel?
    var vocherurl = String()
    var tablerow = [TableRow]()
    var status = String()
    var vocherpdf = String()
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        viewmodel = VocherDetailsViewModel(self)
        setupUI()
        
       
    }
    
    func setupUI(){
        commonTableView.backgroundColor = .AppBGcolor
        commonTableView.registerTVCells(["BookingCFTVCell",
                                         "EmptyTVCell",
                                         "BookedTravelDetailsTVCell",
                                         "BCHotelDetailsTVCell",
                                         "DownloadBtnTVCell"])
    }
    
    
  
    
  
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        gotodashBoardScreen()
    }
    
    
    func gotodashBoardScreen() {
        BASE_URL = BASE_URL1
        guard let vc = DBTabbarController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        callapibool = true
        present(vc, animated: true)
    }
    
    
    override func didTapOnDownloadPDFBtnAction(cell: DownloadBtnTVCell) {
         
        
        
        if let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            if tabselect == "Flight" {
                vocherpdf = "\(BASE_URL1)voucher/flight/\(bookingRefrence)/\(bookingsource)/\(status)/show_pdf"
            }else {
                vocherpdf = "\(BASE_URL1)voucher/hotel/\(bookingRefrence)/\(bookingsource)/\(status)/show_pdf"
            }
        }
        
        
        downloadAndSavePDF(showpdfurl: vocherpdf)
        
        
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.gotoAboutUsVC(title: "Vocher Details", url: self.vocherpdf)
        }
    }
    
    
    func gotoAboutUsVC(title:String,url:String) {
        guard let vc = LoadWebViewVC.newInstance.self else {return}
        vc.urlString = url
        vc.isVcFrom = "voucher"
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        self.present(vc, animated: true)
        
    }
    
    
    
}



extension BookingCFVC {
    
    
    
    // Function to download and save the PDF
    func downloadAndSavePDF(showpdfurl:String) {
        let urlString = showpdfurl
        
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Download Error: \(error.localizedDescription)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Invalid Response: \(response.debugDescription)")
                    return
                }
                
                if let pdfData = data {
                    self.savePdfToDocumentDirectory(pdfData: pdfData, fileName: "\(Date())")
                }
            }
            task.resume()
        } else {
            print("Invalid URL: \(urlString)")
        }
    }
    
    // Function to save PDF data to the app's document directory
    func savePdfToDocumentDirectory(pdfData: Data, fileName: String) {
        do {
            let resourceDocPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
            let pdfName = "HolidayCenters-\(fileName).pdf"
            let destinationURL = resourceDocPath.appendingPathComponent(pdfName)
            try pdfData.write(to: destinationURL)
            
            
        } catch {
            print("Error saving PDF to Document Directory: \(error)")
        }
    }
    
    
    
}



extension BookingCFVC:VocherDetailsViewModelDelegate{
   
    
    
    func callAPI() {
        BASE_URL = ""
        DispatchQueue.main.async {[self] in
            viewmodel?.CALL_GET_VOUCHER_DETAILS_API(dictParam: [:], url: vocherurl)
        }
    }
    
    
    func vocherdetails(response: VocherModel) {
        BASE_URL = BASE_URL1
        
        titlelbl.text = "You Have Booked Your Flight Successfully"
        voucherSummery = response.flight_details?.summary ?? []
        voucherCustomerDetails = response.data?.booking_details?[0].customer_details ?? []
        voucherCurrency = response.price?.api_currency ?? ""
        voucherPrice = String(format: "%.2f", response.price?.api_total_display_fare ?? 0.0)
        bookingRefrence = response.data?.booking_details?[0].app_reference ?? ""
        status = response.data?.booking_details?[0].booking_transaction_details?[0].status ?? ""
       
        
        DispatchQueue.main.async {[self] in
            self.setupTVCells()
        }
    }
    
    
    
    func setupTVCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType:.BookingCFTVCell))
        tablerow.append(TableRow(height:30,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType:.BookedTravelDetailsTVCell))
        tablerow.append(TableRow(cellType:.DownloadBtnTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
}



extension BookingCFVC {
    
    
    func callHotelVoucherAPI() {
        BASE_URL = ""
        DispatchQueue.main.async {[self] in
            viewmodel?.CALL_GET_Hotel_VOUCHER_DETAILS_API(dictParam: [:], url: vocherurl)
        }
    }
    
    func hotelVocherdetails(response: HShowVoucherModel) {
        BASE_URL = BASE_URL1
        titlelbl.text = "You Have Booked Your Hotel Successfully"
        bookingRefrence = response.data?.booking_details?[0].app_reference ?? ""
        status = response.data?.booking_details?[0].status ?? ""
        bookingsource = response.data?.booking_details?[0].booking_source ?? ""
       
        DispatchQueue.main.async {[self] in
            setupHotelTVCells(details: response.data?.booking_details ?? [])
        }
    }
    
    
    func setupHotelTVCells(details:[HVBooking_details]) {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"",
                                 moreData: details,
                                 cellType:.BCHotelDetailsTVCell))
        tablerow.append(TableRow(height:30,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType:.DownloadBtnTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
}


extension BookingCFVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        
        if let selectedtab = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            if selectedtab == "Flight" {
                
                if callapibool == true {
                    callAPI()
                }
            }else {
                if callapibool == true {
                    callHotelVoucherAPI()
                }
            }
        }
    }
    
    
    func timerDidFinish() {
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    func updateTimer() {
        
    }
    
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
            callAPI()
        }
    }
    
    //MARK: - resultnil
    @objc func resultnil() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "noresult"
        self.present(vc, animated: true)
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "nointernet"
        self.present(vc, animated: true)
    }
    
    
}
