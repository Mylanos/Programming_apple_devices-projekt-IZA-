//
//  ContentView.swift
//  Tabater
//
//  Created by Marek Žiška on 13/05/2020.
//  Copyright © 2020 Marek Žiška. All rights reserved.
//

import SwiftUI

// Hlavny view aplikacie
struct ContentView: View {
    
    // Observable object na kontrolu casovania vo view
    var sharedTimerManager: TimerManager
        
    // MOC CoreData
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // Observable object ma nastarosti hlavne views ktore sa maju zobrazit na zaklade nejakeho vstupu
    @ObservedObject var viewRouter: ViewRouter
    
    init(viewRouter: ViewRouter, sharedTimerManager: TimerManager) {
        let appearance = UINavigationBarAppearance()
        
        // prebera ViewRouter vytvoreny v sceneDelegate
        self.viewRouter = viewRouter
        
        // prebera TimerManager vytvoreny v sceneDelegate
        self.sharedTimerManager = sharedTimerManager
        
        // transparetny background nav baru
        appearance.configureWithTransparentBackground()
        
        //farba nadpisov
        appearance.largeTitleTextAttributes = [
            .font : UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor : UIColor.black
        ]
        appearance.titleTextAttributes = [
            .font : UIFont.systemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor : UIColor.black
        ]
        
        // aplikovanie vzhladu
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        
        // Farba burger imagu menu navigatora
        UINavigationBar.appearance().tintColor = .blue
        
        UITableView.appearance().tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
    }
    
    var body: some View {
        ZStack{
            NavigationView{
                // Geometry reader na vypocet sirky okna pri zobrazeni navigation menu sa meni sirka views
                GeometryReader { geometry in
                    ZStack(alignment: .leading){
                        // zobraz hlavny view v ktorom su hodiny
                        if self.viewRouter.currentPage == .mainPage{
                            ClockView(timerManager: self.sharedTimerManager, viewRouter: self.viewRouter)
                                .environment(\.managedObjectContext, self.managedObjectContext)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .offset(x: self.viewRouter.viewMenu ? geometry.size.width/2 : 0)
                                .disabled( self.viewRouter.viewMenu ? true : false)
                                .padding(.top, 15)
                        // zobraz view s historiou cviceni
                        }
                        else if self.viewRouter.currentPage == .historyPage{
                               HistoryView(showExerciseSheet: false, viewRouter: self.viewRouter).environment(\.managedObjectContext, self.managedObjectContext)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .offset(x: self.viewRouter.viewMenu ? geometry.size.width/2 : 0)
                                .disabled(self.viewRouter.viewMenu ? true : false)
                        }
                        // ak bolo kliknute burger tlacidlo na zobrazenie menu alebo bol detekovany drag smerom do prava zobraz navigation menu
                        if self.viewRouter.viewMenu{
                            MenuView(viewRouter: self.viewRouter)
                            .frame(width: geometry.size.width/2)
                            .transition(.move(edge: .leading))
                            .animation(.default)
                        }
                    }
                    .navigationBarTitle("Tabata", displayMode: .inline)
                    .navigationBarItems(leading: (
                        Button(action: {
                            withAnimation { self.viewRouter.viewMenu.toggle() }
                        }) {
                            Image(systemName: "line.horizontal.3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                                .frame(height: 16)
                        }))
                        
                }
            // pri detekcii dragu zavolat obsluhu viewu a pocita smer dragu pre zobrazenie menu
            }
            .gesture(self.viewRouter.drag)
        }
    }
}
// preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let contentView = ContentView(viewRouter: ViewRouter(), sharedTimerManager: TimerManager()).environment(\.managedObjectContext, context)
        
        return contentView
    }
}


