//
//  Extensions.swift
//  Memorize
//
//  Created by Tiago Chaves on 24/11/20.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
    
    var randomValue: Element? {
        if count > 0 {
            let randomIndex = Int.random(in: 1..<count)
            return self[randomIndex]
        }
        return nil
    }
    
    var randomIndex: Int {
        if count > 1 {
            return Int.random(in: 1..<count)
        }
        return 0
    }
}
