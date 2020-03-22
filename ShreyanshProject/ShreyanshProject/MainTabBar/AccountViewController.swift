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
    
    @IBOutlet weak var demoTextField: UITextField!
    
    //make nested array of stringn type
    let labelArray = [ ["Track Order", "Size Chart", "Notifications", "Store Location"], ["Country", "Language", "About Us", "FAQ", "Shipping & Returns"] ]
    
    /* 1. Make nested array of image type this is help to use as much as image      we want to show in particular section.
       2. Use "Image Literal" to store the image which is available in Assets file  */
    
    let imageArray = [ [#imageLiteral(resourceName: "TrackOrder"), #imageLiteral(resourceName: "SizeChart"), #imageLiteral(resourceName: "Notifications"), #imageLiteral(resourceName: "StoreLocator")], [ #imageLiteral(resourceName: "Country"), #imageLiteral(resourceName: "Language"), #imageLiteral(resourceName: "AboutUs"), #imageLiteral(resourceName: "FAQ"), #imageLiteral(resourceName: "ShippingAndReturn")] ]
    
    let flagImage: UIImage = #imageLiteral(resourceName: "IndiaFlag")
    let countryName = "IND"
    let languageName = "ENG"
    
    let countryNameArray = ["BTN", "IND", "FRA", "ISL", "NPL", "LKA", "USA", "VNM"]
    let flagArray = [ #imageLiteral(resourceName: "ButanFlag"), #imageLiteral(resourceName: "IndiaFlag"), #imageLiteral(resourceName: "FranceFlag"), #imageLiteral(resourceName: "IcelandFlag"), #imageLiteral(resourceName: "NepalFlag"), #imageLiteral(resourceName: "SriLankaFlag"), #imageLiteral(resourceName: "UnitedStatesOfAmericaFlag"), #imageLiteral(resourceName: "VietnamFlag")]
    
    let LanguageArray = ["CHINESE", "SPANISH", "ENGLISH", "HINDI", "ARABIC", "PORTUGUESE", "BENGALI", "RUSSIAN", "JAPANESE", "FRENCH"]
    
        
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
        
        createPickerForCountry()
        createToolBar()

    }
    
    
    
    //MARK: Toast Function
    
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
    
    func createPickerForCountry() {
        
        let countryPicker = UIPickerView()
        countryPicker.delegate = self
        
        demoTextField.inputView = countryPicker
        countryPicker.backgroundColor = .white
        
    }
    
    
    func createToolBar() {

        let toolBar = UIToolbar()
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: #selector(dismissKeyboard))

        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        demoTextField.inputAccessoryView = toolBar
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    
}



//MARK: TableViewDataSource & Delegate

extension AccountViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
        return labelArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //CountryTableCell for section 1 and row 0
        if indexPath.section == 1 && indexPath.row == 0 {
            
            let cell = accountTableView.dequeueReusableCell(withIdentifier: "CountryTableCell", for: indexPath) as! CountryTableViewCell
            
            cell.setCountryIconImageView(image: imageArray[1][0])
            cell.setCountryTitleLabel(text: labelArray[1][0])
            cell.setCountryFlagImageView(image: flagArray[3])
            cell.setCountryNameLabel(text: countryNameArray[3])
            
            return cell
            
        }
        
        //LanguageTableCell for section 1 and row 1
        else if indexPath.section == 1 && indexPath.row == 1 {
           
            let cell = accountTableView.dequeueReusableCell(withIdentifier: "LanguageTableCell", for: indexPath) as! LanguageTableViewCell
            
            cell.setLaguageIconImageView(image: imageArray[1][1])
            cell.setLanguageTitleLabel(text: labelArray[1][1])
            cell.setLanguageNameLabel(text: String(LanguageArray[0].prefix(3)))
            
            return cell
            
        }
        
        //AccountTableCell for remainings
        else {
            
            let cell = accountTableView.dequeueReusableCell(withIdentifier: "AccountTableCell", for: indexPath) as! AccountTableViewCell
        
            cell.setValueToLabel(text: labelArray[indexPath.section][indexPath.row])
            cell.setImage(image: imageArray[indexPath.section][indexPath.row])
        
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return labelArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        //return empty string to the sectionHeader
        return " "
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        accountTableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 && indexPath.row == 0 {
            
            print(countryNameArray[3])
            createPickerForCountry()
        }
            
        else if indexPath.section == 1 && indexPath.row == 1 {
            
            print(LanguageArray[0])
        }
            
        else {
            
        //call showToast to show label text of clicked cell
        showToast(controller: self, message : labelArray[indexPath.section][indexPath.row], seconds: 0.25)
        }

    }
    
    
}


//MARK: ImagePickerController Extension

//we need to use extension both Delegate because          "myPickerController.delegate = self"

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


//MARK: UIPickerView Extension

extension AccountViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return countryNameArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return countryNameArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        demoTextField.text = countryNameArray[row]
    }
    
    
    
}

