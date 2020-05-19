//
//  ListedEmployeesViewController.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 18/05/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit

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
            
        guard let url = URL(string: "http://dummy.restapiexample.com/api/v1/employees") else { return }
        
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let data = data {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                    
                    if let results = json!["data"] as? [[String:Any]] {
                        
                        for result in results {
                            
                            self.listedEmployeeArray.append(
                                Employable(
                                    id: result["id"] as? String,
                                    employee_name: result["employee_name"] as? String,
                                    employee_salary: result["employee_salary"] as? String,
                                    employee_age: result["employee_age"] as? String)
                                    )
                        }
                        
                        for item in self.listedEmployeeArray {
                            print(item.id!)
                            print(item.employee_name!)
                            print(item.employee_age!)
                            print(item.employee_salary!)
                            
                            print("------------------------------")
                        }
                        
                        DispatchQueue.main.async {
                            completionHandler()
                        }
                    }
                    
                } catch {
                    print("JSON Error")
                }
            }
            
        }.resume()
            
    }
    
}


extension ListedEmployeesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listedEmployeeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = listedTableView.dequeueReusableCell(withIdentifier: "ListedCell", for: indexPath) as! ListedTableViewCell
        
        cell.textLabel?.text = listedEmployeeArray[indexPath.row].employee_name
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
