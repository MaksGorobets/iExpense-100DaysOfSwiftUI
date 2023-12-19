//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Maks Winters on 17.11.2023.
//

import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
