//
//  MemoryGame.swift
//  Memorize
//
//  Created by Tiago Chaves on 11/11/20.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: [Card] = []
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            let card = Card(id: pairIndex, isFaceUp: true, isMatched: false, content: content)
            cards.append(card)
            cards.append(card)
        }
        
        cards.shuffle()
    }
    
    func choose(card: Card) {
        print("card chosen: \(card)")
    }
    
    struct Card: Identifiable {
        var id: Int
        
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
