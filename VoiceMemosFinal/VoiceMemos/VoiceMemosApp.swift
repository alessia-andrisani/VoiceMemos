//
//  VoiceMemosApp.swift
//  VoiceMemos
//
//  Created by Alessia Andrisani on 09/12/21.
//

import SwiftUI

@main
struct VoiceMemosApp: App {
    @StateObject private var dataController = DataController()
   
    var body: some Scene {
        WindowGroup {
            ListView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}

