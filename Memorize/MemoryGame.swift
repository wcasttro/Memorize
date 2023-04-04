//
//  MemoryGame.swift
//  Memorize
//
//  Created by werthen castro on 23/03/23.
//

import Foundation


struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    mutating func choose(_ card: Card){
        if let choseIndex = cards.firstIndex(where: { $0.id == card.id }),
            !cards[choseIndex].isFaceUp,
            !cards[choseIndex].isMAtched
        {
            
            if let potentialMacthInde  = indexOfTheOneAndOnlyFaceUpCard {
                if(cards[choseIndex].content == cards[potentialMacthInde].content){
                    cards[choseIndex].isMAtched = true
                    cards[potentialMacthInde].isMAtched = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil

            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                
                indexOfTheOneAndOnlyFaceUpCard = choseIndex
            }
            
            cards[choseIndex].isFaceUp.toggle()
        }
    }
      
    init(numberOfPairsCards: Int, createCardContent: (Int) -> CardContent){
        cards =  Array<Card>()
        
        // add numberOfPairsCards x 2 cards to array
        for pairIndex in 0..<numberOfPairsCards{
            let content = createCardContent(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1, content: content))
        }
    }
    
    struct Card: Identifiable{
        var id: Int
        var isFaceUp: Bool = false
        var isMAtched: Bool = false
        var content: CardContent
        
    }
}

