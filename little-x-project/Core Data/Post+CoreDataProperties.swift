//
//  Post+CoreDataProperties.swift
//  little-x-project
//
//  Created by Segal GBENOU on 19/01/2025.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var author: User?
    @NSManaged public var likes: NSSet?

}

// MARK: Generated accessors for likes
extension Post {

    @objc(addLikesObject:)
    @NSManaged public func addToLikes(_ value: User)

    @objc(removeLikesObject:)
    @NSManaged public func removeFromLikes(_ value: User)

    @objc(addLikes:)
    @NSManaged public func addToLikes(_ values: NSSet)

    @objc(removeLikes:)
    @NSManaged public func removeFromLikes(_ values: NSSet)

}

extension Post : Identifiable {

}
