//
//  ContentView.swift
//  iDine
//
//  Created by A.Hazzaa on 19/03/2024.
//

import SwiftUI

struct ContentView: View {
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    var body: some View {
        NavigationStack {
            List {
                ForEach(menu) { section in
                    Section(section.name) {
                        ForEach(section.items) { item in
                            NavigationLink(value: item) {
                                ItemRow(item: item)
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: MenuItem.self, destination: { item in
                ItemDetails(item: item)
            })
            .navigationTitle("Menu")
            .listStyle(.grouped)
        }
    }
}

#Preview {
    ContentView()
}
