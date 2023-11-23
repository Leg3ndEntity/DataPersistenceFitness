//
//  AccountView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 15/11/23.
//

import SwiftUI
import SwiftData

struct AccountView: View {
    @State private var birthday: Date = (Calendar.current.date(byAdding: DateComponents(year: -20), to: Date()) ?? Date())
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
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
    
    func formattedText(bho: String) -> String{
        return bho
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
                    
                }
                HStack{
                    Text("Sex")
                    Spacer()
                    Text(userData[0].sex)
                }
                HStack{
                    Text("Height")
                    Spacer()
                    Text(String(userData[0].height))
                }
                HStack{
                    Text("Weight")
                    Spacer()
                    Text(String(userData[0].weight))
                }
            }.frame(height: 250)
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width:350, height:60)
                    .foregroundColor(Color(red: 0.169, green: 0.169, blue: 0.182))
                
                Text("Done")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(.label))
            }.padding(.top, 145)
                .onTapGesture {
                    dismiss()
                }
        }.sheet(isPresented: $isShowingPicker, content: {
            DatePicker(selection: $birthday, displayedComponents: .date){}
                .padding(10)
                .labelsHidden()
                .datePickerStyle(.wheel)
                .presentationDetents([.fraction(0.3)])
        })
    }
}

#Preview {
    AccountView(height2: "178", weight2: "67")
}
