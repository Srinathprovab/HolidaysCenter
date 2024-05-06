//
//  SearchFlightResultVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 17/08/22.
//

import UIKit

class SearchFlightResultVC: BaseTableVC, TimerManagerDelegate {
    
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var sessonlbl: UILabel!
    @IBOutlet weak var flightsFoundlbl: UILabel!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterBtn: UIButton!
    
    
    static var newInstance: SearchFlightResultVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SearchFlightResultVC
        return vc
    }
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var finalInputArray = [String:Any]()
    let refreshControl = UIRefreshControl()
    var vm:FlightListViewModel?
    let dateFormatter = DateFormatter()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        vm = FlightListViewModel(self)
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
        dateFormatter.dateFormat = "hh:mm a"
        
        if  callapibool == true {
            callAPI()
        }
        
    }
    
    
    func setupUI() {
        if screenHeight > 835 {
            navHeight.constant = 190
        }else {
            navHeight.constant = 160
        }
        
        view.backgroundColor = .WhiteColor
        holderView.isHidden = true
        holderView.backgroundColor = .AppHolderViewColor
        nav.titlelbl.text = "Search Result"
        nav.backBtn.addTarget(self, action: #selector(gotoBackScreen), for: .touchUpInside)
        nav.citylbl.isHidden = false
        nav.datelbl.isHidden = false
        nav.travellerlbl.isHidden = false
        
        nav.editView.isHidden = false
        nav.editBtn.addTarget(self, action: #selector(didTapOnEditSearchFlight(_:)), for: .touchUpInside)
        
        sessonlbl.text = "Your Session Expires In: 14:15"
        sessonlbl.textColor = .AppLabelColor
        sessonlbl.font = UIFont.OpenSansRegular(size: 12)
        
        flightsFoundlbl.textColor = .AppLabelColor
        flightsFoundlbl.font = UIFont.OpenSansRegular(size: 12)
        
//        filterView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 25)
//        filterView.backgroundColor = .AppBtnColor
        filterBtn.setTitle("", for: .normal)
        
        //  refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        // commonTableView.refreshControl = refreshControl
        
        
        setupTV()
    }
    
    @objc func handleRefresh() {
        // Perform data fetching or reloading here
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
            // Put your code which should be executed with a delay here
            setupRoundTripTVCells(jfl: oneWayFlights)
            commonTableView.refreshControl?.endRefreshing()
        }
    }
    
    
    
    func setupTV() {
        
        commonTableView.registerTVCells(["SearchFlightResultInfoTVCell",
                                         "RoundTripTVcell",
                                         "EmptyTVCell"])
        
        
        
    }
    
    @objc func gotoBackScreen() {
        
        DispatchQueue.main.async {
            TimerManager.shared.stopTimer()
        }
        
        callapibool = false
        guard let vc = BookFlightVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    
    
    override func didTapOnRefunduableBtn(cell: SearchFlightResultInfoTVCell) {
        print("didTapOnRefunduableBtn")
    }
    
    
    @objc func didTapOnEditSearchFlight(_ sender:UIButton) {
        guard let vc = ModifySearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    
    
    func goToFlightInfoVC() {
        guard let vc = SelectedFlightInfoVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        self.present(vc, animated: false)
    }
    
    
    override func didTaponRoundTripCell(cell: RoundTripTVcell) {
        accesskey = cell.access_key1
        defaults.set( cell.refundString, forKey: UserDefaultsKeys.flightrefundtype)
        goToFlightInfoVC()
    }
    
    @IBAction func didTapOnFilterBtnAction(_ sender: Any) {
        guard let vc = FilterSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        vc.filterTapKey = "sort"
        self.present(vc, animated: false)
    }
    
}


extension SearchFlightResultVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SearchFlightResultInfoTVCell {
            accesskey = cell.access_key1
            goToFlightInfoVC()
        }
    }
}




extension SearchFlightResultVC {
    
    
    func callAPI() {
        
        loderBool = "hide"
        showLoadera()
        
        let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
        switch journyType {
        case "oneway":
            vm?.CALL_GET_FLIGHT_LIST_API(dictParam: payload)
            break
            
        case "circle":
            vm?.CALL_GET_FLIGHT_LIST_API(dictParam: payload)
            break
            
        case "multicity":
            
            do {
                let arrJson = try JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
                let theJSONText = NSString(data: arrJson, encoding: String.Encoding.utf8.rawValue)
                print(theJSONText ?? "")
                
                payload1["search_params"] = theJSONText
                payload1["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
                
                vm?.CALL_GET_AIRLINE_MULTICITY_LIST_API(dictParam: payload1)
                
                
            }catch let error as NSError{
                print(error.description)
            }
            
            
            break
        default:
            break
        }
        
    }
    
    
    
    func flightList(response: FlightListModel) {
        
        loderBool = "flight"
        hideLoadera()
        prices.removeAll()
        noofStopsA.removeAll()
        fareTypeA.removeAll()
        airlinesA.removeAll()
        connectingFlightsA.removeAll()
        connectingAirportA.removeAll()
        
        
        
        searchid = "\(response.data?.search_id ?? 0)"
        bookingsource = response.data?.booking_source ?? ""
        bookingsourcekey = response.data?.booking_source_key ?? ""
        
        holderView.isHidden = false
        
        setuplabels(lbl: sessonlbl, text: "Your Session Expires In: 14:15", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 12), align: .left)
        
        setuplabels(lbl: flightsFoundlbl, text: "\(response.data?.j_flight_list?.count ?? 0) Flights found", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 12), align: .right)
        
        
        DispatchQueue.main.async {
            if TimerManager.shared.timerDidFinish {
                TimerManager.shared.timerDidFinish = false
            }
            
            // Stop the timer if it's running
            TimerManager.shared.stopTimer()
            
            // Reset the timer with a new total time and start it
            TimerManager.shared.startTimer(time: 900) // Set your desired total time
            
            
        }
        
        
        
        oneWayFlights = response.data?.j_flight_list ?? [[]]
        oneWayFlights.forEach { i in
            i.forEach { j in
                
                
                prices.append(String(format: "%.2f", Double(j.price?.api_total_display_fare ?? 0.0) ))
                fareTypeA.append(j.fareType ?? "")
                
                
                j.flight_details?.summary?.forEach({ k in
                    
                    airlinesA.append("\(k.operator_name ?? "") (\(k.operator_code ?? ""))")
                    
                    switch k.no_of_stops {
                    case 0:
                        noofStopsA.append("0 Stop")
                        break
                    case 1:
                        noofStopsA.append("1 Stop")
                        break
                    case 2:
                        noofStopsA.append("2 Stops")
                        break
                    default:
                        break
                    }
                })
                
                
                
                j.flight_details?.details?.forEach({ g in
                    g.forEach { j in
                        
                        connectingFlightsA.append("\(j.operator_name ?? "") (\(j.operator_code ?? ""))")
                        connectingAirportA.append("\( j.destination?.city ?? "") (\(j.destination?.loc ?? ""))")
                    }
                })
                
            }
        }
        
        prices = Array(Set(prices))
        noofStopsA = Array(Set(noofStopsA))
        fareTypeA = Array(Set(fareTypeA))
        airlinesA = Array(Set(airlinesA))
        connectingFlightsA = Array(Set(connectingFlightsA))
        connectingAirportA = Array(Set(connectingAirportA))
        
        
        let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
        switch journyType {
            
        case "oneway":
            
            defaults.set("\(defaults.string(forKey: UserDefaultsKeys.fromcityname) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.tocityname) ?? "")", forKey: UserDefaultsKeys.journeyCitys)
            defaults.set("\(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "", f1: "dd-MM-yyyy", f2: "EEE, d MMM"))", forKey: UserDefaultsKeys.journeyDates)
            
            nav.citylbl.text = defaults.string(forKey: UserDefaultsKeys.journeyCitys) ?? ""
            nav.datelbl.text = defaults.string(forKey: UserDefaultsKeys.journeyDates) ?? ""
            nav.travellerlbl.text = defaults.string(forKey: UserDefaultsKeys.travellerDetails)
            
            break
            
        case "circle":
            
            defaults.set("\(defaults.string(forKey: UserDefaultsKeys.fromcityname) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.tocityname) ?? "")", forKey: UserDefaultsKeys.journeyCitys)
            defaults.set("\(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "", f1: "dd-MM-yyyy", f2: "EEE, d MMM")) - \(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.calRetDate) ?? "", f1: "dd-MM-yyyy", f2: "EEE, d MMM"))", forKey: UserDefaultsKeys.journeyDates)
            
            nav.citylbl.text = defaults.string(forKey: UserDefaultsKeys.journeyCitys) ?? ""
            nav.datelbl.text = defaults.string(forKey: UserDefaultsKeys.journeyDates) ?? ""
            nav.travellerlbl.text = defaults.string(forKey: UserDefaultsKeys.travellerDetails)
            
            break
            
            
        default:
            break
        }
        
        
        setupRoundTripTVCells(jfl: oneWayFlights)
    }
    
    
    
    func setupRoundTripTVCells(jfl:[[J_flight_list]]) {
        commonTableView.separatorStyle = .none
        setuplabels(lbl: flightsFoundlbl, text: "\(jfl.count) Flights found", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 12), align: .right)
        TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
        
        tablerow.removeAll()
        
       
        jfl.forEach { i in
            i.forEach { j in
                tablerow.append(TableRow(title:j.access_key,
                                         kwdprice:"\(j.price?.api_currency ?? ""):\( String(format: "%.2f", j.price?.api_total_display_fare ?? 0.0))",
                                         refundable:j.fareType,
                                         moreData: j.flight_details?.summary,
                                         cellType:.RoundTripTVcell))
            }
        }
        
        
        tablerow.append(TableRow(height:50,bgColor: .AppHolderViewColor,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
        
        if jfl.count == 0 {
            tablerow.removeAll()
            
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
            
            commonTVData = tablerow
            commonTableView.reloadData()
        }
    }
    
    
}



extension SearchFlightResultVC:FlightListViewModelDelegate {
    
    
    
    func multicityAirlinelist(response: MulticityModel) {
        
        
        searchid = "\(response.data?.search_id ?? 0)"
        bookingsource = response.data?.booking_source ?? ""
        bookingsourcekey = response.data?.booking_source_key ?? ""
        
        holderView.isHidden = false
        
        setuplabels(lbl: sessonlbl, text: "Your Session Expires In: 14:15", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 12), align: .left)
        
        
        DispatchQueue.main.async {
            // TimerManager.shared.setTotalTime(900)
            TimerManager.shared.startTimer(time: 900)
        }
        
        multicityFlights = response.data?.j_flight_list ?? []
        multicityFlights.forEach { j in
            
            prices.append(String(format: "%.2f", Double(j.totalPrice ?? "") ?? 0.0))
            fareTypeA.append(j.fareType ?? "")
            j.flight_details?.summary?.forEach({ k in
                
                airlinesA.append(k.operator_name ?? "")
                connectingFlightsA.append(k.destination?.loc ?? "")
                connectingAirportA.append(k.operator_name ?? "")
                
                switch k.no_of_stops {
                case 0:
                    noofStopsA.append("0 Stop")
                    break
                case 1:
                    noofStopsA.append("1 Stop")
                    break
                case 2:
                    noofStopsA.append("1+ Stop")
                    break
                default:
                    break
                }
            })
            
        }
        
        prices = Array(Set(prices))
        noofStopsA = Array(Set(noofStopsA))
        fareTypeA = Array(Set(fareTypeA))
        airlinesA = Array(Set(airlinesA))
        connectingFlightsA = Array(Set(connectingFlightsA))
        connectingAirportA = Array(Set(connectingAirportA))
        
        setupMulticityTVCells(jfl: response.data?.j_flight_list ?? [])
        
        
    }
    
    
    
    func setupMulticityTVCells(jfl:[MJ_flight_list]) {
        commonTableView.separatorStyle = .none
        
        tablerow.removeAll()
        
        
        jfl.forEach { j in
            tablerow.append(TableRow(title:j.access_key,
                                     kwdprice:"\(j.totalPrice_API ?? "")",
                                     refundable:j.fareType,
                                     moreData: j.flight_details?.summary,
                                     cellType:.RoundTripTVcell))
        }
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
        
        if jfl.count == 0 {
            tablerow.removeAll()
            
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
            
            commonTVData = tablerow
            commonTableView.reloadData()
        }
    }
    
    
}



extension SearchFlightResultVC {
    
    func addObserver() {
        
        TimerManager.shared.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        //        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("tryagain"), object: nil)
        
    }
    
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
            if callapibool == true {
                callAPI()
            }
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
    
    
    func timerDidFinish() {
        TimerManager.shared.timerDidFinish = true
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    
    
    
    func updateTimer() {
        let totalTime = TimerManager.shared.totalTime
        let minutes =  totalTime / 60
        let seconds = totalTime % 60
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        
        DispatchQueue.main.async {[self] in
            setuplabels(lbl: sessonlbl, text: "Your Session Expires In: \(formattedTime)",
                        textcolor: .AppLabelColor,
                        font: .OpenSansRegular(size: 12),
                        align: .left)
        }
        
        
    }
    
    
    
}


extension SearchFlightResultVC:AppliedFilters {
    func hotelFilterByApplied(minpricerange: Double, maxpricerange: Double, starRating: String, starRatingNew: [String], refundableTypeArray: [String], nearByLocA: [String], niberhoodA: [String], aminitiesA: [String]) {
        
    }
    
    
   
    
    // Create a function to check if a given time string is within a time range
    func isTimeInRange(time: String, range: String) -> Bool {
        guard let departureDate = dateFormatter.date(from: time) else {
            return false
        }
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: departureDate)
        
        switch range {
        case "12 am - 6 am":
            return hour >= 0 && hour < 6
        case "06 am - 12 pm":
            return hour >= 6 && hour < 12
        case "12 pm - 06 pm":
            return hour >= 12 && hour < 18
        case "06 pm - 12 am":
            return hour >= 18 && hour < 24
        default:
            return false
        }
    }
    
    
    func filterByApplied(minpricerange: Double, maxpricerange: Double, noofstopsFA: [String], departureTimeFilter: [String], arrivalTimeFilter: [String], airlinesFA: [String], cancellationTypeFA: [String], connectingFlightsFA: [String], connectingAirportsFA: [String]) {
        
        
        print("====minpricerange ==== \(minpricerange)")
        print("====maxpricerange ==== \(maxpricerange)")
        print("==== noofstopsFA ==== \(noofstopsFA)")
        print("==== departureTimeFilter ==== \(departureTimeFilter)")
        print("==== arrivalTimeFilter ==== \(arrivalTimeFilter)")
        print("==== airlinesFA ==== \(airlinesFA)")
        print("==== cancellationTypeFA ==== \(cancellationTypeFA)")
        print("==== connectingFlightsFA ==== \(connectingFlightsFA)")
        print("==== connectingAirportsFA ==== \(connectingAirportsFA)")
        
        let sortedArray = oneWayFlights.filter { flightList in
            
            
            guard let details = flightList.first?.flight_details?.details else { return false }
            
            
            // Calculate the total price for each flight in the flight list
            let totalPrice = flightList.reduce(0.0) { result, flight in
                result + (Double(flight.price?.api_total_display_fare ?? 0.0) )
            }
            
            // Check if the flight list has at least one flight with the specified number of stops
            let noOfStopsMatch = noofstopsFA.isEmpty || flightList.contains(where: { $0.flight_details?.summary?.contains(where: { noofstopsFA.contains("\($0.no_of_stops ?? 0)") }) ?? false })
            
            // Check if the flight list has at least one flight with the specified airline
            let airlinesMatch = airlinesFA.isEmpty || flightList.contains(where: { $0.flight_details?.summary?.contains(where: { airlinesFA.contains("\($0.operator_name ?? "") (\($0.operator_code ?? ""))") }) ?? false })
            
            // Check if the flight list has at least one flight with the specified cancellation type
            let refundableMatch = cancellationTypeFA.isEmpty || flightList.contains(where: { $0.fareType == cancellationTypeFA.first })
            
            
            
            let depMatch = departureTimeFilter.isEmpty || flightList.contains { flight in
                if let departureDateTime = flight.flight_details?.summary?.first?.origin?.time {
                    return departureTimeFilter.contains { departureTime in
                        return isTimeInRange(time: departureDateTime, range: departureTime)
                    }
                }
                return false
            }
            
            
            let arrMatch = arrivalTimeFilter.isEmpty || flightList.contains { flight in
                if let arrivalDateTime = flight.flight_details?.summary?.first?.destination?.time {
                    return arrivalTimeFilter.contains { arrivalTime in
                        return isTimeInRange(time: arrivalDateTime, range: arrivalTime)
                    }
                }
                return false
            }
            
            
            let connectingFlightsMatch = flightList.contains { flight in
                if connectingFlightsFA.isEmpty {
                    return true // Return true for all flights if 'connectingAirportsFA' is empty
                }
                
                
                for summaryArray in details {
                    if summaryArray.contains(where: { flightDetail in
                        let operatorname = flightDetail.operator_name ?? ""
                        let loc = flightDetail.operator_code ?? ""
                        return connectingFlightsFA.contains("\(operatorname) (\(loc))")
                    }) {
                        return true // Return true for this flight if it contains a matching airport
                    }
                }
                
                
                return false // Return false if no matching airport is found in this flight
            }
            
            
            
            
            let ConnectingAirportsMatch = flightList.contains { flight in
                if connectingAirportsFA.isEmpty {
                    return true // Return true for all flights if 'connectingAirportsFA' is empty
                }
                
                
                for summaryArray in details {
                    if summaryArray.contains(where: { flightDetail in
                        let airportName = flightDetail.destination?.city ?? ""
                        let loc = flightDetail.destination?.loc ?? ""
                        return connectingAirportsFA.contains("\(airportName) (\(loc))")
                    }) {
                        return true // Return true for this flight if it contains a matching airport
                    }
                }
                
                
                return false // Return false if no matching airport is found in this flight
            }
            
            
            
            
            
            // Check if the total price is within the specified range
            return (Double(String(format: "%.2f", totalPrice )) ?? 0.0) >= minpricerange && (Double(String(format: "%.2f", totalPrice )) ?? 0.0) <= maxpricerange && noOfStopsMatch && airlinesMatch && refundableMatch && connectingFlightsMatch && ConnectingAirportsMatch && depMatch && arrMatch
            
            
        }
        
        
        setupRoundTripTVCells(jfl: sortedArray)
        
    }
    
    
    
    
    func filtersSortByApplied(sortBy: SortParameter) {
        
        
        switch sortBy {
        case .PriceLow:
            
            let sortedFlights = oneWayFlights.sorted { (flights1, flights2) -> Bool in
                let totalPrice1 = flights1.reduce(0) { $0 + (Double($1.price?.api_total_display_fare ?? 0.0) ) }
                let totalPrice2 = flights2.reduce(0) { $0 + (Double($1.price?.api_total_display_fare ?? 0.0) ) }
                return totalPrice1 < totalPrice2
            }
            
            setupRoundTripTVCells(jfl: sortedFlights)
            
            break
            
        case .PriceHigh:
            
            let sortedFlights = oneWayFlights.sorted { (flights1, flights2) -> Bool in
                let totalPrice1 = flights1.reduce(0) { $0 + (Double($1.price?.api_total_display_fare ?? 0.0) ) }
                let totalPrice2 = flights2.reduce(0) { $0 + (Double($1.price?.api_total_display_fare ?? 0.0) ) }
                return totalPrice1 > totalPrice2
            }
            setupRoundTripTVCells(jfl: sortedFlights)
            
            break
            
            
            
        case .DepartureLow:
            
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let time1 = j1.first?.flight_details?.summary?.first?.origin?.time ?? "0"
                let time2 = j2.first?.flight_details?.summary?.first?.origin?.time ?? "0"
                return time1 < time2
            })
            setupRoundTripTVCells(jfl: sortedArray)
            
            break
            
        case .DepartureHigh:
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let time1 = j1.first?.flight_details?.summary?.first?.origin?.time ?? "0"
                let time2 = j2.first?.flight_details?.summary?.first?.origin?.time ?? "0"
                return time1 > time2
            })
            
            setupRoundTripTVCells(jfl: sortedArray)
            break
            
            
            
        case .ArrivalLow:
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let time1 = j1.first?.flight_details?.summary?.first?.destination?.time ?? "0"
                let time2 = j2.first?.flight_details?.summary?.first?.destination?.time ?? "0"
                return time1 < time2
            })
            
            setupRoundTripTVCells(jfl: sortedArray)
            break
            
        case .ArrivalHigh:
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let time1 = j1.first?.flight_details?.summary?.first?.destination?.time ?? "0"
                let time2 = j2.first?.flight_details?.summary?.first?.destination?.time ?? "0"
                return time1 > time2
            })
            
            setupRoundTripTVCells(jfl: sortedArray)
            break
            
            
            
            
        case .DurationLow:
            
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let durationseconds1 = j1.first?.flight_details?.summary?.first?.duration_seconds ?? 0
                let durationseconds2 = j2.first?.flight_details?.summary?.first?.duration_seconds ?? 0
                return durationseconds1 < durationseconds2
            })
            
            setupRoundTripTVCells(jfl: sortedArray)
            
            break
            
        case .DurationHigh:
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let durationseconds1 = j1.first?.flight_details?.summary?.first?.duration_seconds ?? 0
                let durationseconds2 = j2.first?.flight_details?.summary?.first?.duration_seconds ?? 0
                return durationseconds1 > durationseconds2
            })
            
            setupRoundTripTVCells(jfl: sortedArray)
            break
            
            
        case .airlineaz:
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let operatorCode1 = j1.first?.flight_details?.summary?.first?.operator_code ?? ""
                let operatorCode2 = j2.first?.flight_details?.summary?.first?.operator_code ?? ""
                return operatorCode1 < operatorCode2
            })
            
            setupRoundTripTVCells(jfl: sortedArray)
            break
            
        case .airlineza:
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let operatorCode1 = j1.first?.flight_details?.summary?.first?.operator_code ?? ""
                let operatorCode2 = j2.first?.flight_details?.summary?.first?.operator_code ?? ""
                return operatorCode1 > operatorCode2
            })
            
            
            setupRoundTripTVCells(jfl: sortedArray)
            break
            
            
        case .nothing:
            setupRoundTripTVCells(jfl: oneWayFlights)
            break
            
        default:
            break
        }
        
        
        DispatchQueue.main.async {[self] in
            commonTableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        }
        
    }
    
    
    
}
