//
//  TimerView.swift
//  Tabater
//
//  Created by Marek Žiška on 18/05/2020.
//  Copyright © 2020 Marek Žiška. All rights reserved.
//

import SwiftUI

// view ma na starosti odpocet a obsahuje button na spustenie casovaca
struct TimerView: View {
    
    @ObservedObject var timerManager: TimerManager
    
    var body: some View {
        Group{
          /*  GeometryReader { geometry in
                ZStack {
                    Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                        .opacity(0.3)
                        .foregroundColor(Color(UIColor.systemTeal))
                }.cornerRadius(45.0)
            }
            */
            // Text zobrazuje text na zaklade aktualneho modu casovaca
            Text(self.timerManager.stateExerciseDescription)
                .font(.custom("Helvettica Neue", size: 28))
                .padding(.bottom, 30)
                .padding(.top, 40)
            
            // Aktualny cas, pred zacatim casovaca je urcena celkova dlzka cvicenia, po zapocati prebieho odpocet od 0
            Text(timerManager.timerMode != .initial ? timerManager.stopwatch.getTimeString() : timerManager.stopwatch.getDurationTimeString())
                .font(.custom("Helvettica Neue", size: 80))
            
            // Obrazok na zapocatie casovaca
            Image(systemName: timerManager.timerMode == .running || timerManager.timerMode == .resting ? "pause.circle.fill" : "play.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.bottom, 20)
                .frame(width: 170, height: 160)
                .foregroundColor(.blue)
                .onTapGesture{
                    (self.timerManager.timerMode == .running || self.timerManager.timerMode == .resting) ? self.timerManager.pause() : self.timerManager.start()
                    
                }
        }
    }
}
