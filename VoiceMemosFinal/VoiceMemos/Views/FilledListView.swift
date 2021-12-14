//
//  FilledListView.swift
//  VoiceMemos
//
//  Created by Alessia Andrisani on 09/12/21.
//

import SwiftUI



@ViewBuilder var ListRow: some View {
    VStack(alignment: .leading) {
        Text("New Voice Memo")
            .font(.title2)
            .bold()
        
        HStack {
            Text("18:00")
            Spacer()
            Text("00:08")
        }.padding(1)
        
    }
    
}
    



struct FilledListView: View {
    @State private var showingModal: Bool = false
    
    
    
    var body: some View {
        NavigationView {
            
            VStack {
                ZStack {
                    
                    List {
                        
                        ListRow
                        ListRow
                        ListRow
                        
                        
                    }
                    
                    .navigationTitle("All Recordings")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) { Button("Edit") {
                            //azione bottone
                        }
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button (action: {
                                //azione bottone
                            })
                            {
                                
                                
                                Image(systemName: "chevron.left")
                            }
                        }
                    }
                    .searchable(text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=$text@*/.constant("")/*@END_MENU_TOKEN@*/, placement: /*@START_MENU_TOKEN@*/.automatic/*@END_MENU_TOKEN@*/)
                    
                }
                
                Button (action: {
                    
                    print("Starting recording...")
                    showingModal.toggle()
                    //azione bottone
                })
                {
                    
                    (Image(systemName: "record.circle")
                        .foregroundColor(.red)
                        .font(.system(size: 70)))
                    
                }
                .sheet(isPresented: $showingModal) {
                    ModalView()
                }
            }
        }
    }
    
}

struct FilledListView_Previews: PreviewProvider {
    static var previews: some View {
        FilledListView()
    }
}
