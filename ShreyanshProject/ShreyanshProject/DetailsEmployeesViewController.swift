//
//  DetailsEmployeesViewController.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 18/05/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit

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
    
    
    func getEmployeeData(completionHandler: @escaping () -> ()) {
            
        guard let url = URL(string: "http://dummy.restapiexample.com/api/v1/employees") else { return }
        
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let data = data {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                    
                    if let results = json!["data"] as? [[String:Any]] {
                        
                        for result in results {
                            
                            self.detailsEmployeeArray.append(
                                Employable(
                                    id: result["id"] as? String,
                                    employee_name: result["employee_name"] as? String,
                                    employee_salary: result["employee_salary"] as? String,
                                    employee_age: result["employee_age"] as? String)
                                    )
                        }
                        
                        for item in self.detailsEmployeeArray {
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

extension DetailsEmployeesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return detailsEmployeeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = detailsTableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! DetailsTableViewCell
        
        cell.firstLabel.text = "\(detailsEmployeeArray[indexPath.row].employee_name!)  •  \(detailsEmployeeArray[indexPath.row].employee_age!)"
        
        cell.secondLabel.text = "ID : \(detailsEmployeeArray[indexPath.row].id!)  Salary : ₹ \(detailsEmployeeArray[indexPath.row].employee_salary!) "
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        detailsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
}
