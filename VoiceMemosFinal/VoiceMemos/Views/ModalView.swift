//
//  ModalView.swift
//  VoiceMemos
//
//  Created by Alessia Andrisani on 09/12/21.
//
import AVFoundation
import SwiftUI

struct ModalView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name)
    ]) var recordings: FetchedResults<Recording>
    @State private var name = ""
    @State private var time = Date()
    @State private var duration = "0.3"
    @State private var randomDouble = Double.random(in: 0...5)
    
    @State var audioPlayer: AVAudioPlayer?

    //Impact feedback generator
    let impact = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        
        VStack {
            Spacer()
            Text("New Voice Memo")
                .font(.largeTitle)
                .bold()
                .padding()
            Text("00:01,25")
                .foregroundColor(.secondary)
                .font(.title2)
            Image(systemName: "waveform")
                .font(.system(size: 100))
                .foregroundColor(.red)
                .padding()
           
            Text("Recording...")
                .font(.title2)
            Spacer()
            
            Button (action: {
                print("Stopping recording...")
//                showingModal = false
                startaudio()
                impact.impactOccurred()

                //Crea una nuova registrazione

                let newRecording = Recording(context: moc)
                newRecording.id = UUID()
                
                if recordings.count == 0 {
                    
                    newRecording.name = "Voice Memo"
                } else {
                    newRecording.name = "Voice Memo \(recordings.count)"
                    
                }

                newRecording.time = time.timeFormatted
                newRecording.duration = String(format: "%.1f", ceil(randomDouble * 10) / 10.0)
                
                if moc.hasChanges {
                    try? moc.save()
                }
                dismiss()
                
                
              
            })
            {
                
                (Image(systemName: "stop.circle")
                    .foregroundColor(.red)
                    .font(.system(size: 70)))
                
            }
            
        }
        
    
        
        
    }
  
    //Play audio button
    
    func startaudio(){
         let audioURL = Bundle.main.url(forResource: "StopAudio", withExtension: "mp3")
        
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
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
