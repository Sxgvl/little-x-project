//
//  User+CoreDataProperties.swift
//  little-x-project
//
//  Created by Segal GBENOU on 23/01/2025.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var userName: String?
    @NSManaged public var profileImageURL: URL?
    @NSManaged public var follows: NSSet?

}

// MARK: Generated accessors for follows
extension User {

    @objc(addFollowsObject:)
    @NSManaged public func addToFollows(_ value: User)

    @objc(removeFollowsObject:)
    @NSManaged public func removeFromFollows(_ value: User)

    @objc(addFollows:)
    @NSManaged public func addToFollows(_ values: NSSet)

    @objc(removeFollows:)
    @NSManaged public func removeFromFollows(_ values: NSSet)

}

extension User : Identifiable {

}
