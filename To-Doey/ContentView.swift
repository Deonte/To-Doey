//
//  ContentView.swift
//  To-Doey
//
//  Created by Deonte Kilgore on 6/19/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    // Delete Step 8: Add the model context to view.
    @Environment(\.modelContext) var context
    @State private var showCreate = false
    // Create a property to hold the selected item that needs the edit.
    @State private var todoEdit: ToDoItem?
    
    
    @Query(
        // Filter: the following will only show incomplete items
        filter: #Predicate { $0.isCompleted == false },
        // Sort: sorting by the timestamp
        sort: \.timeStamp,
        order: .forward
    ) private var items: [ToDoItem] // Step 7: Read the data
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    ToDoItemCell(item: item)
                        .swipeActions {
                            Button(role: .destructive) {
                                withAnimation {
                                    // Delete Step 8 cont'd: Call delete on the item in context.
                                    context.delete(item)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                                    .symbolVariant(.fill)
                            }
                            // Create a new swipe action to that assigns the item to the optional variable we created earlier.
                            Button{
                                // Assign the item to the variable
                               todoEdit = item
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.orange)
                        }
                }
            }
            .navigationTitle("To-Doey")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        showCreate.toggle()
                    }, label: {
                        Label("Add Item",
                              systemImage: "plus")
                    })
                }
            }
            .sheet(isPresented: $showCreate, content: {
                NavigationStack {
                    CreateTodoView()
                }
                .presentationDetents([.medium])
            })
            // Add a new sheet that toggles once the "todoEdit" optional has been assigned.
            .sheet(item: $todoEdit, onDismiss: {
                // Once the edit has been the done and the update button has been pressed, it sets the optional back to nil.
                todoEdit = nil
            }) { item in
                UpdateTodoView(item: item)
            }
        }
    }
}

#Preview {
    ContentView()
}

struct ToDoItemCell: View {
    var item: ToDoItem
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                if item.isCritical {
                    Image(systemName: "exclamationmark.3")
                        .symbolVariant(.fill)
                        .foregroundColor(.red)
                        .font(.largeTitle)
                        .bold()
                }
                
                Text(item.title)
                    .font(.largeTitle)
                    .bold()
                
                Text("\(item.timeStamp, format: Date.FormatStyle(date: .numeric,time: .shortened))")
                    .font(.callout)
            }
            
            Spacer()
            
            Button {
                // Update: Simple
                withAnimation {
                    item.isCompleted.toggle()
                }
            } label: {
                Image(systemName: "checkmark")
                    .symbolVariant(.circle.fill)
                    .foregroundStyle(item.isCompleted ? .green : .gray)
                    .font(.largeTitle)
            }
            .buttonStyle(.plain)
        }
    }
}
