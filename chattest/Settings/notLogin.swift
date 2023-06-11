//
//  notLogin.swift
//  chattest
//
//  Created by Yuya Hirose on 2023/06/10.
//

import SwiftUI

struct notLogin: View {
    @State var user:String
    @State var mail:String
    @State var pass:String
    
    
    @State var af1:Bool = false
    
    @EnvironmentObject var fireSt: FirestoreModel
    
    @AppStorage ("miss") var miss: String = "false"
    @AppStorage ("loginFlag") var fu:String = "no"
    
    enum Field:Hashable{
        case msg
    }
    
    @FocusState private var foc: Field?
    
    
    var body: some View {
        VStack {
            Spacer()
            GroupBox {
                HStack {
                    Spacer()
                }
                HStack {
                    Text("ユーザ名")
                    Spacer()
                }
                TextField("", text: $user).textFieldStyle(.roundedBorder).focused($foc, equals: .msg)
                HStack {
                    Text("メールアドレス")
                    Spacer()
                }
                TextField("", text: $mail).textFieldStyle(.roundedBorder).focused($foc, equals: .msg)
                HStack {
                    Text("パスワード")
                    Spacer()
                }
                SecureField("", text: $pass).textFieldStyle(.roundedBorder).focused($foc, equals: .msg)
                HStack{
                    VStack{
                        if (self.fireSt.miss) {
                            HStack {
                                Text("ログイン失敗").foregroundColor(.red)
                                Spacer()
                            }
                        }
                        if (self.fireSt.missR) {
                            HStack {
                                Text("入力エラー").foregroundColor(.red)
                                Spacer()
                            }
                        }
                    }
                    Spacer()
                    Button("Regist"){
                        if(user.count > 5 && pass.count > 5){
                            //                        fireSt.userReq(name: user, mail: mail, pass: pass, group: "")
                            fireSt.addusr(name: user, mail: mail, pass: pass, group: "")
                        }else{
                            self.af1 = true
                        }
                    }
                    
                    Button("Login"){
                        fireSt.inUser(name: user, mail: mail, pass: pass)
                        print(self.fireSt.miss)
                    }.buttonStyle(.borderedProminent)
                }.buttonStyle(.borderedProminent).padding().alert("5文字以上入力してください",isPresented: $af1){
                    Button("了解"){}
                }
                
                .alert("削除完了",isPresented: $fireSt.delAlt) {
                    Button("OK"){}
                }
                .alert("登録完了",isPresented: $fireSt.resiAlt) {
                    Button("OK"){}
                }
                
            }
            Spacer()
        }.padding().onTapGesture {
            foc = nil
            }
    }
}

struct notLogin_Previews: PreviewProvider {
    static var previews: some View {
        notLogin(user: "", mail: "", pass: "")
    }
}
