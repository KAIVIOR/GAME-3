//
//  ContentView.swift
//  GAME-3
//
//  Created by User16 on 2021/3/31.
//

import SwiftUI

struct ContentView: View {
    @StateObject var gameObject = GameObject()
    var body: some View {
        GateView().environmentObject(gameObject)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlayView()
                .previewLayout(.fixed(width: 844, height: 390))
           
        }
            
    }
}
