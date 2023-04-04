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
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80 ))]){
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
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle).foregroundColor(.orange).padding()
            } else if card.isMAtched{
                shape.opacity(0)
            }
            else {
                shape.fill()
            }
        }
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
