//
//  ContentView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 23/11/23.
//

import SwiftUI

struct ContentView: View {
    @State var isShowingMain: Bool = false
    var body: some View {
        Rectangle()
            .accessibilityHidden(true)
            .foregroundColor(.black)
            .ignoresSafeArea()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    isShowingMain = true
                }
            }
            .fullScreenCover(isPresented: $isShowingMain, content: {
                MainPageView()
            })
    }
}

#Preview {
    ContentView()
}
