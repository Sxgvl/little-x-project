//
//  Like+CoreDataProperties.swift
//  little-x-project
//
//  Created by Segal GBENOU on 19/01/2025.
//
//

import Foundation
import CoreData


extension Like {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Like> {
        return NSFetchRequest<Like>(entityName: "Like")
    }

    @NSManaged public var date: Date?
    @NSManaged public var user: User?

}

extension Like : Identifiable {

}
