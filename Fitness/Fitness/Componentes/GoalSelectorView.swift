//
//  GoalSelectorView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 18/11/23.
//

import SwiftUI

struct GoalSelectorView: View {
    @Binding var counter: Int
    @State private var isLongPressing = false
    @State private var timer: Timer?
    @State private var durata = 0.0
    
    func startTimer(increase: Bool) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
            if increase {
                counter += 10
            } else {
                counter -= 10
            }
            durata += 0.2
            
            if durata >= 1 {
                stopTimer()
                startFastTimer(increase: increase)
            }
        }
        isLongPressing = true
    }
    
    func startFastTimer(increase: Bool) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if increase {
                counter += 10
            } else {
                counter -= 10
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isLongPressing = false
        durata = 0
    }
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "minus.circle.fill")
                    .resizable()
                    .foregroundColor(.ringColor1)
                    .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .onTapGesture {
                        if counter != 0{
                            self.counter -= 10
                        }
                        print(counter)
                    }
                    .onLongPressGesture(minimumDuration: 5, pressing: { isPressing in
                        if isPressing {
                            startTimer(increase: false)
                        } else {
                            stopTimer()
                        }
                    }){}
                    .accessibilityRemoveTraits(AccessibilityTraits.isImage)
                    .accessibilityLabel("Minus")
                    .accessibilityAddTraits(.isButton)
                    .accessibilityHint("10 kilocalories less")
                
                
                Text("\(counter)")
                    .font(.system(size: 70))
                    .fontWeight(.bold)
                    .frame(width: 180)
                
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .foregroundColor(.ringColor1)
                    .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .onTapGesture {
                        self.counter += 10
                        print(counter)
                    }
                    .onLongPressGesture(minimumDuration: 5, pressing: { isPressing in
                        if isPressing {
                            startTimer(increase: true)
                        } else {
                            stopTimer()
                        }
                    }){}
                    .accessibilityRemoveTraits(AccessibilityTraits.isImage)
                    .accessibilityLabel("Plus")
                    .accessibilityAddTraits(.isButton)
                    .accessibilityHint("10 kilocalories more")
            }
        }
        Text("KILOCALORIES/DAY")
            .font(.title2)
            .fontWeight(.black)
    }
}
