//
//  ContentView.swift
//  Memorize
//
//  Created by werthen castro on 16/03/23.
//

import SwiftUI

struct ContentView: View {
    
    var emojis: Array<String> = ["🎩","🧢", "👒", "⛑", "👑","👠" ,"🧣","🪖","🎓","🕶","👓","🥽","💍", "🐶", "🐱","🐭", "🦊", "🐻", "🦇", "🦈", "🦧", "🐍", "🦬", "🦀","🐳", "🦍", "🦕"];
    
    @State var emojiCount = 6
    
    var body: some View {
        VStack{
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65 ))]){
                    ForEach(emojis[0..<emojiCount], id:\.self, content: { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    })
                }         .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
                
            }
           

            Spacer()
            HStack{
                remove
                Spacer()
                add
            }.padding(.horizontal)
             .font(.largeTitle)
        }
         .padding(.horizontal)
     }
    
    var remove: some View{
        Button {
            if emojiCount > 1{
                emojiCount -= 1
            }
        } label: { VStack{
            Image(systemName: "minus.circle")
        }}
    }
    
    var add: some View{
        Button {
            if emojiCount < emojis.count{
                emojiCount += 1
            }
        } label: { VStack{
           Image(systemName: "plus.circle")
        }}
    }
}

struct CardView: View{
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View{
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle).foregroundColor(.orange).padding()
            }else{
                shape.fill()
            }
        }.onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 11 Pro")
        ContentView()
            .preferredColorScheme(.light)
            .previewDevice("iPhone 11 Pro Max")
    }
}
