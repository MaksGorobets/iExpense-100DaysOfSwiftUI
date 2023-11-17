//
//  ContentView.swift
//  iExpense
//
//  Created by Maks Winters on 17.11.2023.
//

import SwiftUI

struct User: Codable, Hashable {
    var name: String
    var secondName: String
}

struct ContentView: View {
    
    @State private var users = [User]()
    @State private var showingSheet = false
    
    @State private var newName = ""
    @State private var newSecondName = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(users, id: \.self) {
                    Text("\($0.name) \($0.secondName)")
                }
                .onDelete(perform: deleteItem)
            }
                Button("Add a person") {
                    showingSheet.toggle()
                }
            .sheet(isPresented: $showingSheet) {
                Spacer()
                VStack {
                    TextField("Enter a name", text: $newName)
                    TextField("Enter a second name", text: $newSecondName)
                }
                .padding()
                Spacer()
                Button("Done") {
                    showingSheet = false
                    users.append(User(name: newName, secondName: newSecondName))
                }
            }
            .navigationTitle("iExpense Testing")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                EditButton()
                Button("Save all") {
                    saveData()
                }
            }
        }
        .onAppear {
            loadData()
        }
    }
    
    func deleteItem(on offsets: IndexSet) {
        users.remove(atOffsets: offsets)
    }
    
    func saveData() {
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(users) {
            UserDefaults.standard.set(data, forKey: "data")
        }
    }
    
    func loadData() {
        let decoder = JSONDecoder()
        
        if let data = UserDefaults.standard.data(forKey: "data"),
           let decoded = try? decoder.decode([User].self, from: data) {
            users = decoded
        }
    }
    
}

#Preview {
    ContentView()
}
