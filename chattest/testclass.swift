//
//  testclass.swift
//  chattest
//
//  Created by 広瀬友哉 on 2023/06/08.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct messageDataType: Identifiable {
    var id: String
    var name: String
    var message: String
    var createAt: Date
}


class firebasetest:ObservableObject{
    
    @Published var messages = [messageDataType]()
    
    //    init(){
    //        let db = Firestore.firestore()
    //
    //        // メッセージコレクション
    //        db.collection("messages").addSnapshotListener { snap, err in
    //            if let err = err{
    //                print(err.localizedDescription)
    //                return
    //            }
    //
    //            if let snap = snap {
    //                for i in snap.documents
    //            }
    //        }
    //    }
    
    init(){
        let db = Firestore.firestore()
        
        db.collection("messages").addSnapshotListener { snap, err in
            if let err = err {
                print("err fetch \(String(describing: err))")
                return
            }
            
            if let snap = snap {
                for i in snap.documentChanges {
                    if i.type == .added {
                        let name = i.document.get("name") as! String
                        let message = i.document.get("message") as! String
                        let createdAt = i.document.get("createAt", serverTimestampBehavior: .estimate) as! Timestamp
                        let createDate = createdAt.dateValue()
                        let id = i.document.documentID
                        
                        self.messages.append(messageDataType(id: id, name: name, message: message, createAt: createDate))
                    }
                }
                self.messages.sort{before,after in
                    return before.createAt < after.createAt ? true :false
                }
            }
        }
    }
        
        func addmsg(){
            let data = [
                "message": "テトラポット",
                "name": "non",
                "createAt":FieldValue.serverTimestamp(),
            ] as [String : Any]
            
            let db = Firestore.firestore()
            
            db.collection("messages").addDocument(data: data) {
                err in
                if let err = err {
                    print (err.localizedDescription)
                    return
                }
                
                print("success")
            }
        }
        
    }
