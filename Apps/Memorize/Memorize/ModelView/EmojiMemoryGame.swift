//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Tiago Chaves on 12/11/20.
//

import SwiftUI

//ViewModel
class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: [String] = ["👻","🧐","🦇","🐟","🤪","🎃"]
        let numberOfPairs = Int.random(in: 1..<emojis.count)
        
        
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairs) { index in
            return emojis[index]
        }
    }
    
    //MARK: - Access to the Model
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    //MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
