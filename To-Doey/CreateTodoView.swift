//
//  CreateTodoView.swift
//  To-Doey
//
//  Created by Deonte Kilgore on 6/19/23.
//

import SwiftUI

struct CreateTodoView: View {
    @Environment(\.dismiss) var dismiss
    
    // Create Step 5: Create a pointer to the model context to handle CRUD operations.
    @Environment(\.modelContext) var context
    
    // Create Step 3: Create a state property to add an instance of a toDoItem to the view.
    @State private var item = ToDoItem()
    
    var body: some View {
        List {
            // Read Step 4: Wire up the item to the view.

            TextField("Name", text: $item.title)
            DatePicker("Choose Date",
                       selection: $item.timeStamp)
            Toggle("Important?", isOn: $item.isCritical)
            Button("Create") {
                // Read Step 6: SwiftData automatically saves so all we are responsible for inserting the item into the context.
                withAnimation {
                    context.insert(item)
                }
                
                dismiss()
            }
        }
        .navigationTitle("Create To-Do")
    }
}

#Preview {
    CreateTodoView()
    // Step 3 Cont'd: Add a model container to the preview, this clears the error causing the preview to crash.
        .modelContainer(for: ToDoItem.self)
}
