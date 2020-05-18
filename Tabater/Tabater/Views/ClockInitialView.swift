//
//  ClockInitialView.swift
//  Tabater
//
//  Created by Marek Žiška on 18/05/2020.
//  Copyright © 2020 Marek Žiška. All rights reserved.
//

import SwiftUI

// view ma na starosti moznosti cvicenia
struct ClockInitialView: View {
    
    @ObservedObject var timerManager: TimerManager
    
    let timeLength = Array(0...180)
    let roundsCount = Array(0...30)
    
    var body: some View {
        Form{
            Picker("Exercise time", selection: $timerManager.selectionExerciseLength){
                ForEach(timeLength, id: \.self){ length in
                    Text("\(length) sec")
                }
            }
            Picker("Exercises", selection: $timerManager.selectionExercisesCount){
                ForEach(roundsCount, id: \.self){ length in
                    Text("\(length) exercises")
                }
            }
            Picker("Rest time", selection: $timerManager.selectionRestLength){
                ForEach(timeLength, id: \.self){ length in
                    Text("\(length) sec")
                }
            }
            Picker("Rounds", selection: $timerManager.selectionRoundsLength){
                ForEach(roundsCount, id: \.self){ rounds in
                    Text("\(rounds) rounds")
                }
            }
            
            }
        .moveDisabled(true)
    
    }
}
