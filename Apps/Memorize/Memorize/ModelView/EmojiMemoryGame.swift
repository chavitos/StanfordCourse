//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Tiago Chaves on 12/11/20.
//

import SwiftUI

//ViewModel
class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = createGame()
    static let emojiThemes = [Theme(name: "Halloween", content: ["👻","🦇","🎃","🧙‍♀️"], color: .orange),
                       Theme(name: "Sports", content: ["⚽️","🥎","🏈","🎱"], color: .blue),
                       Theme(name: "Tecnology", content: ["⌚️","📱","💻","🖱"], color: .black),
                       Theme(name: "Animals", content: ["🐶","🦁","🐯","🐷","🦊"], color: .green),
                       Theme(name: "Flags", content: ["🇨🇦","🇨🇴","🇰🇷","🇺🇸","🇯🇵","🇧🇷"], color: .red),
                       Theme(name: "Symbols", content: ["☪️","🕉","☮️","💟","♎️","⚛️","✝️"], color: .purple, randomNumberOfCards: true)]
    
    static private func createGame() -> MemoryGame<String> {
        let theme = emojiThemes.randomValue
        return MemoryGame<String>(theme: theme!)
    }
    
    //MARK: - Access to the Model
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    var themeName: String {
        model.theme.name
    }
    
    var themeColor: Color {
        model.theme.color
    }
    
    //MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        model = EmojiMemoryGame.createGame()
    }
}
