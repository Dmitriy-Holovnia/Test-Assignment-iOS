//
//  CardMO+CoreDataProperties.swift
//  Test-Assignment-iOS
//
//  Created by cr3w on 16.05.2021.
//
//

import Foundation
import CoreData


extension CardMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardMO> {
        return NSFetchRequest<CardMO>(entityName: "CardMO")
    }

    @NSManaged public var number: Int64

}
