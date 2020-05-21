//
//  FavouriteModule.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 18/05/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import Foundation
import Alamofire

struct Employable: Codable {
    
    let id: String
    let employeeName: String
    let employeeSalary: String
    let employeeAge: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case employeeAge = "employee_age"
    }
    
}

struct EmployeeResults: Decodable {
    var status: String
    var data: [Employable]
}
