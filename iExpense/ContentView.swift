//
//  ContentView.swift
//  iExpense
//
//  Created by Maks Winters on 17.11.2023.
//

import SwiftUI


struct ContentView: View {
    
let expenses = Expenses()
    
@State private var isSheetShowing = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.title)
                            Text(item.type)
                        }
                        Spacer()
                        Text("\(item.amount.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD")))")
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("New expense", systemImage: "plus") {
                    isSheetShowing.toggle()
                }
            }
            .sheet(isPresented: $isSheetShowing) {
                AddExpenseView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
}

#Preview {
    ContentView()
}
