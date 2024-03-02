//
//  WelcomeVC.swift
//  ScopicAppAssignment
//
//  Created by HAR-LAP046-080 on 28/02/2024.
//

import SwiftUI

struct WelcomeVC: View {
    
    @State var selection: Int? = nil
    @Binding var rootIsActive : Bool

    var body: some View {
        
            Text("Welcome All").fontWeight(.bold)
            
            Spacer()

            Text("Hi there! Nice to see you")
            
            Spacer()

             NavigationLink(destination: ListVC(shouldPopToRootView: self.$rootIsActive), tag: 1, selection: $selection) {
                 Button(action: {
                     print("list tapped")
                     self.selection = 1
                 }) {
                     HStack {
                         Spacer()
                         Text("List ").foregroundColor(Color.white).bold()
                         Spacer()
                     }
                 }
                 .accentColor(Color.black)
                 .padding()
                        .background(Color.Orange)
                 .cornerRadius(4.0)
                 .padding(Edge.Set.vertical, 20)
                 .frame(width: 300)
             }
             .isDetailLink(false)

             .navigationBarBackButtonHidden()

    }
}
