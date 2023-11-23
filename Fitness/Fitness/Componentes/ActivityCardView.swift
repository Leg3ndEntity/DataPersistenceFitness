//
//  ActivityCardView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 15/11/23.
//

import SwiftUI
import SwiftData

struct ActivityCardView: View {
    @EnvironmentObject var healthKitManager: HealthKitManager
    @Query var goal: [Goal]
    
    var body: some View {
        
        let formattedTotalWalkTime = String(format: "%.2f", healthKitManager.walkDistance)
        let cal: Int = healthKitManager.energyBurnedValue
        let goal: Int = goal[0].goal
        let percentage: Double = Double(cal)/Double(goal)
        
        ZStack {
            Color(uiColor: .systemGray6)
            VStack(spacing: 20){
                ZStack(alignment: .center){
                    VStack(alignment: .leading, spacing: 10){
                        VStack(alignment: .leading, spacing: 0){
                            Text("Move")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            HStack {
                                Text("\((healthKitManager.energyBurnedValue))/\(goal)")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                Text("KCAL")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                            }.frame(width: 150)
                                .foregroundColor(.ringColor1)
                                .accessibilityElement(children: .combine)
                        }
                        VStack(alignment: .leading, spacing: 0){
                            Text("Steps")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text("\(healthKitManager.stepValue)")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                        }.accessibilityElement(children: .combine)
                        VStack(alignment: .leading, spacing: 0){
                            Text("Distance")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text("\(formattedTotalWalkTime)KM")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                        }.accessibilityElement(children: .combine)
                    }.padding(.trailing, 160)
                    Spacer()
                    
                    ZStack {
                        RingView(percentage: percentage, backgroundColor: .ringColor2, startColor: .ringColor1, endColor: .ringColor3, thickness: 25)
                            .scaleEffect(1.2)
                            .padding(.leading, 180)
                            .accessibilityLabel(Text("\(Int(percentage*100))%"))
                        Image(systemName: "arrow.forward")
                            .resizable()
                            .frame(width: 15, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.black)
                            .padding(.bottom, 122)
                            .padding(.leading, 178)
                            .bold()
                            .accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    }
                    
                }
            }
            .frame(width: 330, height: 190, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .padding()
        }.frame(width: 350, height: 190)
        
            .cornerRadius(15)
    }
}

#Preview {
    ActivityCardView()
        .preferredColorScheme(.dark)
}
