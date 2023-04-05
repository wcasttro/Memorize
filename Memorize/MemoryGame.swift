//
//  MemoryGame.swift
//  Memorize
//
//  Created by werthen castro on 23/03/23.
//

import Foundation


struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
            get { cards.indices.filter({ cards[$0].isFaceUp}).oneAndOnly }
            set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    mutating func choose(_ card: Card){
        if let choseIndex = cards.firstIndex(where: { $0.id == card.id }),
            !cards[choseIndex].isFaceUp,
            !cards[choseIndex].isMAtched
        {
            
            if let potentialMacthIndex  = indexOfTheOneAndOnlyFaceUpCard {
                if(cards[choseIndex].content == cards[potentialMacthIndex].content){
                    cards[choseIndex].isMAtched = true
                    cards[potentialMacthIndex].isMAtched = true
                }
                
                cards[choseIndex].isFaceUp = true

            } else {
                indexOfTheOneAndOnlyFaceUpCard = choseIndex
            }
        }
    }
      
    init(numberOfPairsCards: Int, createCardContent: (Int) -> CardContent){
        cards =  []
        
        // add numberOfPairsCards x 2 cards to array
        for pairIndex in 0..<numberOfPairsCards{
            let content = createCardContent(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1, content: content))
        }
    }
    
    struct Card: Identifiable{
        let id: Int
        var isFaceUp = false
        var isMAtched = false
        let content: CardContent
        
    }
}

extension Array{
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else{
            return nil
        }
    }
}

