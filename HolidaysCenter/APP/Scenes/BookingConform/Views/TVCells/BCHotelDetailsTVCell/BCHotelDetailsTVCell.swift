//
//  BCHotelDetailsTVCell.swift
//  HolidaysCenter
//
//  Created by FCI on 07/11/23.
//

import UIKit

class BCHotelDetailsTVCell: TableViewCell {
    
    
    
    @IBOutlet weak var hotelname: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var hoteladdress: UILabel!
    @IBOutlet weak var refundablelbl: UILabel!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var checkinlbl: UILabel!
    @IBOutlet weak var checkoutlbl: UILabel!
    @IBOutlet weak var roomscountlbl: UILabel!
    @IBOutlet weak var adultDetailsTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var roomTypelbl: UILabel!
    
    var guestcount = Int()
    var details = [HVBooking_details]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupTV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        details = cellInfo?.moreData as? [HVBooking_details] ?? []
        
        img.layer.cornerRadius = 6
        img.clipsToBounds = true
        
        //    img.sd_setImage(with: URL(string: details[0].hotel_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        
        
        
        
        if details[0].hotel_image == nil || details[0].hotel_image?.isEmpty == true {
            self.img.image = UIImage(named: "noimage1")
        }else {
            // Assuming mg is a UIImageView instance
            img.sd_setImage(with: URL(string: details[0].hotel_image ?? ""),
                            placeholderImage: UIImage(named: "placeholder.png"),
                            completed: { (image, error, cacheType, imageURL) in
                
                if let error = error {
                    // Handle error, image couldn't be loaded
                    print("Error loading image: \(error.localizedDescription)")
                    // Set your placeholder image or default image here
                    self.img.image = UIImage(named: "noimage1")
                }
            })
        }
       
        
        
        hotelname.text = details[0].hotel_name ?? ""
        hoteladdress.text = details[0].hotel_address ?? ""
        refundablelbl.text = defaults.string(forKey: UserDefaultsKeys.refundtype) ?? ""
        roomTypelbl.text = details[0].room_type ?? ""
        
        
        if refundablelbl.text == "Non Refundable" {
            refundablelbl.textColor = HexColor("#FF0808")
        }else {
            refundablelbl.textColor = .AppLabelColor
        }
        
        kwdlbl.text = "\(details[0].currency ?? ""):\(String(format: "%.2f", Double(details[0].itinerary_details?[0].total_fare ?? "") ?? 0.0))"
        checkinlbl.text = convertDateFormat(inputDate: details[0].hotel_check_in ?? "", f1: "yyyy-MM-dd", f2: "dd MMM,yyyy")
        checkoutlbl.text = convertDateFormat(inputDate: details[0].hotel_check_out ?? "", f1: "yyyy-MM-dd", f2: "dd MMM,yyyy")
        roomscountlbl.text = "\(details[0].total_rooms ?? 0)"
        
        guestcount = details[0].customer_details?.count ?? 0
        
        if guestcount > 1 {
            tvHeight.constant = (CGFloat(guestcount * 35))
        }
        
        adultDetailsTV.reloadData()
        
    }
    
    
    func setupTV() {
        adultDetailsTV.register(UINib(nibName: "BookedAdultDetailsTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        adultDetailsTV.delegate = self
        adultDetailsTV.dataSource = self
        adultDetailsTV.tableFooterView = UIView()
        adultDetailsTV.showsHorizontalScrollIndicator = false
    }
    
}



extension BCHotelDetailsTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guestcount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? BookedAdultDetailsTVCell {
            cell.selectionStyle = .none
            
            let data = details[0].customer_details?[indexPath.row]
            
            cell.travellerNamelbl.text = "\(data?.first_name ?? "") \(data?.last_name ?? "")"
            cell.typelbl.text = ""
            cell.seatlbl.text = "\(data?.pax_type ?? "")"
            c = cell
        }
        return c
    }
    
    
    
}
