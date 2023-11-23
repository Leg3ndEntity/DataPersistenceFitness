//
//  AccountView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 15/11/23.
//

import SwiftUI
import SwiftData

struct AccountView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var isShowingPicker: Bool = false
    @State var click: Bool = false
    
    @State var num2 = 1
    @State var num3 = 1
    @State var num4 = 1
    
    @State var height2: String = "178"
    @State var weight2: String = "72"
    
    @Query var userData: [User]
    func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        ScrollView{
            VStack {
                Text("Personalise Fitness and Health")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Text("This information ensures Fitness and \nHealth data are as accurate as possible. \nThese datails are not shared with Apple")
                    .font(.headline)
                    .fontWeight(.regular)
            }.multilineTextAlignment(.center)
                .frame(width: 350)
                .padding(.top, 20)
            List{
                HStack{
                    Text("Date of Birth")
                    Spacer()
                    Text(formattedDate(date: userData[0].birthDate))
                }.accessibilityElement(children: .combine)
                HStack{
                    Text("Sex")
                    Spacer()
                    Text(userData[0].sex)
                }.accessibilityElement(children: .combine)
                HStack{
                    Text("Height")
                    Spacer()
                    Text("\(Int(userData[0].height)) cm")
                }.accessibilityElement(children: .combine)
                HStack{
                    Text("Weight")
                    Spacer()
                    Text("\(Int(userData[0].weight)) kg")
                }.accessibilityElement(children: .combine)
            }.frame(height: 250)
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width:350, height:60)
                    .foregroundColor(Color(red: 0.169, green: 0.169, blue: 0.182))
                    .accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                Text("Done")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(.label))
            }.padding(.top, 145)
                .onTapGesture {
                    dismiss()
                }
                .accessibilityElement(children: .combine)
                .accessibilityAddTraits(.isButton)
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    AccountView(height2: "178", weight2: "67")
}
