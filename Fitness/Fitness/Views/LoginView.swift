//
//  LoginView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 15/11/23.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var healthKitManager: HealthKitManager
    @State private var birthday: Date = (Calendar.current.date(byAdding: DateComponents(year: -20), to: Date()) ?? Date())
    @State var height: String
    @State var weight: String
    
    @Environment(\.modelContext) var modelContext
    
    @State var isShowingPicker: Bool = false
    @State var isShowingGoal: Bool = false
    
    @State var num2 = 1
    @State var num3 = 1
    @State var num4 = 1
    
    func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    var selectedText: String {
        switch num2 {
        case 1:
            return "Not Set"
        case 2:
            return "Female"
        case 3:
            return "Male"
        case 4:
            return "Other"
        default:
            return ""
        }
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
                    Text(formattedDate(date: birthday))
                        .onTapGesture {
                            isShowingPicker.toggle()
                        }
                }
                Picker(selection: $num2, label: Text("Sex")) {
                    Text("Not Set").tag(1)
                    Text("Female").tag(2)
                    Text("Male").tag(3)
                    Text("Other").tag(4)
                }
                HStack{
                    Text("Height")
                    Spacer()
                    TextField("172", text: $height)
                        .padding(.leading, 223)
                        .keyboardType(.numberPad)
                }
                HStack{
                    Text("Weight")
                    Spacer()
                    TextField("67", text: $weight)
                        .padding(.leading, 226)
                        .keyboardType(.numberPad)
                }
            }.frame(height: 250)
            
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width:350, height:60)
                    .foregroundColor(Color(red: 0.169, green: 0.169, blue: 0.182))
                    .accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                
                Text("Continue")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(.label))
            }.padding(.top, 145)
                .onTapGesture {
                    modelContext.insert(User(birthDate: birthday, sex: selectedText, weight: Double(weight)!, height: Double(height)!))
                    isShowingGoal.toggle()
                }
                .accessibilityElement(children: .combine)
                .accessibilityAddTraits(.isButton)
        }.preferredColorScheme(.dark)
        .sheet(isPresented: $isShowingPicker, content: {
            DatePicker(selection: $birthday, displayedComponents: .date){}
                .padding(10)
                .labelsHidden()
                .datePickerStyle(.wheel)
                .presentationDetents([.fraction(0.3)])
                .accessibilityAddTraits(.isButton)
        })
        .fullScreenCover(isPresented: $isShowingGoal, content: {
            withAnimation {
                GoalView()
            }
        })
    }
}

#Preview {
    LoginView(height: "172", weight: "90")
}
