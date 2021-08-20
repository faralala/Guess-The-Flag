//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Миша Черкасов on 20.08.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Argentina", "UK", "USA", "Bangladesh", "China", "Japan", "Canada", "Russia", "Sweden", "Greece", "Brazil", "Germany"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors:[.pink, .white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                
                
                VStack {
                    Text("Выбери флаг: ")
                        .foregroundColor(.white)
                        .font(.headline)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3) { number in Button(action: {
                    self.flagTapped(number)
                    self.showingScore = true
                }){
                    Image(self.countries[number])
                        .renderingMode(.original)
                        .frame(width: 250, height: 125)
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                        .shadow(color: .black, radius: 2)
                }
                
                }
                Text("Общий счет: \(score)")
                    .font(.largeTitle)
                    .fontWeight(.black)
                Spacer()
            }
        } .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Общий счет: \(score)"),dismissButton: .default(Text("Продолжить")){
                self.askQuestion()
            })
        }
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Правильный ответ!"
            score += 1
            
        } else {
            scoreTitle = "Неправильно! Это флаг \(countries[number])"
            score -= 1
        }
    }
}






























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
