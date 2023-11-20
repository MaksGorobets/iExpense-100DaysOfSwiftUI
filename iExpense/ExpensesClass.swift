//
//  ExpensesClass.swift
//  iExpense
//
//  Created by Maks Winters on 19.11.2023.
//

import Foundation
import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() { didSet {
        if let newData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(newData, forKey: "Expenses")
        }
    }}
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "Expenses") {
            if let decodedData = try? JSONDecoder().decode([ExpenseItem].self, from: data) {
                items = decodedData
                return
            }
        }
        items = []
    }
}

func expenseStyle(_ amount: Double) -> Color {
    if amount <= 2000 {
        .green
    } else if amount <= 5000{
        .orange
    } else {
        .red
    }
}
