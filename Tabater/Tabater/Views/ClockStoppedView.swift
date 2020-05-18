//
//  ClockStoppedView.swift
//  Tabater
//
//  Created by Marek Žiška on 18/05/2020.
//  Copyright © 2020 Marek Žiška. All rights reserved.
//

import SwiftUI

struct ClockStoppedView: View {
    
    @ObservedObject var timerManager: TimerManager
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        Group{
            ExerciseStatusView(timerManager: timerManager)
            HStack{
                HStack{
                    Image(systemName: "gobackward")
                    Text("Cancel    ")
                        .font(.custom("Helvettica Neue", size: 28))
                }
                .frame(alignment: .center)
                .onTapGesture {
                    self.timerManager.reset()
                }
                HStack{
                    Image(systemName: "checkmark")
                    Text("Finish")
                    .font(.custom("Helvettica Neue", size: 28))
                }
                .frame(alignment: .center)
                .onTapGesture {
                    let exerciseHistory = ExerciseHistory(context: self.managedObjectContext)
                    exerciseHistory.breaksInRound = 0
                    exerciseHistory.exercisedTime = Int32(self.timerManager.stopwatch.exercisedTime)
                    exerciseHistory.date = Date()
                    exerciseHistory.exercisesInRound = Int16(self.timerManager.stopwatch.exerciseCount)
                    exerciseHistory.roundsDone = Int32(self.timerManager.stopwatch.roundCount)
                    exerciseHistory.allRounds = Int16(self.timerManager.stopwatch.selectedRoundsLength)
                    exerciseHistory.allExercises = Int16(self.timerManager.stopwatch.selectedExerciseLength)
                    exerciseHistory.id = UUID()
                    do {
                        try self.managedObjectContext.save()
                        print("exercise saved.")
                        self.viewRouter.currentPage = .mainPage
                        self.timerManager.reset()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            .frame(alignment: .center)
            .padding(.top, 95)
        }
    }
}
