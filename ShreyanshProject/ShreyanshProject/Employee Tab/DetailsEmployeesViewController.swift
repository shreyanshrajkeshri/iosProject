//
//  DetailsEmployeesViewController.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 18/05/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit
import Alamofire

class DetailsEmployeesViewController: UIViewController {
    
    @IBOutlet weak var detailsTableView: UITableView!
    
    var detailsEmployeeArray = [Employable]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("DetailsEmployeesViewController")
        
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        
        let nib = UINib(nibName: "DetailsTableViewCell", bundle: nil)
        detailsTableView.register(nib, forCellReuseIdentifier: "DetailsCell")
        
        getEmployeeData {
            self.detailsTableView.reloadData()
        }
        
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("Details viewDidAppear")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupTheme()
        
    }
    
    func setupTheme() {
        view.backgroundColor = Theme.color(type: .backgroundColor)
        detailsTableView.backgroundColor = Theme.color(type: .backgroundColor)
    }
    
    
    
    func getEmployeeData(completionHandler: @escaping () -> ()) {
        let request = AF.request("http://dummy.restapiexample.com/api/v1/employees")
        
        request.responseDecodable(of: EmployeeResults.self) { (response) in
          
            guard let employeeData = response.value else { return }
            self.detailsEmployeeArray = employeeData.data
            
            completionHandler()
        }
    }
    
    

}

extension DetailsEmployeesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return detailsEmployeeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = detailsTableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! DetailsTableViewCell
        
        cell.firstLabel.text = "\(detailsEmployeeArray[indexPath.row].employeeName)  •  \(detailsEmployeeArray[indexPath.row].employeeAge)"
        
        cell.secondLabel.text = "ID : \(detailsEmployeeArray[indexPath.row].id)  Salary : ₹ \(detailsEmployeeArray[indexPath.row].employeeSalary) "
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        detailsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
}
