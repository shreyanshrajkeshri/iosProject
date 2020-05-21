//
//  ListedEmployeesViewController.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 18/05/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit
import Alamofire

class ListedEmployeesViewController: UIViewController {
    
    @IBOutlet weak var listedTableView: UITableView!
    
    var listedEmployeeArray = [Employable]()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("ListedEmployeesViewController")
        
        listedTableView.delegate = self
        listedTableView.dataSource = self
        
        
        let nib = UINib(nibName: "ListedTableViewCell", bundle: nil)
        listedTableView.register(nib, forCellReuseIdentifier: "ListedCell")
        
        getEmployeeData {
            self.listedTableView.reloadData()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("Listed viewDidAppear")
    
    }
    
    
    func getEmployeeData(completionHandler: @escaping () -> ()) {
        let request = AF.request("http://dummy.restapiexample.com/api/v1/employees")
        
        request.responseDecodable(of: EmployeeResults.self) { (response) in
          
            guard let employeeData = response.value else { return }
            self.listedEmployeeArray = employeeData.data
            
            completionHandler()
        }
    }
    
}


extension ListedEmployeesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listedEmployeeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = listedTableView.dequeueReusableCell(withIdentifier: "ListedCell", for: indexPath) as! ListedTableViewCell
        
        cell.textLabel?.text = listedEmployeeArray[indexPath.row].employeeName
        cell.textLabel?.textAlignment = .center
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        listedTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
