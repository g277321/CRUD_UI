//
//  CRUD_UIApp.swift
//  CRUD_UI
//
//  Created by PPG on 24.08.22.
//

import SwiftUI

@main
struct CRUD_UIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(ViewModel())
        }
    }
}
