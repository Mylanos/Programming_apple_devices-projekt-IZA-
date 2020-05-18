//
//  HistoryView.swift
//  Tabater
//
//  Created by Marek Žiška on 18/05/2020.
//  Copyright © 2020 Marek Žiška. All rights reserved.
//

import SwiftUI
import CoreData

//zobrazuje hostoriu treningov
struct HistoryView: View {
    // true ak bolo poziadane o zobrazenie blizsieho infa o treningu
    @State var showExerciseSheet = false
    
    // vyuzite na ulozenie si indexu pozadovaneho elementu v liste záznamov z CoreData
    @ObservedObject var viewRouter: ViewRouter
    
    // vyuzite pre delete jednotlivych zaznamov z CoreData
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // nahravanie dat z CoreData
    @FetchRequest(entity: ExerciseHistory.entity(),
                  sortDescriptors: [])
    var exercises: FetchedResults<ExerciseHistory>
    
    // extension s pozadovanym formatom
    var dateFormatter = DateFormatter()
    
    var body: some View {
            // list všektých záznamov
            List {
                // enumeratedArray -> extension transformuje pole na tuple, dvojica index element
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
                            self.showExerciseSheet.toggle()
                        })
                        
                    }
                // zmaze zaznam pri dragu nad zaznamom v liste
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        print(index)
                        self.managedObjectContext.delete(self.exercises[index])
                    }
                }
            // zobrazenie sheetu ak bol rozkliknuty niektory zo zaznamov
            }
            .sheet(isPresented: $showExerciseSheet) {
                ExerciseSheet(viewRouter: self.viewRouter, exercises: self.exercises).environment(\.managedObjectContext, self.managedObjectContext)
            }
        
    }
}
