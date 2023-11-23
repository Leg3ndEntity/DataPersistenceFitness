//
//  GoalView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 15/11/23.
//

import SwiftUI

struct GoalView: View {
    
    @AppStorage("isWelcomeScreenOver") var isWelcomeScreenOver = false
    @Environment(\.modelContext) var modelContext
    
    @State var num = 1
    @State var cont = 120
    @State var selectedMode = 1
    @State var isShowingMain: Bool = false
    
    var body: some View {
        VStack {
            VStack{
                Text("Your Daily Move Goal")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Text("Set a goal based on how active you are, or \nhow active you'd like to be, each day.")
                    .font(.headline)
                    .fontWeight(.regular)
            }.multilineTextAlignment(.center)
            
            Picker(selection: $selectedMode, label: Text("Mode")) {
                Text("Lightly").tag(1)
                Text("Moderately").tag(2)
                Text("Highly").tag(3)
            }
            .pickerStyle(SegmentedPickerStyle())
            .frame(width: 310)
            .padding(.vertical, 30)
            .onChange(of: selectedMode, perform: { newMode in
                switch newMode {
                case 1:
                    cont = 120
                    print("Lightly selected")
                case 2:
                    cont = 150
                    print("Moderately selected")
                case 3:
                    cont = 180
                    print("Highly selected")
                default:
                    break
                }
            })
            
            GoalSelectorView(counter: $cont)
            
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width:350, height:60)
                    .foregroundColor(Color(red: 0.169, green: 0.169, blue: 0.182))
                    .accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                Text("Set Move Goal")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(.label))
            } .padding(.top, 200)
                .onTapGesture {
                    modelContext.insert(Goal(goal: cont))
                    isWelcomeScreenOver = true
                    isShowingMain.toggle()
                }
                .accessibilityElement(children: .combine)
                .accessibilityAddTraits(.isButton)
        }.preferredColorScheme(.dark)
            .fullScreenCover(isPresented: $isShowingMain, content: {
                MainPageView()
            })
    }
}

#Preview {
    GoalView()
}
