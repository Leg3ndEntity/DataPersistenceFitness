//
//  ActivityView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 18/11/23.
//

import SwiftUI
import SwiftData

struct ActivityView: View {
    
    @EnvironmentObject var healthKitManager: HealthKitManager
    @Query var goal: [Goal]
    
    let currentDateTime = Date()
    func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        
        let cal: Int = healthKitManager.energyBurnedValue
        let goal: Int = goal[0].goal
        let percentage: Double = Double(cal)/Double(goal)
        let formattedTotalWalkTime = String(format: "%.2f", healthKitManager.walkDistance)
        NavigationStack{
            ZStack(alignment: .top){
                ScrollView{
                    ZStack {
                        VStack {
                            ZStack {
                                RingView(percentage: percentage, backgroundColor: .ringColor2, startColor: .ringColor1, endColor: .ringColor3, thickness: 70)
                                    .scaledToFit()
                                    .scaleEffect(0.75)
                                    .accessibilityLabel(Text("\(Int(percentage*100))%"))
                                Image(systemName: "arrow.forward")
                                    .resizable()
                                    .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.black)
                                    .padding(.bottom, 195)
                                    .bold()
                                    .accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                            }.padding(.top, 55)
                            VStack(alignment: .leading, spacing: 0){
                                Text("Move")
                                    .fontWeight(.bold)
                                HStack(spacing: 0.0) {
                                    Text("\(cal)/\(goal)")
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
                                .accessibilityElement(children: .combine)
                            
                            
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
                                .accessibilityElement(children: .combine)
                                VStack(alignment: .leading, spacing: 0){
                                    Text("Distance")
                                        .fontWeight(.bold)
                                    Text("\(formattedTotalWalkTime)KM")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.gray)
                                }
                                .accessibilityElement(children: .combine)
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
                                    .accessibilityRemoveTraits(AccessibilityTraits.isImage)
                                    .accessibilityLabel("Calendar")
                                    .accessibilityAddTraits(.isButton)
                                Image(systemName: "square.and.arrow.up")
                                    .accessibilityRemoveTraits(AccessibilityTraits.isImage)
                                    .accessibilityLabel("Share")
                                    .accessibilityAddTraits(.isButton)
                            } .foregroundColor(.accentColor1)
                        }
                    }
                    .toolbarBackground(.hidden)
                
                ZStack {
                    BlurView(style: .dark)
                        .frame(width: 400, height: 170, alignment: .top)
                        .edgesIgnoringSafeArea(.top)
                        .padding(.bottom, 600)
                    CalendarView()
                        .padding(.bottom, 685)
                        .scaleEffect(0.9)
                }
            }
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    ActivityView()
}
