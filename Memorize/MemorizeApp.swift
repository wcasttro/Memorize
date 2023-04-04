//
//  MemorizeApp.swift
//  Memorize
//
//  Created by werthen castro on 16/03/23.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
