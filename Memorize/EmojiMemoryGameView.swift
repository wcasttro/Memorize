//
//  ContentView.swift
//  Memorize
//
//  Created by werthen castro on 16/03/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {    
    @ObservedObject var game: EmojiMemoryGame
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack (alignment: .bottom) {
            VStack {
                gameBody
                
                HStack {
                    restart
                    Spacer()
                    shuffe
                }.padding(.horizontal)
            }
            deckBody
        }
        
        .padding(.horizontal)
    }
        
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiMemoryGame.Card){
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        return !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: { $0.id == card.id }){
            delay = Double(index) * (CardConstants.totalDealDuration / Double(game.cards.count))
        }
        return Animation.easeOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: EmojiMemoryGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: {$0.id == card.id}) ?? 0)
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3)  { card in
            if isUndealt(card) || card.isMatched && !card.isFaceUp {
                Color.clear
            } else {
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in:  dealingNamespace)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation {
                            game.choose(card)
                        }
                    }
            }
        }
       
        .foregroundColor(CardConstants.color)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)){ card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in:  dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))

            }
        }
        .frame(width: CardConstants.undealWith, height: CardConstants.undealHeight)
        .foregroundColor(CardConstants.color)
        .onTapGesture {
            // "deal" cards
            for card in game.cards {
                withAnimation (dealAnimation(for: card)) {
                        deal(card)
                 }
            }
        }
    }
    
    var shuffe: some View {
        Button("Shuffle"){
            withAnimation (.easeOut(duration: 1)){
                game.shuffle()
            }
        }
    }
    
    var restart: some View {
        Button("Restart"){
            withAnimation {
                dealt = []
                game.restart()
            }
        }
    }
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealHeight: CGFloat = 90
        static let undealWith = undealHeight * aspectRatio
    }
}

struct CardView: View{
    
    let card: EmojiMemoryGame.Card
    
    @State private var animatedBonusRemaing: Double = 0
    
    init(_ card:  EmojiMemoryGame.Card){
        self.card = card
    }
    
    var body: some View{
        GeometryReader(content: {  geometry in
           
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-animatedBonusRemaing) * 360-90))
                            .onAppear {
                                animatedBonusRemaing = card.bonusRemaining
                                withAnimation (.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaing = 0
                                }
                            }
                    } else {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-card.bonusRemaining) * 360-90))
                    }
                }
                .padding(5)
                .opacity(0.5)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation( Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(Font.system(size: DrawingConstrants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }.cardify(isFaceUp: card.isFaceUp)
        })
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstrants.fontSize / DrawingConstrants.fontScale )
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstrants.fontScale)
    }
    
    private struct DrawingConstrants {
        static let fontScale: CGFloat = 0.65
        static let fontSize: CGFloat = 32
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
