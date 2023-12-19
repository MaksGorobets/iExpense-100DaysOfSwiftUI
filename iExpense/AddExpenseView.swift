//
//  AddExpenseView.swift
//  iExpense
//
//  Created by Maks Winters on 19.11.2023.
//

import SwiftUI
import SwiftData

struct AddExpenseView: View {
    @Environment(\.modelContext) var modelContext
    @State private var name = "Name it here!"
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    @Query var expenses: [ExpenseItem]
    
    let types = ["Personal", "Business"]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name your expense", text: $name)
                
                Picker("Pick a type", selection: $type) {
                    ForEach(types, id: \.self) { type in
                        Text(type)
                    }
                }
                TextField("Enter amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .foregroundStyle(expenseStyle(amount))
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button("Save") {
                        saveExpense()
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel", role: .destructive) {
                        dismiss()
                    }
                }
            }
        }
    }
    
    func saveExpense() {
        guard name != "" else {
            return
        }
        let newExpense = ExpenseItem(name: name, type: type, amount: amount)
        modelContext.insert(newExpense)
    }
    
}

#Preview {
    AddExpenseView()
}
