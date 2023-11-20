//
//  AddExpenseView.swift
//  iExpense
//
//  Created by Maks Winters on 19.11.2023.
//

import SwiftUI

struct AddExpenseView: View {
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    var expenses: Expenses
    
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
            .navigationTitle("Add expense")
            .toolbar {
                Button("Save") {
                    saveExpense()
                    dismiss()
                }
            }
            .presentationBackground(.ultraThickMaterial)
        }
    }
    
    func saveExpense() {
        guard name != "" else {
            return
        }
        let newExpense = ExpenseItem(name: name, type: type, amount: amount)
        expenses.items.append(newExpense)
    }
    
}

#Preview {
    AddExpenseView(expenses: Expenses())
}
