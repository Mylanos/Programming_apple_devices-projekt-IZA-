//
//  ClockContinuesView.swift
//  Tabater
//
//  Created by Marek Žiška on 18/05/2020.
//  Copyright © 2020 Marek Žiška. All rights reserved.
//

import SwiftUI

// view obsahuje odpocet z celkovej dlzky casu cvicenia a informuje o stave splnenia cviceni
struct ClockContinuesView: View {
    
    @ObservedObject var timerManager: TimerManager
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        Group{
            ExerciseStatusView(timerManager: timerManager)
            HStack{
                Text("Time Remaining:")
                    .font(.custom("Helvettica Neue", size: 28))
                Text(timerManager.stopwatch.getDurationTimeString())
                    .font(.custom("Helvettica Neue", size: 32))
            }
            .frame(alignment: .center)
            .padding(.top, 100)
        }
    }
}
