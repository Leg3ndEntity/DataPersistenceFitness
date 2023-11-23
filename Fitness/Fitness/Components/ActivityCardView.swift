//
//  ActivityCardView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 15/11/23.
//

import SwiftUI

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

struct ActivityCardView: View {
    
    @EnvironmentObject var sharedData: SharedData
    @EnvironmentObject var healthKitManager: HealthKitManager
    
    var body: some View {
        
        
        //        var cal: Double = Double(healthKitManager.energyBurnedValue)
        //        var goal: Double = Double(sharedData.counter)
        let formattedTotalWalkTime = String(format: "%.2f", healthKitManager.walkDistance)
        //        var percentage: Double = Double(healthKitManager.energyBurnedValue)/Double(sharedData.counter)
        //        let roundedPercentage = percentage.rounded(toPlaces: 2)
        
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
                                Text("\(healthKitManager.energyBurnedValue)/\(sharedData.counter)")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                Text("KCAL")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Spacer()
                            }.frame(width: 150)
                                .foregroundColor(.ringColor1)
                        }
                        VStack(alignment: .leading, spacing: 0){
                            Text("Steps")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text("\(healthKitManager.stepValue)")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                        }
                        VStack(alignment: .leading, spacing: 0){
                            Text("Distance")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text("\(formattedTotalWalkTime)KM")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                        }
                    }.padding(.trailing, 160)
                    Spacer()
                    
                    ZStack {
                        RingView(percentage: 0.17, backgroundColor: .ringColor2, startColor: .ringColor1, endColor: .ringColor3, thickness: 25)
                            .scaleEffect(1.2)
                            .padding(.leading, 180)
                        
                        Image(systemName: "arrow.forward")
                            .resizable()
                            .frame(width: 15, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.black)
                            .padding(.bottom, 122)
                            .padding(.leading, 178)
                            .bold()
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
