//
//  EmojiMomeryGame.swift
//  Memorize
//
//  Created by werthen castro on 23/03/23.
//

import SwiftUI



class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static let emojis = ["🎩","🧢", "👒", "⛑", "👑","👠" ,"🧣","🪖","🎓","🕶","👓","🥽","💍", "🐶", "🐱","🐭", "🦊", "🐻", "🦇", "🦈", "🦧", "🐍", "🦬", "🦀","🐳", "🦍"];
    
    private static func createMemoryGame () -> MemoryGame<String>{
           MemoryGame<String>(numberOfPairsCards: 8)  { pairIndex in
                emojis[pairIndex]
        }
    }    
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<Card>{
        return model.cards
    }
    
    func choose(_ card: Card){
        model.choose(card)
    }
    
}

struct Previews_EmojiMomeryGame_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
