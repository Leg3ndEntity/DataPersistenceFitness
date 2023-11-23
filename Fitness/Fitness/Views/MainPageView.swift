//
//  HomeView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 15/11/23.
//

import SwiftUI

struct MainPageView: View {
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
                        Button{
                            isShowingAccount.toggle()
                        } label: {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.white)
                        }.accessibilityLabel("Account")
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
                .scrollDisabled(true)
            
        }.preferredColorScheme(.dark)
            .sheet(isPresented: $isShowingAccount, content: {
                ModalView().presentationDetents([.large])
            })
    }
}

#Preview {
    MainPageView()
}
