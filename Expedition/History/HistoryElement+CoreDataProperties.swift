//
//  HistoryElement+CoreDataProperties.swift
//  Expedition
//
//  Created by Julian Wright on 1/8/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//
//

import Foundation
import CoreData


extension HistoryElement {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryElement> {
        return NSFetchRequest<HistoryElement>(entityName: "HistoryElement")
    }

    @NSManaged public var url: String?
    @NSManaged public var title: String?

}
