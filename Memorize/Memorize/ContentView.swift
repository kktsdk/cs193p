//
//  ContentView.swift
//  Memorize
//
//  Created by kktsdk on 10/12/2566 BE.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["😈", "👹", "👺", "🤡", "💩", "👻", "💀", "☠️", "👽", "🎃"]
    @State var cardCount = 4
    var body: some View {
        VStack {
            cards
            cardCountAdjusters
        }
        .padding()
    }

    var cards : some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]){
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int ,symbol: String ) -> some View{
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count )
    }
    
    var cardRemover : some View {
        cardCountAdjuster(by: -1, symbol: "trash")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "plus.square.on.square.fill")
    }
    
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            } else {
                base.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
