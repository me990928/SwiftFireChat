//
//  SetView.swift
//  chattest
//
//  Created by Yuya Hirose on 2023/06/10.
//

import SwiftUI

struct SetView: View {
    @State var user:String = ""
    @State var mail:String = ""
    @State var pass:String = ""
    
    @State var delAlt:Bool = false
    
//    @AppStorage ("loginFlag") var fu:String = "no"
    @AppStorage ("groupSearch") var groupSearch: Int = 1
    @AppStorage ("groupBtn") var groupBtn: Int = 1
    
    @EnvironmentObject var fireSt: FirestoreModel
    
    var body: some View {
        
        VStack{
            if (fireSt.userflag == "true") {
                Button("アカウント削除"){
                    fireSt.delUser()
                    fireSt.miss = false
                    fireSt.missR = false
                    groupSearch = 1
                    groupBtn = 1
                }
            }
            if (fireSt.userflag == "false") {
                notLogin(user: user, mail: mail, pass: pass)
            }
        }
    }
}

struct SetView_Previews: PreviewProvider {
    static var previews: some View {
        SetView()
    }
}
