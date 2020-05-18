//
//  HistoryView.swift
//  Tabater
//
//  Created by Marek Žiška on 18/05/2020.
//  Copyright © 2020 Marek Žiška. All rights reserved.
//

import SwiftUI
import CoreData

struct HistoryView: View {
    @State var showOrderSheet = false
    
    @ObservedObject var viewRouter: ViewRouter
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: ExerciseHistory.entity(),
                  sortDescriptors: [])
    
    var exercises: FetchedResults<ExerciseHistory>
        
    var dateFormatter = DateFormatter()
    
    var body: some View {
            
            List {
                ForEach(exercises.enumeratedArray(), id: \.element) { index, item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Exercise: \(self.dateFormatter.getStringCustomFormat(date: item.date))")
                                .font(.headline)
                            Text("Progression:  Rounds: \(item.roundsDone) / \(item.allRounds)\n\t\t\t  Exercises: \(item.exercisesInRound) / \(item.allExercises)")
                                .font(.subheadline)
                        }
                        Spacer()
                        
                        Button("Info", action: {
                            self.viewRouter.selExercIndex = index
                            print("Open order sheet ")
                            self.showOrderSheet.toggle()
                        })
                        
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        print(index)
                        self.managedObjectContext.delete(self.exercises[index])
                    }
                }
            }
            .sheet(isPresented: $showOrderSheet) {
                OrderSheet(viewRouter: self.viewRouter, exercises: self.exercises).environment(\.managedObjectContext, self.managedObjectContext)
            }
        
    }
}
