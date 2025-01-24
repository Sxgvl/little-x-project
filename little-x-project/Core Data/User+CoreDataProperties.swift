//
//  User+CoreDataProperties.swift
//  little-x-project
//
//  Created by Segal GBENOU on 24/01/2025.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var userName: String?
    @NSManaged public var profileImageURL: String?
    @NSManaged public var follows: NSSet?
    @NSManaged public var posts: NSSet?

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

// MARK: Generated accessors for posts
extension User {

    @objc(addPostsObject:)
    @NSManaged public func addToPosts(_ value: Post)

    @objc(removePostsObject:)
    @NSManaged public func removeFromPosts(_ value: Post)

    @objc(addPosts:)
    @NSManaged public func addToPosts(_ values: NSSet)

    @objc(removePosts:)
    @NSManaged public func removeFromPosts(_ values: NSSet)

}

extension User : Identifiable {

}
