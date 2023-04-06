//
//  ContentView.swift
//  Memorize
//
//  Created by werthen castro on 16/03/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {    
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3)  { card in
            cardView(for: card)
        }
        .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View{
        if card.isMAtched && !card.isFaceUp {
            Rectangle().opacity(0)
        } else {
            CardView(card)
                .padding(4)
                .onTapGesture {
                    game.choose(card)
                }
        }
    }
}

struct CardView: View{
    
    let card: EmojiMemoryGame.Card
    
    init(_ card:  EmojiMemoryGame.Card){
        self.card = card
    }
    
    var body: some View{
        GeometryReader(content: {  geometry in
            ZStack {
                Pie(startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 110))
                    .padding(5)
                    .opacity(0.5)
                Text(card.content)
                    .font(font(in: geometry.size))
            }.cardify(isFaceUp: card.isFaceUp)
        })
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstrants.fontScale)
    }
    
    private struct DrawingConstrants {
        static let fontScale: CGFloat = 0.65
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let  game = EmojiMemoryGame()
        
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
            .previewDevice("iPhone 12")
    }
}
