//
//  chattestApp.swift
//  chattest
//
//  Created by 広瀬友哉 on 2023/06/08.
//

import SwiftUI
import Firebase

@main
struct chattestApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(FirestoreModel())
        }
    }
}
