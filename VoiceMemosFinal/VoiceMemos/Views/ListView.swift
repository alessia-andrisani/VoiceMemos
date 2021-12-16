//
//  ContentView.swift
//  VoiceMemos
//
//  Created by Alessia Andrisani on 09/12/21.
//
import AVFoundation
import SwiftUI

struct ListView: View {
    
    //Per identificare elementi nella lista
    
    @State private var editMode = false
    @State private var indice: UUID?
    
    //
    
    
    //CoreData
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name)
    ]) var recordings: FetchedResults<Recording>
    
    //
    
    @State private var showingModal: Bool = false
    @State private var opacity: Double = 1
    @State private var recordingName = ""
    
    //Per l'audio
    
    @State var audioPlayer: AVAudioPlayer?
    
    
    //Impact feedback generator
    let impact = UIImpactFeedbackGenerator(style: .medium)
    
    
    //Aggiunte per alert
    
    @State private var isShowing: Bool = false
    @State private var text: String = "New Recording Name"
    
    
    // Focus del textfield e Opacity Bottone
    
    @FocusState private var TextFieldisFocused: Bool
    
    
    
    var body: some View {
        NavigationView {
            
            
                ZStack {
                    VStack {
                    
                    List {
                        
                        ForEach(recordings) { recording in
                            VStack(alignment: .leading) {
                                if !(editMode && recording.id == indice)  {
                                    Text(recording.name ?? "Unknown")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .onTapGesture(count: 2) {
                                            editMode.toggle()
                                            indice = recording.id
                                        }
                                } else {
                                    TextField(recording.name ?? "Voice Memo", text: $recordingName, onCommit: {
                                        if !recordingName.isEmpty {
                                            changeName(item: recording)
                                            indice = nil
                                            recordingName = ""
                                        } else {
                                            indice = nil
                                            
                                        }
                                        
                                    })
                                        .keyboardType(.default)
                                        .focused($TextFieldisFocused)
                                    
                                    
                                }
                                
                                HStack {
                                    Text(recording.time ?? "No time")
                                    Spacer()
                                    Text(recording.duration ?? "No duration")
                                }
                                .padding(1)
                                
                            }
                            
                            
                        }
                        .onDelete(perform: deleteRecordings)
                        .onAppear(perform: checkOpacity)
                        .onChange(of: recordings.count) { _ in checkOpacity()}
                        
                        
                    }
                    .listStyle(PlainListStyle())
                    
                    
                    .navigationTitle("All Recordings")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) { EditButton()
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
                    
                    
                        Button (action: {
                            //azione bottone
                            print("Starting recording...")
                            showingModal.toggle()
                            startaudio()
                            impact.impactOccurred()
                            
                        })
                        {
                            
                            (Image(systemName: "record.circle")
                                .foregroundColor(.red)
                                .font(.system(size: 70)))
                                .opacity(TextFieldisFocused ? 0 : 1)
                            
                        }
                        .disabled(TextFieldisFocused == true)
                       
                        
                        
                        .sheet(isPresented: $showingModal) {
                            ModalView()
                        }
 
                }
                
                    Text("Tap the record button to create a voice memo")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .opacity(opacity)
                
            }
            
        }
    }
    
    
    //Play audio button
    
    func startaudio(){
        let audioURL = Bundle.main.url(forResource: "StartAudio", withExtension: "mp3")
        
        guard audioURL != nil else {
            print("No audio found")
            return
        }
        do{
            audioPlayer =  try AVAudioPlayer(contentsOf: audioURL!)
            audioPlayer?.play()
            
        }catch{
            print("errore \(error.localizedDescription)")
        }
        
    }
    
    //Delete function
    
    func deleteRecordings(at offsets: IndexSet) {
        for offset in offsets {
            let recording = recordings[offset]
            moc.delete(recording)
        }
        
        try? moc.save()
    }
    
    
    
    //Making the "add new recording" text disappear 
    
    func checkOpacity() {
        if recordings.count == 0 {
            opacity = 1
            
        } else {
            opacity = 0
            
        }
        print("Sto facendo check opacity")
    }
    
    //    Per cambiare nome al recording
    
    func changeName(item: Recording) {
        if let index = recordings.firstIndex(where: { $0.id == item.id }) {
            print(index)
            recordings[index].name = recordingName
        }
        try? moc.save()
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ListView()
        
        ListView().preferredColorScheme(.dark)
    }
}
