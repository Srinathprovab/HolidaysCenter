//
//  HotelDealsTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 16/08/22.
//

import UIKit
import SDWebImage


class HotelDealsTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var dealsCV: UICollectionView!
    
    
    var userinfo = [String:Any]()
    var key = String()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        self.key = cellInfo?.key1 ?? ""
        dealsCV.reloadData()
    }
    
    
    func setupCV() {
        //  contentView.backgroundColor = .AppBGcolor
        holderView.backgroundColor = .AppBGcolor
        dealsCV.backgroundColor = .AppBGcolor
        let nib = UINib(nibName: "HotelDealsCVCell", bundle: nil)
        dealsCV.register(nib, forCellWithReuseIdentifier: "cell")
        dealsCV.delegate = self
        dealsCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 156, height: 190)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        dealsCV.collectionViewLayout = layout
        dealsCV.layer.cornerRadius = 4
        dealsCV.clipsToBounds = true
        dealsCV.showsHorizontalScrollIndicator = false
        dealsCV.bounces = false
    }
    
}

extension HotelDealsTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.key == "holiday" {
            return perfectholidays.count
        }else if self.key == "flight" {
            return sliderimagesflight.count
        }else {
            return sliderimageshotel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HotelDealsCVCell {
            
            if self.key == "holiday" {
                
                if perfectholidays.count == 0 {
                    dealsCV.setEmptyMessage("No Data Found")
                }else {
                    dealsCV.setEmptyMessage("")
                    let data = perfectholidays[indexPath.row]
                    
                    
                    cell.dealsImg.sd_setImage(with: URL(string: "\(data.image ?? "")"), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
                        if let error = error {
                            
                            if (error as NSError).code == NSURLErrorBadServerResponse {
                                cell.dealsImg.image = UIImage(named: "noimage")
                            } else {
                                cell.dealsImg.image = UIImage(named: "noimage")
                            }
                        }
                    })
                    
                    
                    
                    //    cell.dealsImg.sd_setImage(with: URL(string: "\(imgPath )\(data.image ?? "")"), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                    cell.fromcitylbl.text = data.title
                    cell.toitylbl.isHidden = true
                    cell.tripimg.isHidden = true
                    cell.hotelcityview.isHidden = false
                    cell.hotelcitynamelbl.text = data.title
                    
                }
                
            }else if self.key == "flight" {
                
                if sliderimagesflight.count == 0 {
                    dealsCV.setEmptyMessage("No Data Found")
                }else {
                    dealsCV.setEmptyMessage("")
                    let data = sliderimagesflight[indexPath.row]
                    
                    cell.dealsImg.sd_setImage(with: URL(string: "\(data.image ?? "")"), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
                        if let error = error {
                            
                            if (error as NSError).code == NSURLErrorBadServerResponse {
                                cell.dealsImg.image = UIImage(named: "noimage")
                            } else {
                                cell.dealsImg.image = UIImage(named: "noimage")
                            }
                        }
                    })
                    
                    
                    
                    
                    cell.fromcitylbl.text =  data.from_city_name
                    cell.toitylbl.text = data.to_city_name

                    if data.trip_type == "oneway" {
                        cell.tripimg.image = UIImage(named: "trip1")
                    }else {
                        cell.tripimg.image = UIImage(named: "trip2")
                    }
                    
                }
                
            }else {
                
                if sliderimageshotel.count == 0 {
                    dealsCV.setEmptyMessage("No Data Found")
                }else {
                    dealsCV.setEmptyMessage("")
                    let data = sliderimageshotel[indexPath.row]
                    
                    
                    cell.dealsImg.sd_setImage(with: URL(string: "\(data.image ?? "")"), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
                        if let error = error {
                            
                            if (error as NSError).code == NSURLErrorBadServerResponse {
                                cell.dealsImg.image = UIImage(named: "noimage")
                            } else {
                                cell.dealsImg.image = UIImage(named: "noimage")
                            }
                        }
                    })
                    
                    
                    //  cell.dealsImg.sd_setImage(with: URL(string: "\(data.image ?? "")"), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                    cell.fromcitylbl.text = "\(data.city_name ?? "")"
                    cell.toitylbl.isHidden = true
                    cell.tripimg.isHidden = true
                    cell.hotelcityview.isHidden = false
                    cell.hotelcitynamelbl.text = data.city_name
                    
                }
                
                
                
            }
            commonCell = cell
        }
        return commonCell
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.key == "hotel" {
            
            let data = sliderimageshotel[indexPath.row]
            userinfo.removeAll()
            
            userinfo["city"] = data.city
            userinfo["hotel_destination"] = data.hotel_destination
            userinfo["hotel_checkin"] = data.check_in
            userinfo["hotel_checkout"] = data.check_out
            
            NotificationCenter.default.post(name: NSNotification.Name("hoteldealstap"), object: nil,userInfo: userinfo)
            
        }else if self.key == "flight" {
            let data = sliderimagesflight[indexPath.row]
            userinfo.removeAll()
            
            
            userinfo["trip_type"] = data.trip_type
            userinfo["from"] = "\(data.from_city_name ?? ""),\(data.from_airport_name ?? "") (\(data.from_city_loc ?? ""))"
            userinfo["from_loc_id"] = data.from_city
            userinfo["to"] = "\(data.to_city_name ?? ""),\(data.to_airport_name ?? "") (\(data.to_city_loc ?? ""))"
            userinfo["to_loc_id"] = data.to_city
            userinfo["depature"] = data.travel_date
            userinfo["return"] = data.return_date
            userinfo["to_city_name"] = data.to_city_name
            userinfo["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
            userinfo["to_city_name"] = data.to_city_name
            userinfo["to_city_loc"] = data.to_city_loc
            userinfo["from_city_name"] = data.from_city_name
            userinfo["from_city_loc"] = data.from_city_loc
            
            
            NotificationCenter.default.post(name: NSNotification.Name("flightdealstap"), object: nil,userInfo: userinfo)
            
            
        }else if self.key == "holiday"{
            
            NotificationCenter.default.post(name: NSNotification.Name("holidaysdealstap"), object: nil,userInfo: userinfo)
        }
    }
    
}

