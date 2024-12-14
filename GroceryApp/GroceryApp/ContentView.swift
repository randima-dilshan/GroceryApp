//
//  ContentView.swift
//  GroceryApp
//
//  Created by IM Student on 2024-11-26.
//

import SwiftUI

struct ContentView: View {
    @State private var groceryItems: [GroceryItem] = []
    @State private var newItemName: String = ""
    @State private var newGroceryName: String = ""
    @State private var showingAddItemAlert = false
    @State private var editingItem: GroceryItem? = nil
    @State private var editedItemName: String = ""

    var groupedItems: [String: [GroceryItem]] {
        Dictionary(grouping: groceryItems, by: { $0.groceryName })
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(groupedItems.keys.sorted(), id: \.self) { groceryName in
                    Section(header: Text(groceryName)) {
                        ForEach(groupedItems[groceryName] ?? []) { item in
                            HStack {
                                Text(item.name)
                                    .font(.headline)
                                Spacer()
                                if item.isInCart {
                                    Text("In Cart")
                                        .foregroundColor(.green)
                                        .font(.subheadline)
                                }
                                Button(action: {
                                    toggleCart(item: item)
                                }) {
                                    Image(systemName: item.isInCart ? "cart.fill" : "cart")
                                        .foregroundColor(.blue)
                                }
                            }
                            .contextMenu {
                                Button("Edit") {
                                    startEditing(item: item)
                                }
                                Button("Delete", role: .destructive) {
                                    deleteItem(item: item)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Grocery List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button(action: { showingAddItemAlert = true }) {
                            Image(systemName: "plus")
                        }
                        NavigationLink(destination: GraphView(groceryItems: groceryItems)) {
                            Image(systemName: "chart.bar.xaxis")
                        }
                    }
                }
            }
            .alert("Add New Item", isPresented: $showingAddItemAlert) {
                VStack {
                    TextField("Item Name", text: $newItemName)
                    TextField("Grocery Name", text: $newGroceryName)
                }
                Button("Add", action: addItem)
                Button("Cancel", role: .cancel, action: { showingAddItemAlert = false })
            } message: {
                Text("Enter the name of the item and its grocery category")
            }
            .alert("Edit Item", isPresented: Binding<Bool>(
                get: { editingItem != nil },
                set: { if !$0 { editingItem = nil } }
            )) {
                VStack {
                    TextField("Item Name", text: $editedItemName)
                }
                Button("Save") {
                    saveEditedItem()
                }
                Button("Cancel", role: .cancel) {
                    editingItem = nil
                }
            } message: {
                Text("Update the name of the item")
            }
        }
    }

    // MARK: - Helper Functions

    private func addItem() {
        guard !newItemName.isEmpty, !newGroceryName.isEmpty else { return }
        let newItem = GroceryItem(name: newItemName, groceryName: newGroceryName)
        groceryItems.append(newItem)
        newItemName = ""
        newGroceryName = ""
        showingAddItemAlert = false
    }

    private func deleteItem(item: GroceryItem) {
        groceryItems.removeAll { $0.id == item.id }
    }

    private func toggleCart(item: GroceryItem) {
        if let index = groceryItems.firstIndex(where: { $0.id == item.id }) {
            groceryItems[index].isInCart.toggle()
        }
    }

    private func startEditing(item: GroceryItem) {
        editingItem = item
        editedItemName = item.name // Pre-fill with the current name
    }

    private func saveEditedItem() {
        guard let editingItem = editingItem else { return }
        if let index = groceryItems.firstIndex(where: { $0.id == editingItem.id }) {
            groceryItems[index].name = editedItemName // Update the name
        }
        self.editingItem = nil // Dismiss the editing dialog
    }
}

// MARK: - Model
struct GroceryItem: Identifiable {
    let id = UUID()
    var name: String
    var groceryName: String
    var isFavorite: Bool = false
    var isInCart: Bool = false
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
