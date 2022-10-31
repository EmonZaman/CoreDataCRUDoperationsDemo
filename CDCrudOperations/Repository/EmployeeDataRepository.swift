//
//  EmployeeDataRepository.swift
//  CDCrudOperations
//
//  Created by Twinbit Limited on 31/10/22.
//

import Foundation
import CoreData

protocol EmployeeRepository{
    
    func create(employee: Employee)
    func getAll() -> [Employee]?
    func get(byIdentifier id: UUID) -> Employee?
    func update(employee: Employee) -> Bool
    func delete(record: Employee) -> Bool
    
}
struct EmployeeDataRepository: EmployeeRepository
{
    func getAll() -> [Employee]? {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject:CDEmployee.self)
        var employees: [Employee] = []
        result?.forEach({(CDEmployee) in employees.append(CDEmployee.convertToEmployee())})
        print(employees)
        return employees
        
    }
    func create(employee: Employee) {
        let cdEmployee = CDEmployee(context: PersistentStorage.shared.context)
        cdEmployee.email = employee.name
        cdEmployee.name = employee.name
        cdEmployee.id = employee.id
        cdEmployee.profilePic = employee.profilePicture
        
    //    cdEmployee.name = "Emon"
        PersistentStorage.shared.saveContext()
    }
    
    func get(byIdentifier id: UUID) -> Employee? {
        
        let result = getCDEmployee(byIdentifier: id)
        guard result != nil else {return nil}
        return result?.convertToEmployee()
    }
    
    func update(employee: Employee) -> Bool {
        let cdEmployee = getCDEmployee(byIdentifier: employee.id)
        guard cdEmployee != nil else {return false}
        cdEmployee?.name = employee.name
        cdEmployee?.email = employee.email
        cdEmployee?.profilePic = employee.profilePicture
        PersistentStorage.shared
            .saveContext()
        return true
        
    }
    
    func delete(record: Employee) -> Bool {
        let cdEmployee = getCDEmployee(byIdentifier: record.id)
        guard cdEmployee != nil else {return false}
        PersistentStorage.shared.context.delete(cdEmployee!)
        return true
    }
    
    private func getCDEmployee(byIdentifier id: UUID) -> CDEmployee?
       {
           let fetchRequest = NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
           let predicate = NSPredicate(format: "id==%@", id as CVarArg)

           fetchRequest.predicate = predicate
           do {
               let result = try PersistentStorage.shared.context.fetch(fetchRequest).first

               guard result != nil else {return nil}

               return result

           } catch let error {
               debugPrint(error)
           }

           return nil
       }
    
    
}
