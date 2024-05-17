//
//  MapViewVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 23/08/22.
//

import UIKit
import MapKit
import GoogleMaps


struct MapModel {
    var longitude =  String()
    var latitude =  String()
    var hotelname = String()
    var hotelimg = String()
}



class MapViewVC: UIViewController, CLLocationManagerDelegate, UIPopoverPresentationControllerDelegate {
    
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var googleMapView: UIView!
    
    
    static var newInstance: MapViewVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? MapViewVC
        return vc
    }
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func setupUI() {
        
        
        self.googleMapView.backgroundColor = .clear
        backButton.addTarget(self, action: #selector(backbtnAction), for: .touchUpInside)
        
    }
    
    
    
    
    @objc func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !mapModelArray.isEmpty {
            // Calculate the average latitude and longitude from mapModelArray
            let averageLatitude = mapModelArray.map { Double($0.latitude) ?? 0.0 }.reduce(0.0, +) / Double(mapModelArray.count)
            let averageLongitude = mapModelArray.map { Double($0.longitude) ?? 0.0 }.reduce(0.0, +) / Double(mapModelArray.count)
            
            // Set the camera to center on the average coordinates
            let camera = GMSCameraPosition.camera(withLatitude: averageLatitude, longitude: averageLongitude, zoom: 12.0)
            
            // Initialize the GMSMapView with the camera and frame
            let gmsView = GMSMapView.map(withFrame: googleMapView.bounds, camera: camera)
            
            gmsView.delegate = self
            // Set the mapView as googleMapView's subview
            googleMapView.addSubview(gmsView)
            
            // Add markers to the mapView
            addMarkersToMap(gmsView)
            
            locationManager.stopUpdatingLocation() // You may want to stop updates after you have the user's location
        }
    }
    
    
    
    
    
    //    func addMarkersToMap(_ mapView: GMSMapView) {
    //
    //        for mapModel in mapModelArray {
    //            if let latitude = Double(mapModel.latitude), let longitude = Double(mapModel.longitude) {
    //                // Create and configure markers based on the mapModel data
    //                let marker = GMSMarker()
    //                marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    //                marker.title = mapModel.hotelname
    //                // Customize the marker as needed
    //
    //                // Create a custom marker icon with an image
    //                if let markerImage = UIImage(named: "mapicon") {
    //                    let markerView = UIImageView(image: markerImage)
    //                    marker.iconView = markerView
    //                } else {
    //                    print("Error: Marker image not found or is nil.")
    //                }
    //
    //                // Add the marker to the map
    //                marker.map = mapView
    //
    //                mapView.selectedMarker = marker
    //
    //            } else {
    //                print("Error: Invalid latitude or longitude values in mapModel.")
    //            }
    //        }
    //    }
    
    
    @objc func backbtnAction() {
        callapibool = false
        dismiss(animated: true)
    }
    
    
}




// Implementing GMSMapViewDelegate
extension MapViewVC: GMSMapViewDelegate {
    
    
    func addMarkersToMap(_ mapView: GMSMapView) {
        for mapModel in mapModelArray {
            if let latitude = Double(mapModel.latitude), let longitude = Double(mapModel.longitude) {
                // Create and configure markers based on the mapModel data
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                marker.title = mapModel.hotelname
                // Assign a custom identifier to the marker
                marker.userData = mapModel // You can assign any unique identifier here
                
                // Create a custom marker icon with an image
                if let markerImage = UIImage(named: "mapicon") {
                    let markerView = UIImageView(image: markerImage)
                    marker.iconView = markerView
                } else {
                    print("Error: Marker image not found or is nil.")
                }
                
                // Add the marker to the map
                marker.map = mapView
            } else {
                print("Error: Invalid latitude or longitude values in mapModel.")
            }
        }
    }
    
    
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        // This method will be called when a marker is tapped.
        // Here, you can show your popover view controller.
        
        // Example:
        if let mapModel = marker.userData as? MapModel {
             let popVC = MapHotelInfoVC()
            
            popVC.modalPresentationStyle = .popover
            popVC.mapModel = mapModel
            
            var popOverVC = popVC.popoverPresentationController
            popOverVC?.delegate = self
           
            popOverVC?.sourceView = marker.iconView
          //  popOverVC?.sourceRect = marker.iconView
            popVC.preferredContentSize = CGSize(width: 80, height: 80)
            
            
            self.present(popVC, animated: true)
        }
        
        return true
    }
    
}

