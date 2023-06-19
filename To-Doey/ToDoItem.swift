//
//  ToDoItem.swift
//  To-Doey
//
//  Created by Deonte Kilgore on 6/19/23.
//

import Foundation
import SwiftData
// Create Step 1: Create a class that defines the object you want to persist. *Important* - You must create a class not a struct for SwiftData to work correctly.
@Model
final class ToDoItem {
    var title: String
    var timeStamp: Date
    var isCritical: Bool
    var isCompleted: Bool
    
    init(title: String = "",
         timeStamp: Date = .now,
         isCritical: Bool = false,
         isCompleted: Bool = false) {
        self.title = title
        self.timeStamp = timeStamp
        self.isCritical = isCritical
        self.isCompleted = isCompleted
    }
}
