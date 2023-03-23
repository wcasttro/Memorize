//
//  MemoryGame.swift
//  Memorize
//
//  Created by werthen castro on 23/03/23.
//

import Foundation


struct MemoryGame<CardContent>{
    private(set) var cards: Array<Card>
    
    func choose(_ card: Card){
        
    }
    
    init(numberOfPairsCards: Int, createCardContent: (Int) -> CardContent){
        cards =  Array<Card>()
        
        // add numberOfPairsCards x 2 cards to array
        for pairIndex in 0..<numberOfPairsCards{
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    struct Card{
        var isFaceUp: Bool = false
        var isMAtched: Bool = false
        var content: CardContent
        
    }
}

