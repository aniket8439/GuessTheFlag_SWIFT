//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Aniket Sharma on 11/04/24.
//

import SwiftUI

struct ContentView: View {
    // MARK: Properties
    @State private var count = 0
    @State private var showingScore = false
    @State private var resetScore = false
    @State private var finalScore = 0
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    
    //MARK: Body
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("Guess the Flag")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)
                Spacer()
                Spacer()
                Text("Question : \(count + 1)/8")
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.black)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .foregroundStyle(.secondary)
                    }

                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .shadow(radius: 20)
                                
                        }
                        
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            
            .padding()
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Game Over", isPresented: $resetScore) {
            Button("Restart", action: askQuestion)
        } message: {
            Text("Your score is \(finalScore)/8")
        }
    }
    
    
    // MARK: Helper Functions
    func flagTapped(_ number: Int) {
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            count += 1
        } else {
            scoreTitle = "Wrong! This is a flag of \(countries[number])"
            count += 1
            
        }
        if(count == 8){
            showingScore = false
            resetScore = true
            finalScore = score
            score = 0
            return
            
        }

        showingScore = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        if resetScore == true {
            count = 0
        }
    }
    
}

#Preview {
    ContentView()
}
