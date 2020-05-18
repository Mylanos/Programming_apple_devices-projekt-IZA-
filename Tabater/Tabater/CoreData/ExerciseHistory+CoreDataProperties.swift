//
//  ExerciseHistory+CoreDataProperties.swift
//  Tabater
//
//  Created by Marek Žiška on 18/05/2020.
//  Copyright © 2020 Marek Žiška. All rights reserved.
//
//

import Foundation
import CoreData


extension ExerciseHistory: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseHistory> {
        return NSFetchRequest<ExerciseHistory>(entityName: "ExerciseHistory")
    }

    @NSManaged public var date: Date?
    @NSManaged public var exercisedTime: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var roundsDone: Int32
    @NSManaged public var exercisesInRound: Int16
    @NSManaged public var breaksInRound: Int16
    @NSManaged public var allRounds: Int16
    @NSManaged public var allExercises: Int16

}
