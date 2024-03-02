//
//  ListVC.swift
//  ScopicAppAssignment
//
//  Created by HAR-LAP046-080 on 28/02/2024.
//

import SwiftUI
import Firebase
import FirebaseDatabase
import Combine

struct Lists: Identifiable {
    var id = UUID()
    var name : String
}

struct ListVC: View {
        
    @State private var showGreeting = true

    @State var selection: Int? = nil
    @State private var databaseRef: DatabaseReference!

    let textLimit = 35 //textfield limit


   @State var lists = [
        Lists(name: "item1"),
        Lists(name: "item2"),
        Lists(name: "item3")
    ]
    
    //Firebase Database
    @State private var data: [String] = []
    @State private var newItem: String = ""
    @State private var presentAlert = false
    @Binding var shouldPopToRootView : Bool

    
    var body: some View {
        
        NavigationSplitView {
                        
            Toggle("", isOn: $showGreeting)
                .toggleStyle(SwitchToggleStyle(tint: Color.Orange))

            if showGreeting {
                List($data, id: \.self, editActions: .delete) { $user in
                    Text(user)
                }.onAppear(perform: setupFirebase)

            }
            else {
                
                List(lists) { list in
                    Text(list.name)
                    }
            }
            
            Button("Add Item") {
                presentAlert = true
            }
            .alert("Enter Item", isPresented: $presentAlert) {
                
                if showGreeting {
                    TextField("Enter your name", text: $newItem)
                        .onReceive(Just($newItem)) { _ in limitText(textLimit) }
                }
                else {
                    TextField("Enter your name", text: $newItem)
                        .onReceive(Just($newItem)) { _ in limitText(textLimit) }
                    
                }

                       Button("OK", action: submit)
                   } message: {
                   }
            
            NavigationLink(destination: ProfileVC(shouldPopToRootView: $shouldPopToRootView), tag: 1, selection: self.$selection) {
                              EmptyView()
                        }.isDetailLink(false)
            
            .navigationTitle("Lists")
            .navigationBarBackButtonHidden()
            .navigationBarItems(trailing: Button(action: {
                            self.selection = 1
                        }, label: {
                            Image(systemName: "person.fill")
                        }))
        }
         detail: {
            Text("Select an item")
        }
    }
    
    func submit() {
        print("You entered \($newItem)")
        
        if showGreeting {
            self.addItem()

        }
        else {
            self.addSync()
        }
    }

    //Function to keep text length in limits
    func limitText(_ upper: Int) {
        if newItem.count > upper {
            newItem = String(newItem.prefix(upper))
        }
    }

    
    private func addSync() {
        if !newItem.isEmpty {
            lists.append(Lists(name: newItem))
            newItem = ""

        }
    }
    
    func addItem() {
        
//        count! += 1
//        newItem = "item \(count ?? 0)"
        if !newItem.isEmpty {
            self.databaseRef.childByAutoId().setValue(newItem)
            newItem = ""
        }
    }
    
    func setupFirebase() {
        databaseRef = Database.database().reference()
        databaseRef.observe(.childAdded) {
            snapshot in
            if let value = snapshot.value as? String {
                self.data.append(value)
            }
        }

        databaseRef.observe(.childRemoved) {
            snapshot in
            if let value = snapshot.value as? String,
            let index = self.data.firstIndex(of: value) {
                self.data.remove(at: index)
            }
        }
    }
    
}

