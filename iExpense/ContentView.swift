//
//  ContentView.swift
//  iExpense
//
//  Created by Maks Winters on 17.11.2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ExpenseItem]
    
    @State private var isSheetShowing = false
    @State var showingTypes = [true, true]
    
    @State private var sortBy = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount)
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ScrollView(.horizontal) {
                    HStack {
                        SortBy(sortBy: $sortBy)
                        ShowTypes(showingTypes: $showingTypes)
                    }
                }
                .scrollIndicators(.hidden)
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                ExpenseListView(sortBy: sortBy, showingTypes: showingTypes)
            }
            .navigationTitle("iExpense")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddExpenseView()
                            .navigationBarBackButtonHidden()
                    } label:{
                        Image(systemName: "plus")
                    }
                }
            }
            //            .sheet(isPresented: $isSheetShowing) {
            //                AddExpenseView(expenses: expenses)
            //                    .presentationDetents([.medium, .large])
            //            }
        }
    }
}

struct SortBy: View {
    @Binding var sortBy: [SortDescriptor<ExpenseItem>]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7)
                .foregroundStyle(.gray.opacity(0.2))
                .frame(height: 35)
            Picker("Sort by", selection: $sortBy) {
                Text("Name")
                    .tag([
                        SortDescriptor(\ExpenseItem.name),
                        SortDescriptor(\ExpenseItem.amount, order: .reverse)
                    ])
                Text("Price")
                    .tag([
                        SortDescriptor(\ExpenseItem.amount, order: .reverse),
                        SortDescriptor(\ExpenseItem.name)
                    ])
            }
        }
    }
}

struct ShowTypes: View {
    @Binding var showingTypes: [Bool]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7)
                .foregroundStyle(.gray.opacity(0.2))
                .frame(height: 35)
            Picker("Show types", selection: $showingTypes) {
                Text("Both")
                    .tag([true, true])
                Text("Personal")
                    .tag([true, false])
                Text("Business")
                    .tag([false, true])
            }
        }
    }
}

#Preview {
    ContentView()
}
