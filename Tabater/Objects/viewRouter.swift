//
//  viewRouter.swift
//  Tabater
//
//  Created by Marek Žiška on 17/05/2020.
//  Copyright © 2020 Marek Žiška. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

// vsetky hlavne views
enum viewPages{
    case mainPage
    case historyPage
}

// ma na starosti prepinanie medzi views
class ViewRouter: ObservableObject {
    
    // premieta elementy pre odoberatelov
    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    
    var mainNavbarDescription = "Tabata"
    
    enum SwipeDirection: String {
        case left, right, up, down, none
    }
    
    // prepinanie hlavneho textu v navigation bare
    var currentPage: viewPages = .mainPage{
        didSet{
            if(currentPage == .mainPage){
                mainNavbarDescription = "Tabata"
            }
            else if(currentPage == .historyPage){
                mainNavbarDescription = "History"
            }
            objectWillChange.send(self)
        }
    }
    // zobrazenie menu
    var viewMenu: Bool = false{
        didSet{
            objectWillChange.send(self)
        }
    }

    // pocita smer drag gesture, vyuzite pri zobrazovani navigation menu
    var drag: some Gesture {
        DragGesture()
            .onEnded { value in
                print("value ",value.translation.width)
                let direction = self.detectDirection(value: value)
                if direction == .left {
                    withAnimation{
                        self.viewMenu = false
                    }
                }
                if direction == .right{
                    withAnimation{
                        self.viewMenu = true
                    }
                }
        }
    }
    
    // uklada index zaznamu na ktory bolo kliknute v historii zaznamov
    var selExercIndex: Int = 0 {
        didSet{
            objectWillChange.send(self)
        }
    }
    
    // pocita smer drag gestures
    func detectDirection(value: DragGesture.Value) -> SwipeDirection {
        if value.startLocation.x > value.location.x{
            return .left
        }
        if value.startLocation.x < value.location.x{
            return .right
        }
        return .none
    }
}
