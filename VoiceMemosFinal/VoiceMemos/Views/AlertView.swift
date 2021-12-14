//
//  AlertView.swift
//  VoiceMemos
//
//  Created by Alessia Andrisani on 13/12/21.
//

import SwiftUI


//Custom alert con textfield 

struct AlertView: View {
    let screenSize = UIScreen.main.bounds
    
    @Binding var isShowing: Bool
    @Binding var text: String
    @FocusState private var alertIsFocused: Bool
    var title: String = "Rename the recording"
    var onDone: () -> Void = {  }
    
    var body: some View {
        
        VStack {
            Spacer()
            Text(title)
            TextField("", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.default)
                .focused($alertIsFocused)
                
            Spacer()
            HStack {
                
                Button("Cancel") {
                    isShowing = false
                    alertIsFocused = false
                }
                Spacer()
                Button("Done") {
                    isShowing = false
                    self.onDone()
                    alertIsFocused = false
                }
                
                
            }
            .padding()
            
        }
//        .toolbar {
//            ToolbarItem(placement: .keyboard) {
//                Button("Done") {
//                    alertIsFocused = false
//                    isShowing = false
//                    self.onDone()
//            } 
//        }
//    }
        .padding()
        .frame(width: screenSize.width * 0.7, height: screenSize.height * 0.2)
        .background(Color(red:239/255, green: 240/255, blue: 240/255))
        .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
        .offset(y: isShowing ? 0 : screenSize.height)
        .animation(.easeIn, value: 2)
       
    }
    
        
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(isShowing: .constant(true), text: .constant(""))
    }
}
