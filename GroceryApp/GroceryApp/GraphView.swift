//
//  GraphView.swift
//  GroceryApp
//
//  Created by Randima Dilshan on 2024-11-29.
//

import SwiftUI
import Charts

struct GraphView: View {
    var groceryItems: [GroceryItem]

    var groupedData: [(String, Int)] {
        Dictionary(grouping: groceryItems, by: { $0.groceryName })
            .map { ($0.key, $0.value.count) }
            .sorted { $0.1 > $1.1 } // Sort by count
    }

    var inCartData: [(String, Int)] {
        Dictionary(grouping: groceryItems.filter { $0.isInCart }, by: { $0.groceryName })
            .map { ($0.key, $0.value.count) }
            .sorted { $0.1 > $1.1 } // Sort by count
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Items per Grocery Category")
                    .font(.title2)
                    .padding(.top, 20)

                Chart(groupedData, id: \.0) { category, count in
                    BarMark(
                        x: .value("Category", category),
                        y: .value("Count", count)
                    )
                    .foregroundStyle(.blue)
                }
                .frame(height: 300)
                .padding()

                Divider()

                Text("Items in Cart")
                    .font(.title2)
                    .padding(.top, 20)

                Chart(inCartData, id: \.0) { category, count in
                    BarMark(
                        x: .value("Category", category),
                        y: .value("Count", count)
                    )
                    .foregroundStyle(.green)
                }
                .frame(height: 300)
                .padding()
            }
            .padding()
        }
        .navigationTitle("Graphs")
    }
}
