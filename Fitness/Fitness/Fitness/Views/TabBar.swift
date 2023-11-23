//
//  MainPageView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 15/11/23.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView{
            MainPageView().tabItem {
                Label("Summary", systemImage: "person")
            }
            Text("Soon").tabItem { VStack{Image(systemName: "figure.run.circle.fill"); Text("Fitness+") }.tag(2)}
            Text("Soon").tabItem { VStack{Image(systemName: "person.2.fill") ; Text("Sharing")}.tag(2)
            }
        }.accentColor(Color("AccentColor1"))
    }
}

#Preview {
    TabBar()
}
