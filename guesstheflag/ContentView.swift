//
//  ContentView.swift
//  guesstheflag
//
//  Created by BBPDEV on 30/07/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var showingEndGame = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questionNum = 0
    @State private var flagClicked = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Poland", "Spain", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        
        ZStack {
            RadialGradient(stops: [
                .init(color: .red, location: 0.3),
                .init(color: .blue, location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                VStack {
                    Text("Tap the flag of")
                        .font(.subheadline.weight(.heavy))
                        .foregroundStyle(.white)
                    
                    Text(countries[correctAnswer])
                        .font(.largeTitle.weight(.semibold))
                        .foregroundStyle(.white)
                    
                }
                
                VStack(spacing: 20) {
                    ForEach(0..<3) { number in
                        Button() {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.buttonBorder)
                                .shadow(radius: 1)
                        }
                        .buttonStyle(.bordered)
                    }
                }
            }
            
        }
        .alert("Your score is \(score)", isPresented: $showingEndGame) {
            Button("Play Again", action: reset)
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            if (scoreTitle == "Correct") {
                Text("Score +20")
            } else {
                Text("This is \(countries[flagClicked])")
            }
        }
        
        
    }
    
    func reset() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        score = 0
        questionNum = 0
    }
    
    func askQuestion() {
        if questionNum == 5 {
            showingEndGame = true
        } else {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 20
        } else {
            flagClicked = number
            scoreTitle = "Wrong"
        }
        questionNum += 1
        showingScore = true
    }
    
    
    //        ZStack {
    //            VStack(spacing: 0) {
    //                Color.red
    //                Color.blue
    //            }
    
    //            VStack {
    //                Button("Button 1") {
    //                    print("Now deleting ...")
    //                }
    //                .buttonStyle(.bordered)
    //
    //                Button("Button 2", role: .destructive) {           }.buttonStyle(.bordered)
    //                Button("Button 3", role: .destructive) {}
    //                    .buttonStyle(.borderedProminent)
    //                    .tint(.mint)
    //
    //                Button {
    //                    print("Button was tapped")
    //                } label: {
    //                    Text("Tap me")
    //                        .padding()
    //                        .foregroundStyle(.white)
    //                        .background(.red)
    //                }
    //
    //                Button("Edit", systemImage: "pencil") {}
    //
    //                Button {
    //                    print("Edit button was tapped")
    //                } label: {
    //                    Label("Edit", systemImage: "pencil")
    //                        .padding()
    //                        .foregroundStyle(.white)
    //                        .background(.red)
    //                }
    //
    //                Button("Show Alert") {
    //                    showingAlert = true
    //                }
    //                .buttonStyle(.borderedProminent)
    //                .alert("important message", isPresented: $showingAlert) {
    //                    Button("OK"){}
    //                    Button("Cancel", role: .cancel){}
    //                }
    //            }
    //
    
    //            Text("Your content")
    //                .foregroundStyle(.secondary)
    //                .padding(50)
    //                .background(.red.gradient)
    
    //            LinearGradient(stops: [
    //                Gradient.Stop(color: .white, location: 0.45)
    //                Gradient.Stop(color: .black, location: 0.55)
    //            ], startPoint: .top, endPoint: .bottom)
    
    //        }
    //        .ignoresSafeArea()
    
}

#Preview {
    ContentView()
}
