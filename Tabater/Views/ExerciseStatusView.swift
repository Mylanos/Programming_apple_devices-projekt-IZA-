//
//  ExerciseStatusView.swift
//  Tabater
//
//  Created by Marek Žiška on 18/05/2020.
//  Copyright © 2020 Marek Žiška. All rights reserved.
//

import SwiftUI

// zobrazuje kolko cviceni a kôl bolo už dokončených
struct ExerciseStatusView: View {
    
    @ObservedObject var timerManager: TimerManager
    
    var body: some View {
        VStack{
            Section{
                HStack{
                    Text("Exercise " + timerManager.stopwatch.getExercisesStatusString())
                        .font(.custom("Helvettica Neue", size: 20))
                }
                .padding(.bottom, 20)
                HStack{
                    Text("Rounds " + timerManager.stopwatch.getRoundsStatusString())
                        .font(.custom("Helvettica Neue", size: 20))
                }
            }
        }
    }
}
