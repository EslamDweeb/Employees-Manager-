//
//  EmployeeLDB.swift
//  Employees Manager
//
//  Created by eslam dweeb on 03/12/2022.
//

import Foundation
import SQLite
import SQLite3

class EmployeeLDB {
    
    private let db: Connection?
    
    private let employees = Table("employees")
    private let id = Expression<Int64>("id")
    private let fullName = Expression<String>("fullName")
    private let email = Expression<String?>("email")
    private let image = Expression<String?>("image")
    
    init() {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!

        do {
            db = try Connection("\(path)/EmployeesManager.sqlite3")
        } catch {
            db = nil
            print ("Unable to open database")
        }

        createTable()
    }
    func createTable() {
        do {
            try db!.run(employees.create(ifNotExists: true) { table in
            table.column(id, primaryKey: true)
            table.column(fullName)
            table.column(email, unique: true)
            table.column(image)
            })
        } catch {
            print("Unable to create table")
        }
    }
    func addEmployee(eFullName: String, eEmail: String?, eImage: String?,completionHandeler: @escaping (_ sucess:String?,_ error:Error?)->Void) {
        do {
            let insert = employees.insert(fullName <- eFullName, email <- eEmail, image <- eImage)
            let id = try db!.run(insert)
            print(insert.description)
            completionHandeler("Create Employee Successfully",nil)
        } catch {
           completionHandeler(nil,error)
        }
    }
    
    func getEmployees(completionHandeler: @escaping (_ employees:[Employee]?,_ error:Error?)->Void) {
        var employees = [Employee]()

        do {
            for employee in try db!.prepare(self.employees) {
                employees.append(Employee(id: employee[id], fullName: employee[fullName], email: employee[email], image: employee[image]))
            }
        } catch {
           completionHandeler(nil,error)
        }

       completionHandeler(employees,nil)
    }
    func deleteContact(eid:Int64,completionHandeler: @escaping (_ sucess:Bool?,_ error:Error?)->Void) {
        do {
            let employee = employees.filter(id == eid)
            try db!.run(employee.delete())
           completionHandeler(true,nil)
        } catch {
            print("Delete failed")
            completionHandeler(nil,error)
        }
    }
    func updateContact(eid:Int64, newEmployee: Employee,completionHandeler: @escaping (_ sucess:String?,_ error:Error?)->Void){
        let employee = employees.filter(id == eid)
        do {
            let update = employee.update([
                fullName <- newEmployee.fullName,
                email <- newEmployee.email,
                image <- newEmployee.image
                ])
            if try db!.run(update) > 0 {
                completionHandeler("Update Employee Successfully",nil)
            }
        } catch {
            print("Update failed: \(error)")
            completionHandeler(nil,error)
        }
    }
}
