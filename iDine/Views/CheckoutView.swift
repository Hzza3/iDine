//
//  CheckoutView.swift
//  iDine
//
//  Created by A.Hazzaa on 19/03/2024.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var order: Order
    
    @State private var paymentType = "Cash"
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var tipAmount = 15
    @State private var showingAlert = false
    
    let paymentTypes = ["Cash", "Credit Card", "iDine Points"]
    let tipAmounts = [10, 15, 20, 25, 0]
    var totalAmount: String {
        var total = Double(order.total)
        let tipValue = total / 100 * Double(tipAmount)
        return (total + tipValue).formatted(.currency(code: "USD"))
    }
    var body: some View {
        Form {
            Section {
                Picker("How do you want to pay?", selection: $paymentType) {
                    ForEach(paymentTypes, id: \.self) {
                        Text($0)
                    }
                }
                Toggle("Add iDine Loyalty Card", isOn: $addLoyaltyDetails.animation())
                if addLoyaltyDetails {
                    TextField("Enter your iDine ID", text: $loyaltyNumber)
                    
                }
            }
            Section("Add a tip?") {
                Picker("Percentage", selection: $tipAmount) {
                    ForEach(tipAmounts, id: \.self) {
                        Text("\($0)%")
                    }
                }.pickerStyle(.segmented)
            }
            Section("Total: \(totalAmount)") {
                Button("Confirm Order") {
                    showingAlert.toggle()
                }
            }
        }
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Order Confirmed", isPresented: $showingAlert) {
            
        } message: {
            Text("Your total was \(totalAmount) – thank you")
        }
    }
}

#Preview {
    CheckoutView()
        .environmentObject(Order())
}
