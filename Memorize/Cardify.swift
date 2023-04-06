//
//  Cardify.swift
//  Memorize
//
//  Created by werthen castro on 06/04/23.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    var isFaceUp: Bool
    
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstrants.cornerRadius)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstrants.lineWith)
                content
            } else {
                shape.fill()
            }
        }
        
    }
    
    
    private struct DrawingConstrants {
        static let cornerRadius: CGFloat = 10
        static let lineWith: CGFloat = 3
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
