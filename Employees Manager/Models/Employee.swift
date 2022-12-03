//
//  Employee.swift
//  Employees Manager
//
//  Created by eslam dweeb on 03/12/2022.
//

import Foundation

struct Employee:Codable {
    let id:Int64
    let fullName:String
    let email:String?
    let image:String?
}
