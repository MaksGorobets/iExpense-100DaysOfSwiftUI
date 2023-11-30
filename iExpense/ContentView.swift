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
                Section("Personal") {
                    ForEach(expenses.items) { item in
                        if item.type == "Personal" {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.title)
                                    Text(item.type)
                                }
                                Spacer()
                                Text("\(item.amount.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD")))")
                                    .foregroundStyle(expenseStyle(item.amount))
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                Section("Business") {
                    ForEach(expenses.items) { item in
                        if item.type == "Business" {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.title)
                                    Text(item.type)
                                }
                                Spacer()
                                Text("\(item.amount.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD")))")
                                    .foregroundStyle(expenseStyle(item.amount))
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink {
                    AddExpenseView(expenses: expenses)
                        .navigationBarBackButtonHidden()
                } label:{
                    Image(systemName: "plus")
                }
            }
//            .sheet(isPresented: $isSheetShowing) {
//                AddExpenseView(expenses: expenses)
//                    .presentationDetents([.medium, .large])
//            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
