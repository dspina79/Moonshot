//
//  ContentView.swift
//  Moonshot
//
//  Created by Dave Spina on 12/12/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack {
                GeometryReader { geo in
                    Image("swiftlogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geo.size.width, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .clipped()
                }
                
                ForEach(0..<100) {
                    Text("Item \($0)")
                }
            }.frame(maxWidth: .infinity)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
