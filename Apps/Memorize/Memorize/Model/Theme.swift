//
//  Theme.swift
//  Memorize
//
//  Created by Tiago Chaves on 26/11/20.
//

import SwiftUI

struct Theme<Content> {
    let name: String
    var content: [Content]
    let cardsToShow: Int
    let color: Color
    
    init(name: String, content: [Content], cardsToShow: Int? = nil, color: Color, randomNumberOfCards: Bool = false) {
        self.name = name
        self.content = content
        if let numberOfCards = cardsToShow {
            self.cardsToShow = numberOfCards
        } else {
            self.cardsToShow = randomNumberOfCards ? content.randomIndex : content.count
        }
        self.color = color
        
        self.content.shuffle()
    }
}
