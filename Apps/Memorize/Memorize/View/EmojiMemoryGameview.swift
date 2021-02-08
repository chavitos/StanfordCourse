//
//  EmojiMemoryGameview.swift
//  Memorize
//
//  Created by Tiago Chaves on 10/11/20.
//

import SwiftUI

struct EmojiMemoryGameview: View {
    @ObservedObject private(set) var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            HStack {
                Text("Score: \(viewModel.score)")
                Spacer()
                Text(viewModel.themeName)
                Spacer()
                Button("New game") {
                    withAnimation(.easeInOut) {
                        viewModel.newGame()
                    }
                }
            }
            .padding()
            Divider()
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear) {
                        viewModel.choose(card)
                    }
                }
//                .aspectRatio(CGSize(width: 3.0, height: 4.0), contentMode: .fit)
                .padding(5)
            }
            .foregroundColor(viewModel.themeColor)
        }
        
    }
}

struct CardView: View {
    private(set) var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(0-90),
                    endAngle: Angle.degrees(110-90),
                    clockwise: true)
                    .padding(5)
                    .opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatCount(2, autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
        }
    }
    
    //MARK: - Drawing Constants    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameview(viewModel: game)
    }
}
