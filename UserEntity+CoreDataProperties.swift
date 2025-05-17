//
//  UserEntity+CoreDataProperties.swift
//  LoginSignUPUIKit
//
//  Created by Subham Patel on 17/05/25.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var name: String?
    @NSManaged public var age: Int16

}

extension UserEntity : Identifiable {

}
