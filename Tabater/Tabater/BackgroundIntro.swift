//
//  BackgroundIntro.swift
//  Tabater
//
//  Created by Marek Žiška on 15/05/2020.
//  Copyright © 2020 Marek Žiška. All rights reserved.
//

import SwiftUI

struct BackgroundIntro: View {
    var body: some View {
        ZStack() {
            Image("jumpropeworkout2")
                .resizable()
                .aspectRatio(UIImage(named: "jumpropeworkout2")!.size, contentMode: .fill)
            
            CircleImage()
                .offset(y: -40)
                .padding(.bottom, -130)
            
            Text("Tabater")
                .font(.largeTitle)
                .background(Color.black)
                .foregroundColor(.white)
        }
    }
}

struct BackgroundIntro_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundIntro()
    }
}
