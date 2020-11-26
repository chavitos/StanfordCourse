//
//  MemoryGame.swift
//  Memorize
//
//  Created by Tiago Chaves on 11/11/20.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card] = []
    private(set) var score: Int = 0
    private(set) var theme: Theme<CardContent>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp }.only
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    init(theme: Theme<CardContent>) {
        self.theme = theme
        for pairIndex in 0..<theme.cardsToShow {
            let content = theme.content[pairIndex]
            cards.append(Card(id: pairIndex*2, content: content))
            cards.append(Card(id: pairIndex*2+1, content: content))
        }
        
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        print("card chosen: \(card)")
        guard let chosenIndex = cards.firstIndex(matching: card) else { return }
        
        if !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if card.content == cards[potentialMatchIndex].content {
                    cards[potentialMatchIndex].isMatched = true
                    cards[chosenIndex].isMatched = true
                    score += 2
                } else {
                    if cards[potentialMatchIndex].isPreviouslySeen {
                        score -= 1
                    }
                    
                    if cards[chosenIndex].isPreviouslySeen {
                        score -= 1
                    }
                    
                    cards[potentialMatchIndex].isPreviouslySeen = true
                    cards[chosenIndex].isPreviouslySeen = true
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        fileprivate var isPreviouslySeen: Bool = false
        var content: CardContent
    }
}
