//
//  CDEmployee+CoreDataProperties.swift
//  CDCrudOperations
//
//  Created by Twinbit Limited on 31/10/22.
//
//

import Foundation
import CoreData


extension CDEmployee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEmployee> {
        return NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var profilePic: Data?
    @NSManaged public var email: String?
    
    func convertToEmployee() -> Employee
      {
          return Employee(name: self.name, email: self.email, profilePicture: self.profilePic, id: self.id!)
      }

}

extension CDEmployee : Identifiable {

}
