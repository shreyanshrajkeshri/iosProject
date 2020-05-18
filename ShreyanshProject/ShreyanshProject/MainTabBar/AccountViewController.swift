//
//  AccountViewController.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 20/03/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var accountTableView: UITableView!
    @IBOutlet weak var accountImageVIew: UIImageView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var contentViewOfStackView: UIView!
    
    
    //make nested array of string Type
    let accountLabelArray = [ ["Track Order", "Size Chart", "Notifications", "Store Location"], ["Country", "Language", "About Us", "FAQ", "Shipping & Returns"] ]
    
    /* 1. Make nested array of image type this is help to use as much as image      we want to show in particular section.
       2. Use "Image Literal" to store the image which is available in Assets file  */
    
    let accountImageArray = [ [#imageLiteral(resourceName: "TrackOrder"), #imageLiteral(resourceName: "SizeChart"), #imageLiteral(resourceName: "Notifications"), #imageLiteral(resourceName: "StoreLocator")], [ #imageLiteral(resourceName: "Country"), #imageLiteral(resourceName: "Language"), #imageLiteral(resourceName: "AboutUs"), #imageLiteral(resourceName: "FAQ"), #imageLiteral(resourceName: "ShippingAndReturn")] ]
   
    
    /* This Is like Sticky Note.
     I am using this variable in this class also use this
     from CountryAndLanguageViewController class */
    
    //public static var languageName: String = "HINDI"
    var countryCode: String = "IN"
    var flagImage: UIImage = #imageLiteral(resourceName: "NotFound")
    
    var languageName: String = "HINDI"


     
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        accountTableView.delegate = self
        accountTableView.dataSource = self
        
        //make imageView to circular ImageView
        accountImageVIew.layer.cornerRadius = accountImageVIew.frame.size.height/2
        
        //make circular corner of contentViewOfStackView
        contentViewOfStackView.layer.cornerRadius = 10
        
        //remove the extra empty cell of tableview
        accountTableView.tableFooterView = UIView()
        
        
        //create 3 nib for multiple cell in single tableview and register all 3 nib to accountTableView
        
        let nib = UINib(nibName: "AccountTableViewCell", bundle: nil)
        accountTableView.register(nib, forCellReuseIdentifier: "AccountTableCell")
        
        let nib2 = UINib(nibName: "CountryTableViewCell", bundle: nil)
        accountTableView.register(nib2, forCellReuseIdentifier: "CountryTableCell")
        
        let nib3 = UINib(nibName: "LanguageTableViewCell", bundle: nil)
        accountTableView.register(nib3, forCellReuseIdentifier: "LanguageTableCell")
        
        
        
        //This is code to make imageView clickable and in action we can perform clickable task
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        
        accountImageVIew.isUserInteractionEnabled = true
        accountImageVIew.addGestureRecognizer(singleTap)

    }
    
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        accountTableView.reloadData()
    }
    
    
//    func downloadImageViaURL(urlString: String) -> UIImage {
//
//        var image: UIImage = #imageLiteral(resourceName: "NoImage")
//        if let url = URL(string: urlString) {
//            URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//                if let data = data {
//                    DispatchQueue.main.async {
//                        image = UIImage(data: data) ?? image
//                    }
//
//                }
//            }.resume()
//        }
//
//        return image
//    }
//
    
    //MARK: Toast()
    
    func showToast(controller: UIViewController, message : String, seconds: Double) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.white
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15

        controller.present(alert, animated: true)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    
    //MARK: Tap Detected()
    //ImageView Action and we neet to add @objc to fix the error which come in singleTap
    @objc func tapDetected() {
        
        //this is ActionSheet
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert: UIAlertAction!) -> Void in self.Gallery() }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        return
    }
    
    @IBAction func signInButtonAction(_ sender: UIButton) {
        print("RegistrationViewController")
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        
        //self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func joinButtonAction(_ sender: UIButton) {
        
        print("LoginViewController")
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        //self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
   
}



//MARK: TableViewDataSource & Delegate

extension AccountViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
        return accountLabelArray[section].count
    }
    
    //MARK: Cell For Row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //CountryTableCell for section 1 and row 0
        if indexPath.section == 1 && indexPath.row == 0 {
            
            let cell = accountTableView.dequeueReusableCell(withIdentifier: "CountryTableCell", for: indexPath) as! CountryTableViewCell
            
            cell.setCountryIconImageView(image: accountImageArray[1][0])
            cell.setCountryTitleLabel(text: accountLabelArray[1][0])
            //cell.setCountryFlagImageView(image: AccountViewController.flagImage)
            cell.setCountryNameLabel(text: countryCode)
            
            
            //this is code to get image from server via countryCode and set it in cell.FlagImage
            if let url = URL(string: "https://www.countryflags.io/\(countryCode)/flat/64.png") {

                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.main.async {

                            //here i pass image to cell.FlagImage
                            cell.setCountryFlagImageView(image: UIImage(data: data) ?? self.flagImage)
                            cell.countryFlagImageView.contentMode = .scaleAspectFill

                        }
                    }
                }.resume()
            }
            
            return cell
            
        }
        
        //LanguageTableCell for section 1 and row 1
        else if indexPath.section == 1 && indexPath.row == 1 {
           
            let cell = accountTableView.dequeueReusableCell(withIdentifier: "LanguageTableCell", for: indexPath) as! LanguageTableViewCell
            
            cell.setLaguageIconImageView(image: accountImageArray[1][1])
            cell.setLanguageTitleLabel(text: accountLabelArray[1][1])
            cell.setLanguageNameLabel(text: String(languageName.prefix(3)))
            
            return cell
            
        }
        
        //AccountTableCell for remainings
        else {
            
            let cell = accountTableView.dequeueReusableCell(withIdentifier: "AccountTableCell", for: indexPath) as! AccountTableViewCell
        
            cell.setValueToLabel(text: accountLabelArray[indexPath.section][indexPath.row])
            cell.setImage(image: accountImageArray[indexPath.section][indexPath.row])
        
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return accountLabelArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        //return empty string to the sectionHeader
        return " "
    }
    
    //MARK: Did Select Row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        accountTableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CountryAndLanguageViewController") as! CountryAndLanguageViewController
        
        //CountryTableCell is selected
        if indexPath.section == 1 && indexPath.row == 0 {
            
            print(countryCode)
            CountryAndLanguageViewController.cellMode = .Country
            
            //we need to assign self to countrydelegate which is declare inside CountryAndLanguageViewController
            vc.countryDelegate = self
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
         
        //LanguageTableCell is selected
        else if indexPath.section == 1 && indexPath.row == 1 {
            
            print(languageName)
            CountryAndLanguageViewController.cellMode = .Language
            
            //we need to assign self to languagedelegate which is declare inside CountryAndLanguageViewController
            vc.languageDelegate = self
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
            
        //Store Location is selected
        else if indexPath.section == 0 && indexPath.row == 3 {
            
            let vc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
            
        //AccountTableCell is selected
        else {
            
        //call showToast to show label text of clicked cell
        showToast(controller: self, message : accountLabelArray[indexPath.section][indexPath.row], seconds: 0.25)
        }

    }
    
    
}


//MARK: ImagePickerController Extension

//we need to use extension both Delegate because "myPickerController.delegate = self"

extension AccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Camera Action
    
    func camera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .camera
            self.present(myPickerController, animated: true, completion: nil)
        }
        else {
            showToast(controller: self, message: "Camera Not Support In Simulator", seconds: 2.0)
        }
    }
    
    //MARK: Gallery Action

    func Gallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .photoLibrary
            myPickerController.allowsEditing = true
            self.present(myPickerController, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Image Picker Controller Action

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        {
            let pickedImage = info[.editedImage]
            self.accountImageVIew.image = pickedImage as? UIImage
        }
        
    }
    
}

//MARK: LanguageProtocol Extension

extension AccountViewController: LanguageProtocol {
    
    func getSelectedLanguage(languageName: String) {
        
        //here i assign the value languageNmae which come from CountryAndLanguageViewController and set is to AccountViewController's languageName
        self.languageName = languageName
        
    }
}


//MARK: CountryProtocol Extension

extension AccountViewController: CountryProtocol {
    
    func getSelectedCountryCode(countryCode: String) {
        
        //here i assign the value countryCode which come from CountryAndLanguageViewController and set is to AccountViewController's countryCode

        self.countryCode = countryCode
    }
}
