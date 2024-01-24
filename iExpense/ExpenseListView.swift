//
//  ExpenseListView.swift
//  iExpense
//
//  Created by Maks Winters on 19.12.2023.
//

import SwiftUI
import SwiftData

struct ExpenseListView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var expenses: [ExpenseItem]
    let showingTypes: [Bool]
    
    var body: some View {
        if containsType(type: "Personal") && showingTypes[0] {
            Section("Personal") {
                ForEach(expenses) { item in
                    let formattedPrice = "\(item.amount.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD")))"
                    if item.type == "Personal" {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.title)
                                Text(item.type)
                            }
                            Spacer()
                            Text(formattedPrice)
                                .foregroundStyle(expenseStyle(item.amount))
                        }
                        .accessibilityElement()
                        .accessibilityLabel("\(item.name), \(formattedPrice)")
                        .accessibilityValue("Personal")
                    }
                }
                .onDelete(perform: removeItems)
            }
        }
        if containsType(type: "Business") && showingTypes[1] {
            Section("Business") {
                ForEach(expenses) { item in
                    let formattedPrice = "\(item.amount.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD")))"
                    if item.type == "Business" {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.title)
                                Text(item.type)
                            }
                            Spacer()
                            Text(formattedPrice)
                                .foregroundStyle(expenseStyle(item.amount))
                        }
                        .accessibilityElement()
                        .accessibilityLabel("\(item.name), \(formattedPrice)")
                        .accessibilityValue("Business")
                    }
                }
                .onDelete(perform: removeItems)
            }
        }
    }
    
    init(sortBy: [SortDescriptor<ExpenseItem>], showingTypes: [Bool]) {
        _expenses = Query(sort: sortBy)
        self.showingTypes = showingTypes
    }
    
    func containsType(type: String) -> Bool {
        var count = 0
        for expense in expenses {
            if expense.type == type {
                count += 1
            }
        }
        if count == 0 {
            return false
        } else {
            return true
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            
            modelContext.delete(expense)
        }
    }
    
}

#Preview {
    List {
        ExpenseListView(sortBy: [
            SortDescriptor(\ExpenseItem.name),
            SortDescriptor(\ExpenseItem.amount)
        ], showingTypes: [true, false])
    }
}
