//
//  AppDelegate.swift
//  HolidaysCenter
//
//  Created by FCI on 13/03/24.
//

import UIKit
import CoreData
import IQKeyboardManager
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        checkForAppUpdate()
        
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().keyboardDistanceFromTextField = 100 // Adjust this value as needed
     //   GMSServices.provideAPIKey("AIzaSyB7uwDF-FDLdQDHZs621xFiVkIgo7sPmoE")
        GMSServices.provideAPIKey("AIzaSyAfgpJ36EyQji0KETVN-UuooOpATS_zgb0")
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
}



extension AppDelegate {
    
    func checkForAppUpdate() {
        // Replace 'YOUR_APP_ID' with the actual App Store ID of your app
        let appID = "6469474891"
        let urlString = "https://itunes.apple.com/lookup?id=\(appID)"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching app version info: \(String(describing: error?.localizedDescription))")
                return
            }
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let results = jsonResponse["results"] as? [[String: Any]],
                   let appStoreVersion = results.first?["version"] as? String {
                    // Compare with the installed version
                    self.compareAppVersions(appStoreVersion)
                }
            } catch {
                print("Error parsing version info: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    
    
    func compareAppVersions(_ appStoreVersion: String) {
        if let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            if currentVersion != appStoreVersion {
                // If the versions don't match, show an alert prompting the user to update
                DispatchQueue.main.async {
                    self.promptUserToUpdate(appStoreVersion: appStoreVersion)
                }
            }
        }
    }
    
    
    
    func promptUserToUpdate(appStoreVersion: String) {
        let alertController = UIAlertController(
            title: "Update Available",
            message: "A new version (\(appStoreVersion)) of HolidaysCenters is available. Please update to the latest version for the best experience.",
            preferredStyle: .alert
        )
        
        let updateAction = UIAlertAction(title: "Update", style: .default) { _ in
            // Redirect user to the App Store
            if let url = URL(string: "https://apps.apple.com/app/id6469474891") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            // Navigate to HomeVC after canceling
            self.gotoDashBoardTBVC()
        }
        
        alertController.addAction(updateAction)
        alertController.addAction(cancelAction)
        
        DispatchQueue.main.async {
            if let topController = self.topViewController() {
                topController.present(alertController, animated: true) {
                    // Dismiss after 5 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        callapibool = false
                        alertController.dismiss(animated: true) {
                            // After dismissing the alert, go to dashboard/home
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.gotoDashBoardTBVC()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func gotoDashBoardTBVC() {
        callapibool = true
        guard let vc = DBTabbarController.newInstance else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        
        DispatchQueue.main.async {
            // Access the active window scene
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = scene.windows.first(where: { $0.isKeyWindow }),
               let rootViewController = window.rootViewController {
                rootViewController.present(vc, animated: false, completion: nil)
            }
        }
    }
    
    
    
    
    func topViewController() -> UIViewController? {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first(where: { $0.isKeyWindow }),
              var topController = window.rootViewController else {
            return nil
        }
        
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        return topController
    }
}
