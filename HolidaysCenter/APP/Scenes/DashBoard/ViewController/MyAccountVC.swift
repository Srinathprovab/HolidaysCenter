//
//  MyAccountVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 24/08/22.
//

import UIKit
import Alamofire

class MyAccountVC: BaseTableVC, ProfileUpdateViewModelDelegate {
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var profilePicView: UIView!
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var loginlbl: UILabel!
    var tablerow = [TableRow]()
    static var newInstance: EditProfileVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? EditProfileVC
        return vc
    }
    var pickerbool = false
    var first_name = String()
    var last_name = String()
    var address2 = String()
    var date_of_birth = String()
    var address = String()
    var phone = String()
    var country_code = String()
    var email = String()
    var gender = String()
    var country_name = String()
    var state_name = String()
    var city_name = String()
    var pin_code = String()
    var payload = [String:Any]()
    var vm:ProfileUpdateViewModel?
    
    
    override func viewWillDisappear(_ animated: Bool) {
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
        
        let logstatus = defaults.bool(forKey: UserDefaultsKeys.loggedInStatus)
        if logstatus == true {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            profilePicView.isHidden = false
            nav.editView.isHidden = false
            loginlbl.isHidden = true
            if pickerbool == true {
                
            }else {
                callApi()
            }
            
        }else {
            loginlbl.isHidden = false
            setAttributedString(str1: "Login To View Your Bookings")
            profilePicView.isHidden = true
            nav.editView.isHidden = true
            tablerow.removeAll()
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            commonTVData = tablerow
            commonTableView.reloadData()
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(loginDone), name: NSNotification.Name("logindon"), object: nil)
    }
    
    @objc func loginDone() {
        profilePicView.isHidden = false
        nav.editView.isHidden = false
        loginlbl.isHidden = true
        callApi()
    }
    
    
    func callApi() {
        payload.removeAll()
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid)
        vm?.CALL_SHOW_PROFILE_API(dictParam: payload)
    }
    
    
    func profileDetails(response: ProfileUpdateModel) {
        profildata = response.data
        
        first_name = profildata?.first_name ?? ""
        last_name = profildata?.last_name ?? ""
        date_of_birth = profildata?.date_of_birth ?? ""
        address = profildata?.address ?? ""
        address2 = profildata?.address2 ?? ""
        city_name = profildata?.city_name ?? ""
        state_name = profildata?.state_name ?? ""
        country_name = profildata?.country_name ?? ""
        pin_code = profildata?.pin_code ?? ""
        gender = profildata?.gender ?? ""
        country_code = profildata?.country_code ?? ""
        phone = profildata?.phone ?? ""
        email = profildata?.email ?? ""
        
    //    self.profilePic.sd_setImage(with: URL(string: profildata?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        
        self.profilePic.sd_setImage(with: URL(string: profildata?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"), options: [.retryFailed], completed: { (image, error, cacheType, imageURL) in
            if let error = error {
                // Handle error loading image
               // print("Error loading image: \(error.localizedDescription)")
                // Check if the error is due to a 404 Not Found response
                if (error as NSError).code == NSURLErrorBadServerResponse {
                    // Set placeholder image for 404 error
                    self.profilePic.image = UIImage(named: "noimage")
                } else {
                    // Set placeholder image for other errors
                    self.profilePic.image = UIImage(named: "noimage")
                }
            }
        })
        
        DispatchQueue.main.async {[self] in
            appendLoginTvcells()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupTV()
        vm = ProfileUpdateViewModel(self)
    }
    
    func setupTV() {
        nav.bg.isHidden = true
        loginlbl.isHidden = true
        nav.titlelbl.text = "User Profile"
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        profilePicView.layer.cornerRadius = 50
        profilePicView.clipsToBounds = true
        profilePicView.layer.borderWidth = 4
        profilePicView.layer.borderColor = UIColor.WhiteColor.cgColor
        
        nav.backBtn.isHidden = true
        nav.editView.isHidden = false
        nav.editBtn.addTarget(self, action: #selector(didTapOnEditBtnAction(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "LogoImgTVCell",
                                         "LabelTVCell",
                                         "TextfieldTVCell",
                                         "RadioButtonTVCell",
                                         "ButtonTVCell"])
        appendLoginTvcells()
    }
    
    
    @objc func didTapOnEditBtnAction(_ sender:UIButton) {
        guard let vc = EditProfileVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    func appendLoginTvcells() {
        tablerow.removeAll()
        
       
        tablerow.append(TableRow(title:"Frist Name*",subTitle: first_name,text:"1",key1: "noedit", tempText: "Frist Name",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Last Name*",subTitle: last_name,text:"2",key1: "noedit", tempText: "Last Name",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Date Of Birth*",subTitle: date_of_birth,key: "dob",text:"3",key1: "noedit",tempText: "dob",cellType:.TextfieldTVCell))
        
        
        
        tablerow.append(TableRow(title:"Mobile Number*",subTitle: phone,key: "mobile",text:"4", buttonTitle: "+\(country_code)",key1: "noedit",tempText: "Mobile",cellType:.TextfieldTVCell))
        
        tablerow.append(TableRow(title:"Email Address*",subTitle: email,key: "email",text:"55",key1: "noedit", tempText: "Email",cellType:.TextfieldTVCell))
        
        
        
        //        tablerow.append(TableRow(title:"Address*",subTitle:address,text:"5",key1: "noedit", tempText: "address",cellType:.TextfieldTVCell))
        //        tablerow.append(TableRow(title:"Address2*",subTitle: address2,text:"6",key1: "noedit", tempText: "address",cellType:.TextfieldTVCell))
        //        tablerow.append(TableRow(title:"Gender*",subTitle: gender,key:"gender",text:"7",key1: "noedit", tempText: "gender",cellType:.TextfieldTVCell))
        //        tablerow.append(TableRow(title:"Country Name*",subTitle: country_name,text:"8",key1: "noedit", tempText: "cname",cellType:.TextfieldTVCell))
        //        tablerow.append(TableRow(title:"State Name*",subTitle: state_name,text:"9",key1: "noedit", tempText: "sname",cellType:.TextfieldTVCell))
        //        tablerow.append(TableRow(title:"City Name*",subTitle: city_name,text:"10",key1: "noedit", tempText: "cityname",cellType:.TextfieldTVCell))
        //        tablerow.append(TableRow(title:"Pin Code*",subTitle: pin_code,text:"11",key1: "noedit", tempText: "pincode",cellType:.TextfieldTVCell))
        
        
        
        
        //        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        //        tablerow.append(TableRow(title:"UPDATE",cellType:.ButtonTVCell))
        //        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    override func editingTextField(tf: UITextField) {
        
        print(tf.text ?? "")
        switch tf.tag {
        case 1:
            first_name = tf.text ?? ""
            break
            
        case 2:
            last_name = tf.text ?? ""
            break
            
        case 3:
            date_of_birth = tf.text ?? ""
            break
            
        case 4:
            phone = tf.text ?? ""
            break
            
        case 5:
            address = tf.text ?? ""
            
        case 6:
            address2 = tf.text ?? ""
            
        case 7:
            gender = tf.text ?? ""
            break
            
        case 8:
            country_name = tf.text ?? ""
            
        case 9:
            state_name = tf.text ?? ""
            
        case 10:
            city_name = tf.text ?? ""
            
        case 11:
            pin_code = tf.text ?? ""
        default:
            break
        }
    }
    
    
    
    override func donedatePicker(cell:TextfieldTVCell){
        date_of_birth = convertDateFormat(inputDate: cell.txtField.text ?? "", f1: "dd/MM/yyyy", f2: "yyyy-MM-dd")
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell:TextfieldTVCell){
        self.view.endEditing(true)
    }
    
    
    override func btnAction(cell: ButtonTVCell){
        
        if first_name.isEmpty == true {
            showToast(message: "Enter First Name")
        }else  if last_name.isEmpty == true {
            showToast(message: "Enter Last Name")
        }else  if date_of_birth.isEmpty == true {
            showToast(message: "Enter Date Of Birth ")
        }else if phone.isEmpty == true {
            showToast(message: "Enter Mobile Number")
        }else if gender.isEmpty == true {
            showToast(message: "Enter Gender")
        }else  if address.isEmpty == true {
            showToast(message: "Enter Address")
        }else  if country_name.isEmpty == true {
            showToast(message: "Enter Country Name ")
        }else if state_name.isEmpty == true {
            showToast(message: "Enter State Name")
        }else if city_name.isEmpty == true {
            showToast(message: "Enter City Name")
        }else if pin_code.isEmpty == true {
            showToast(message: "Enter Pin Code")
        }else {
            
            payload.removeAll()
            payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid)
            payload["first_name"] = first_name
            payload["last_name"] = last_name
            payload["date_of_birth"] = date_of_birth
            payload["address"] = address
            payload["address2"] = address2
            payload["phone"] = phone
            payload["gender"] = gender
            payload["country_name"] = country_name
            payload["state_name"] = state_name
            payload["city_name"] = city_name
            payload["pin_code"] = pin_code
            payload["country_code"] = country_code
            
            callUpdateProfileAPI()
        }
    }
    
    
    override func didTapOnCountryCodeDropDownBtn(cell:TextfieldTVCell){
        cell.dropDown.show()
    }
    
    
    @objc func didTapOnBackBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    func callUpdateProfileAPI() {
        self.vm?.view.showLoader()
        
        
        // Create a multipart form data request using Alamofire
        AF.upload(multipartFormData: { multipartFormData in
            // Append the parameters to the request
            for (key, value) in self.payload {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
            }
            
            // Append the image to the request
            if let imageData = self.profilePic?.image?.jpegData(compressionQuality: 0.4) {
                multipartFormData.append(imageData, withName: "image", fileName: "example.jpg", mimeType: "image/jpeg")
            }
        }, to: BASE_URL + ApiEndpoints.updatemobileprofile ).responseDecodable(of: ProfileUpdateModel.self) { response in
            // Handle the response
            switch response.result {
            case .success(let profileUpdateModel):
                // Handle success
                self.vm?.view.hideLoader()
                self.showToast(message: profileUpdateModel.msg ?? "")
                
                defaults.set(profileUpdateModel.data?.image ?? "", forKey: UserDefaultsKeys.userimg)
                defaults.set("\(profileUpdateModel.data?.first_name ?? "") \(profileUpdateModel.data?.last_name ?? "")", forKey: UserDefaultsKeys.userimg)
                
                let seconds = 2.0
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    NotificationCenter.default.post(name: NSNotification.Name("logindon"), object: nil)
                    self.dismiss(animated: true)
                }
            case .failure(let error):
                // Handle error
                print("Upload failure: \(error.localizedDescription)")
            }
        }
        
    }
    
    
    
    @IBAction func didTapOnChangePicBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Choose To Open", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Open Gallery", style: .default){ (action) in
            self.openGallery()
        })
        alert.addAction(UIAlertAction(title: "Open Camera", style: .default){ (action) in
            self.openCemera()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel){ (action) in
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}



extension MyAccountVC:UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let tempImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profilePic.image = tempImage
        }
        
        self.pickerbool = true
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func openCemera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
}



extension MyAccountVC {
    
    
    func setAttributedString(str1:String) {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.AppLabelColor,
                      NSAttributedString.Key.font:UIFont.LatoRegular(size: 15),
                      .underlineColor:UIColor.AppBtnColor,
                      .underlineStyle: NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        loginlbl.attributedText = combination
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        loginlbl.addGestureRecognizer(tapGesture)
        loginlbl.isUserInteractionEnabled = true
    }
    
    @objc func labelTapped(gesture:UITapGestureRecognizer) {
        if gesture.didTapAttributedString("Login To View Your Bookings", in: loginlbl) {
            gotoLoginVC()
        }
        
        
        func gotoLoginVC() {
            guard let vc = LoginVC.newInstance.self else {return}
            vc.modalPresentationStyle = .overCurrentContext
            vc.isvcfrom = "mybookings"
            present(vc, animated: true)
        }
        
    }
    
}
