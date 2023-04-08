//
//  Cardify.swift
//  Memorize
//
//  Created by werthen castro on 06/04/23.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    var rotation: Double
    
    var animatableData: Double{
        get {rotation}
        set { rotation = newValue}
    }

    init(isFaceUp: Bool){
        rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstrants.cornerRadius)
            
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstrants.lineWith)
                                
            } else {
                shape.fill()
            }
            
            content.opacity(rotation < 90 ? 1 : 0)
        }.rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
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
