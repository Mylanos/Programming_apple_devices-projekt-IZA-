//
//  ProgressBarView.swift
//  Tabater
//
//  Created by Marek Žiška on 19/05/2020.
//  Copyright © 2020 Marek Žiška. All rights reserved.
//

import SwiftUI

struct ProgressBarView: View {
    
    @ObservedObject var timerManager: TimerManager
    
    var body: some View {
         VStack {
                   ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.gray)
                            .frame(width: 300, height: 20)
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(timerManager.timerMode != .resting ? .blue : .yellow)
                            .frame(width: 300*timerManager.currentProgress, height: 20)
                   }
               }
    }
}

