//
//  OrderSheet.swift
//  Tabater
//
//  Created by Marek Žiška on 18/05/2020.
//  Copyright © 2020 Marek Žiška. All rights reserved.
//

import SwiftUI

struct OrderSheet: View {
       
    let pizzaTypes = ["Pizza Margherita", "Greek Pizza", "Pizza Supreme", "Pizza California", "New York Pizza"]
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @ObservedObject var viewRouter: ViewRouter
    
    var exercises: FetchedResults<ExerciseHistory>
    
    var dateFormatter = DateFormatter()
    
    @State var selectedPizzaIndex = 1
    @State var numberOfSlices = 1
    @State var tableNumber = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Stats")) {
                    Text("Date: " + self.dateFormatter.getStringCustomFormat(date: self.exercises[self.viewRouter.selExercIndex].date))
                    Text("Exercised for: \(self.exercises[self.viewRouter.selExercIndex].exercisedTime / 60) minutes and \(self.exercises[self.viewRouter.selExercIndex].exercisedTime % 60) seconds.")
                }
                
                Section(header: Text("Health")) {
                    Text("Burned " + String(self.exercises[self.viewRouter.selExercIndex].exercisedTime / 40) + " calories." )
                    
                }
                
                Button(action: {
                    print("Load this exercise!")
                }) {
                    Text("Continue in this exercise")
                }.navigationBarTitle("Exercise data")
                
            }
        }
    }
}
