//
//  User+CoreDataProperties.swift
//  CoredataTest
//
//  Created by Yuni on 2019/5/20.
//  Copyright © 2019 Yuni. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?

}
