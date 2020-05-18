//
//  timeStopwatch.swift
//  Tabater
//
//  Created by Marek Žiška on 17/05/2020.
//  Copyright © 2020 Marek Žiška. All rights reserved.
//

import Foundation

// vnutorne stopky casovaca
struct TimeStopwatch {
    var seconds:Int
    var minutes:Int
    var trainingDuration: Int
    var selectedExerciseLength: Int
    var selectedExercisesCount: Int
    var selectedRestLength: Int
    var selectedRoundsLength: Int
    var exerciseCount: Int
    var exercisedTime: Int
    var roundCount: Int
    var pause: Bool
    var done: Bool

    init() {
        self.seconds = 0;
        self.minutes = 0
        self.selectedExerciseLength = 20
        self.selectedExercisesCount = 10
        self.selectedRestLength = 10
        self.selectedRoundsLength = 5
        self.exercisedTime = 0
        self.trainingDuration = 0
        self.exerciseCount = 0
        self.roundCount = 0
        self.pause = false
        self.done = false
        calculateTrainingDuration()
    }
    
    // pocita celkovu dzlku cvicenia
    mutating func calculateTrainingDuration(){
        self.trainingDuration = ((selectedRestLength * selectedExercisesCount ) + (selectedExercisesCount * selectedExerciseLength)) * selectedRoundsLength
    }
    
    // aktualizuje cas o jednu sekundu, kontroluje casove splnenie cvičeni/kôl
    mutating func updateTime(){
        self.exercisedTime += 1
        self.seconds += 1
        self.trainingDuration -= 1
        if(self.seconds == 60){
            self.minutes += 1
            self.seconds = 0
        }
        // po skonceni exercise nastava pauza
        if(self.pause){
            if(self.calcTimeInSeconds() == self.selectedRestLength){
                self.pause = false
                self.minutes = 0
                self.seconds = 0
            }
        }
        else{
            // trening skoncil
            if(self.trainingDuration == 0){
                self.done = true
            }
            // jedno cvicenie skoncilo
            if(self.calcTimeInSeconds() == self.selectedExerciseLength){
                self.exerciseCount += 1
                if(self.exerciseCount == self.selectedExercisesCount){
                    self.roundCount += 1
                    self.exerciseCount = 0
                }
                self.pause = true
                self.minutes = 0
                self.seconds = 0
            }
        }
    }
    
    // pocita cas v sekundach
    func calcTimeInSeconds() -> Int {
        return (self.minutes*60) + self.seconds
    }

    // vrati string predstavujuci progres cvičení
    func getExercisesStatusString() -> String{
        return String(format: "%d / %d", self.exerciseCount, self.selectedExercisesCount)
    }
    
    // vrati string predstavujuci progres kôl
    func getRoundsStatusString() -> String{
        return String(format: "%d / %d", self.roundCount, self.selectedRoundsLength)
    }
    
    // nastavi dlzku cvicenia
    mutating func setExerciseLength(exerciseLength: Int){
        print("New exercise length \(exerciseLength)")
        
        self.selectedExerciseLength = exerciseLength
    }
    
    // vrati string s celkovym casom treningu
    func getDurationTimeString() -> String{
        let minutes = trainingDuration / 60
        let seconds = trainingDuration % 60
        return String(format: "%02d:%02d", minutes, seconds);
    }
    
    // vrati string so stopovanym casom od nuly
    func getTimeString() -> String{
        return String(format: "%02d:%02d", self.minutes, self.seconds);
    }
    
    // resetuje cas
    mutating func resetTime(){
        self.seconds = 0
    }
}
