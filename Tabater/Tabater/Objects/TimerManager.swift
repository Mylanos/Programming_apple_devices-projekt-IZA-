//
//  TimerManager.swift
//  Tabater
//
//  Created by Marek Žiška on 15/05/2020.
//  Copyright © 2020 Marek Žiška. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

enum timerMode{
    case running
    case stopped
    case initial
    case resting
}

// ma na starosti obsluhu spojenu s casom, informuje odoberatelov o zmenach casu apod.
class TimerManager: ObservableObject {

    // mod casovaca
    @Published var timerMode: timerMode {
        didSet{
            if(timerMode == .running || timerMode == .stopped){
                stateExerciseDescription = "Exercise!"
            }
            else if(timerMode == .resting) {
                stateExerciseDescription = "Rest!"
            }
            else{
                stateExerciseDescription = "Setup your exercise!"
            }
        }
    }
    
    // uklada si
    @Published var stopwatch: TimeStopwatch
    
    @Published var stateExerciseDescription: String
        
    var selectionExerciseLength: Int {
        didSet {
            stopwatch.selectedExerciseLength = selectionExerciseLength
            stopwatch.calculateTrainingDuration()
            print("Exercise selection changed to \(selectionExerciseLength)")
            
        }
    }
    var selectionExercisesCount: Int {
        didSet {
            stopwatch.selectedExercisesCount = selectionExercisesCount
            stopwatch.calculateTrainingDuration()
            print("Exercise selection changed to \(selectionExerciseLength)")
            
        }
    }
    var selectionRestLength: Int {
        didSet {
            stopwatch.selectedRestLength = selectionRestLength
            stopwatch.calculateTrainingDuration()
            print("Rest selection changed to \(selectionRestLength)")
        }
    }
    var selectionRoundsLength: Int {
        didSet {
            stopwatch.selectedRoundsLength = selectionRoundsLength
            stopwatch.calculateTrainingDuration()
            print("Rounds selection changed to \(selectionRoundsLength)")
        }
    }

    var timer: Timer
    
    init() {
        self.timerMode = .initial
        self.timer = Timer()
        self.stopwatch = TimeStopwatch()
        self.selectionExerciseLength = 20
        self.selectionRestLength = 10
        self.selectionRoundsLength = 5
        self.selectionExercisesCount = 10
        self.stateExerciseDescription = "Setup your exercise!"
    }
    
    func start(){
        timerMode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            self.stopwatch.updateTime()
            if(self.stopwatch.done){
                self.timerMode = .initial
            }
            if(self.stopwatch.pause){
                self.timerMode = .resting
            }
            else{
                self.timerMode = .running
            }
        })
        
    }
    
    func setRunning(){
        print("kkeekekk")
    }
    
    func setStopped(){
        self.timerMode = .stopped
    }
    
    func reset(){
        self.timerMode = .initial
        self.stopwatch.resetTime()
        timer.invalidate()
    }
    
    func pause(){
        self.timerMode = .stopped
        timer.invalidate()
    }
    
    
}
