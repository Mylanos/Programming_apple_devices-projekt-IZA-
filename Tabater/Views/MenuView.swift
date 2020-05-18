//
//  MenuView.swift
//  Tabater
//
//  Created by Marek Žiška on 15/05/2020.
//  Copyright © 2020 Marek Žiška. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                withAnimation {
                    self.viewRouter.currentPage = .mainPage
                    self.viewRouter.viewMenu.toggle()
                }
            }){
                HStack {
                Image(systemName: "timer")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Timer")
                    .foregroundColor(.gray)
                    .font(.headline)
                }
            }
            .padding(.top, 100)
            Button(action:{
                withAnimation {
                    self.viewRouter.currentPage = .historyPage
                    self.viewRouter.viewMenu.toggle()
                }
            }){
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text("History")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
                    .padding(.top, 30)
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .edgesIgnoringSafeArea(.all)
    }
}
