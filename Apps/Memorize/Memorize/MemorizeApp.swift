//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Tiago Chaves on 10/11/20.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameview(viewModel: EmojiMemoryGame())
        }
    }
}
