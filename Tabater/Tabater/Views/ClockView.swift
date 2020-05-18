//
//  ClockView.swift
//  Tabater
//
//  Created by Marek Žiška on 15/05/2020.
//  Copyright © 2020 Marek Žiška. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct ClockView: View {

    @ObservedObject var timerManager: TimerManager
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @ObservedObject var viewRouter: ViewRouter

    
    var body: some View {
            VStack {
                TimerView(timerManager: timerManager)
                // view ak je casovac pozastaveny
                if timerManager.timerMode == .stopped {
                    ClockStoppedView(timerManager: timerManager, viewRouter: self.viewRouter)
                        .environment(\.managedObjectContext, self.managedObjectContext)
                }
                // view ak je casovac v pociatocnom mode, nezacalo cvicenie
                else if timerManager.timerMode == .initial {
                    ClockInitialView(timerManager: timerManager)
                }
                // view ak casovac zapocal, zacalo cvicenie
                else if timerManager.timerMode == .running{
                    ClockContinuesView(timerManager: timerManager, viewRouter: self.viewRouter)
                        .environment(\.managedObjectContext, self.managedObjectContext)
                }
                // view ak casoval zapocal, prebieha prestavka
                else if timerManager.timerMode == .resting{
                    ClockContinuesView(timerManager: timerManager, viewRouter: self.viewRouter)
                    .environment(\.managedObjectContext, self.managedObjectContext)
                }
                Spacer()
            }
    }
}
