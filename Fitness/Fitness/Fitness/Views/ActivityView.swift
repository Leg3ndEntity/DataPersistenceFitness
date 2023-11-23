//
//  ActivityView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 18/11/23.
//

import SwiftUI

struct ActivityView: View {
    
    @EnvironmentObject var sharedData: SharedData
    @EnvironmentObject var healthKitManager: HealthKitManager
    
    let currentDateTime = Date()
    func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        
        let formattedTotalWalkTime = String(format: "%.2f", healthKitManager.walkDistance)
        NavigationStack{
            ZStack(alignment: .top){
                ScrollView{
                    ZStack {
                        VStack {
                            ZStack {
                                RingView(percentage: 0.75, backgroundColor: .ringColor2, startColor: .ringColor1, endColor: .ringColor3, thickness: 70)
                                    .scaledToFit()
                                    .scaleEffect(0.75)
                                Image(systemName: "arrow.forward")
                                    .resizable()
                                    .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.black)
                                    .padding(.bottom, 195)
                                    .bold()
                            }.padding(.top, 55)
                            VStack(alignment: .leading, spacing: 0){
                                Text("Move")
                                    .fontWeight(.bold)
                                HStack(spacing: 0.0) {
                                    Text("\(healthKitManager.energyBurnedValue)/\(sharedData.counter)")
                                        .font(.title)
                                        .fontWeight(.bold)
                                    Text("KCAL")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .padding(.top, 4)
                                    Spacer()
                                }.frame(width: 190)
                                    .foregroundColor(.ringColor1)
                            }.padding(.trailing, 160)
                                .padding(.top, -65)
                            
                            
                            ChartView()
                                .environmentObject(healthKitManager)
                                .frame(width: 350)
                                .onAppear {
                                    healthKitManager.fetchHourlyCalories { hourlyCalories in
                                        DispatchQueue.main.async {
                                            healthKitManager.hourlyCalorieData = hourlyCalories
                                        }
                                    }
                                }
                            
                                .frame(width: 400, height: 80, alignment: .center)
                            HStack(spacing: 65){
                                VStack(alignment: .leading, spacing: 0){
                                    Text("Steps")
                                        .fontWeight(.bold)
                                    Text("\(healthKitManager.stepValue)")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.gray)
                                }
                                VStack(alignment: .leading, spacing: 0){
                                    Text("Distance")
                                        .fontWeight(.bold)
                                    Text("\(formattedTotalWalkTime)KM")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.gray)
                                }
                            }.padding(.trailing, 110)
                                .padding(.top, 30)
                        }
                    }
                }.navigationTitle("Today, \(formattedDate(date: currentDateTime))")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        ToolbarItem{
                            HStack(spacing: 30) {
                                Image(systemName: "calendar")
                                Image(systemName: "square.and.arrow.up")
                            } .foregroundColor(.accentColor1)
                        }
                    }
                    .toolbarBackground(.hidden)
                
                ZStack {
                    BlurView(style: .dark)
                        .frame(width: 400, height: 180, alignment: .top)
                        .edgesIgnoringSafeArea(.top)
                        .padding(.bottom, 600)
                    CalendarView()
                        .padding(.bottom, 685)
                        .scaleEffect(0.9)
                }
            }
        }
    }
}

#Preview {
    ActivityView()
}
