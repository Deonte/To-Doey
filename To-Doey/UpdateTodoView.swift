//
//  UpdateTodoView.swift
//  To-Doey
//
//  Created by Deonte Kilgore on 6/19/23.
//

import SwiftUI
import SwiftData
// Update: In SwiftData you simply need to create a new view to handle the edit of the item.
struct UpdateTodoView: View {
    @Environment(\.dismiss) var dismiss
    
    // Create a bindable to the expected object to edit.
    @Bindable var item: ToDoItem
    
    var body: some View {
        NavigationStack {
            List {
                TextField("Name", text: $item.title)
                DatePicker("Choose Date",
                           selection: $item.timeStamp)
                Toggle("Important?", isOn: $item.isCritical)
                Button("Update") {
                    dismiss()
                }
            }
            .navigationTitle("Update To-Do")
        }
    }
}
