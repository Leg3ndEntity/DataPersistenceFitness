//
//  HomeView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 15/11/23.
//

import SwiftUI

struct MainPageView: View {
    @StateObject private var sharedData = SharedData()
    @StateObject var healthKitManager = HealthKitManager()
    
    let currentDateTime = Date()
    @State var isShowingAccount: Bool = false
    @State var isShowingLogin: Bool = true
    @State var isShowingGoal: Bool = true
    @State var scrollViewOffset: CGFloat = 0
    
    func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM"
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        NavigationStack{
            
            ScrollView {
                VStack(alignment: .leading) {
                    HStack{
                        VStack(alignment: .leading) {
                            Text(formattedDate(date: currentDateTime))
                            Text("Summary")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                        }
                        Spacer()
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .onTapGesture {
                                isShowingAccount.toggle()
                            }
                    }.frame(width: 330)
                    
                    Section {
                        Text("Activity")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    NavigationLink(destination: ActivityView()){
                        ActivityCardView()
                    }
                }
            }.scrollIndicators(.hidden)
            
        }.onAppear {
            healthKitManager.requestAuthorization()
            healthKitManager.startEnergyQuery(quantityTypeIdentifier: .activeEnergyBurned)
            healthKitManager.startStepQuery(quantityTypeIdentifier: .stepCount)
            healthKitManager.startWalkQuery(quantityTypeIdentifier: .distanceWalkingRunning)
        }
        //.navigationBarBackButtonHidden(true)
        .sheet(isPresented: $isShowingAccount, content: {
            ModalView().presentationDetents([.large])
        })
//        .fullScreenCover(isPresented: $isShowingLogin, content: {
//            LoginView(height: "", weight: "")
//        })
        .fullScreenCover(isPresented: $isShowingGoal, content: {
            GoalView()
        })
    }
}

#Preview {
    MainPageView()
        .preferredColorScheme(.dark)
}
