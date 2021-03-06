//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Hubert Leszkiewicz on 05/01/2021.
//

import SwiftUI

struct ContentView: View {
   @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
   @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .blue, .blue, .red, .red, .red, .orange, .orange, .orange, .purple]), startPoint: .top, endPoint: .trailing).edgesIgnoringSafeArea(.all)
            
    VStack(spacing: 30) {
        VStack {
            Text("Tap the flag of")
                .foregroundColor(.white)
            Text(countries[correctAnswer])
                .foregroundColor(.white)
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        
        ForEach(0..<3) {
            number in Button( action: {
                self.flagTapped(number)
            }) {
                Image(self.countries[number]).renderingMode(.original)
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                    .shadow(color: .black, radius: 5, x: 0.0, y: 0.0)
                    }
                }
        Text("Your score is: \(score)").foregroundColor(.white).fontWeight(.bold).font(.headline)
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Wrong!"
            score -= 1
        }
        showingScore = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



