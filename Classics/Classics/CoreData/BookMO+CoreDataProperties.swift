//
//  BookMO+CoreDataProperties.swift
//  Classics
//
//  Created by Albert Kornas on 10/31/20.
//

import Foundation
import CoreData


extension BookMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookMO> {
        return NSFetchRequest<BookMO>(entityName: "BookMO")
    }

    @NSManaged public var author: String
    @NSManaged public var country: String
    @NSManaged public var image: String
    @NSManaged public var language: String
    @NSManaged public var link: String
    @NSManaged public var pages: Int
    @NSManaged public var title: String
    @NSManaged public var year: String

}
