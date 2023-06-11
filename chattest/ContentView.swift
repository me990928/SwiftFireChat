//
//  ContentView.swift
//  chattest
//
//  Created by 広瀬友哉 on 2023/06/08.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var fst = firebasetest()
    
    var body: some View {
        VStack {
            TabView {
                ComuView()
                    .toolbarBackground(Color("blackwhite"), for: .tabBar)
                    .toolbarBackground(.visible, for: .tabBar)
                    .tabItem {
                        Label("Comu", systemImage: "person")
                    }
                    .padding()
                SetView()
                    .toolbarBackground(Color("blackwhite"), for: .tabBar)
                    .toolbarBackground(.visible, for: .tabBar)
                    .tabItem {
                        Label("Setting", systemImage: "gear")
                    }
                    .padding()
                
            }
        }
//        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
