//
//  EmoloyeeManagers.swift
//  CDCrudOperations
//
//  Created by Twinbit Limited on 31/10/22.
//
import Foundation

struct EmployeeManager
{
    private let _employeeDataRepository = EmployeeDataRepository()

    func createEmployee(employee: Employee) {
        _employeeDataRepository.create(employee: employee)
    }

    func fetchEmployee() -> [Employee]? {
        return _employeeDataRepository.getAll()
    }

    func fetchEmployee(byIdentifier id: UUID) -> Employee?
    {
        return _employeeDataRepository.get(byIdentifier: id)
    }

    func updateEmployee(employee: Employee) -> Bool {
        return _employeeDataRepository.update(employee: employee)
    }

    func deleteEmployee(employee: Employee) -> Bool {
        return _employeeDataRepository.delete(record: employee)
    }
}
