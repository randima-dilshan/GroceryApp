//
//  GroceryItem.swift
//  GroceryApp
//
//  Created by IM Student on 2024-11-26.
//

import Foundation

struct MyGroceryItem: Identifiable {
    let id = UUID()
    var name: String // Item name
    var groceryName: String // Grocery category name
    var isInCart: Bool = false // Default value
}
