//
//  FlightLoderVC.swift
//  Boookers
//
//  Created by FCI on 21/02/24.
//

import UIKit

class FlightLoderVC: UIViewController {
    
    @IBOutlet weak var flighHoldertView: UIView!
    @IBOutlet weak var hotelHoldertView: UIView!
    @IBOutlet weak var gifimg: UIImageView!
    @IBOutlet weak var cityslbl: UILabel!
    @IBOutlet weak var depDatelbl: UILabel!
    @IBOutlet weak var retDatelbl: UILabel!
    @IBOutlet weak var economylbl: UILabel!
    
    
    @IBOutlet weak var hotelgifimg: UIImageView!
    @IBOutlet weak var hotelcitylbl: UILabel!
    @IBOutlet weak var checkinlbl: UILabel!
    @IBOutlet weak var checkoutlbl: UILabel!
    @IBOutlet weak var nightslbl: UILabel!
    
    
    var loderName = String()
    var gifImages: [UIImage] = []
    var currentFrame: Int = 0
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect)
        if tabselect == "Flight" {
            let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
            if journeyType == "circle" {
                retDatelbl.isHidden = false
            }
            setupFlightInputs()
        }else {
            setupHotelInputs()
        }
        
    }
    
    
    
    
    func loadGifFrames() {
        // Replace "your_gif_file" with the name of your GIF file (without extension)
        if let gifURL = Bundle.main.url(forResource: loderName, withExtension: "gif"),
           let gifSource = CGImageSourceCreateWithURL(gifURL as CFURL, nil) {
            let frameCount = CGImageSourceGetCount(gifSource)
            
            for index in 0..<frameCount {
                if let cgImage = CGImageSourceCreateImageAtIndex(gifSource, index, nil) {
                    let uiImage = UIImage(cgImage: cgImage)
                    gifImages.append(uiImage)
                }
            }
        }
    }
    
    func startGifAnimation() {
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(updateGifFrame), userInfo: nil, repeats: true)
    }
    
    @objc func updateGifFrame() {
        
        
        let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect)
        if tabselect == "Flight" {
            gifimg.image = gifImages[currentFrame]
            currentFrame += 1
            
            if currentFrame >= gifImages.count {
                currentFrame = 0
            }
        }else {
            hotelgifimg.image = gifImages[currentFrame]
            currentFrame += 1
            
            if currentFrame >= gifImages.count {
                currentFrame = 0
            }
        }
    }
    
    // Don't forget to invalidate the timer when the view controller is deallocated
    deinit {
        timer?.invalidate()
    }
    
}


extension FlightLoderVC {
    func setupFlightInputs() {
        loderName = "loderimg"
        flighHoldertView.isHidden = false
        hotelHoldertView.isHidden = true
        cityslbl.text = "\(defaults.string(forKey: UserDefaultsKeys.fromcityname) ?? "") To \(defaults.string(forKey: UserDefaultsKeys.tocityname) ?? "")"
        depDatelbl.text = "Departure:\(defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "")"
        retDatelbl.text = "Return:\(defaults.string(forKey: UserDefaultsKeys.calRetDate) ?? "")"
        economylbl.text = "\(defaults.string(forKey: UserDefaultsKeys.journeyType) ?? ""),\(defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "")"
        
        loadGifFrames()
        startGifAnimation()
    }
}



extension FlightLoderVC {
    func setupHotelInputs() {
        
        loderName = "hotelloder"
        flighHoldertView.isHidden = true
        hotelHoldertView.isHidden = false
        hotelcitylbl.text = "\(defaults.string(forKey: UserDefaultsKeys.locationcity) ?? "")"
        checkinlbl.text = "CheckIn:\(defaults.string(forKey: UserDefaultsKeys.checkin) ?? "")"
        checkoutlbl.text = "CheckOut:\(defaults.string(forKey: UserDefaultsKeys.checkout) ?? "")"
        
        // Example usage:
        let checkInDate = defaults.string(forKey: UserDefaultsKeys.checkin) ?? ""
        let checkOutDate = defaults.string(forKey: UserDefaultsKeys.checkout) ?? ""
        let nights = numberOfNights(checkInDate: checkInDate, checkOutDate: checkOutDate)
        self.nightslbl.text = "\(nights) Nights"

        loadGifFrames()
        startGifAnimation()
    }
    
    
    
    
    func numberOfNights(checkInDate: String, checkOutDate: String) -> Int {
        // Create date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        // Parse check-in and check-out dates
        guard let checkIn = dateFormatter.date(from: checkInDate),
              let checkOut = dateFormatter.date(from: checkOutDate) else {
            print("Error parsing dates.")
            return 0
        }
        
        // Print parsed dates for debugging
        print("Parsed Check-In Date:", checkIn)
        print("Parsed Check-Out Date:", checkOut)
        
        // Calculate the difference in days
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: checkIn, to: checkOut)
        
        // Extract the number of days
        guard let numberOfDays = components.day else {
            print("Error calculating the number of days.")
            return 0
        }
        
        // Subtract 1 to get the number of nights
        let numberOfNights = numberOfDays - 1
        
        return numberOfNights
    }

   

    
}
