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
            cards.append(Card(id: pairIndex*2, isFaceUp: true, isMatched: false, content: content))
            cards.append(Card(id: pairIndex*2+1, isFaceUp: true, isMatched: false, content: content))
        }
        
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        print("card chosen: \(card)")
        let chosenIndex = index(of: card)
        cards[chosenIndex].isFaceUp.toggle()
    }
    
    private func index(of card: Card) -> Int {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return 0 //TODO: Bogus!
    }
    
    struct Card: Identifiable {
        var id: Int
        
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
