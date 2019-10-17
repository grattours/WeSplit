//
//  ContentView.swift
//  WeSplit
//
//  Created by Luc Derosne on 16/10/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let orderAmount = Double(checkAmount) ?? 0
        let tipSelection = Double(tipPercentages[tipPercentage])
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var bigTotal: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        return orderAmount * (1 + tipSelection / 100)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Montant", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Nombre de personnes", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) personnes")
                        }
                    // bonus 3 type de clavier adapté
                    }.keyboardType(.numberPad)
                }
                Section(header: Text("Combien de pourboire voulez vous laissez ?")) {
                    Picker("% de pourboire", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                // bonus 1 entête de section
                Section(header: Text("Total par personnes")) {
                    Text(" \(totalPerPerson, specifier: "%.2f") €")
                }
                // bonus 2 Montant total à partager
                Section(header: Text("Montant total avec le pourboire")) {
                    Text("\(bigTotal, specifier: "%.2f") €")
                }
                
            }.navigationBarTitle("Partage d'addition")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

