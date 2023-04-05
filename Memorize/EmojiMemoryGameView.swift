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
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100 ))]){
                    ForEach(game.cards )   { card in
                        CardView(card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                   }
                }
            }
            .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
            .padding(.horizontal)     
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
                let shape = RoundedRectangle(cornerRadius: DrawingConstrants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstrants.lineWith)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMAtched{
                    shape.opacity(0)
                }
                else {
                    shape.fill()
                }
            }
        })
       
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstrants.fontScale)
    }
    
    private struct DrawingConstrants {
        static let cornerRadius: CGFloat = 20
        static let lineWith: CGFloat = 3
        static let fontScale: CGFloat = 0.7
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
