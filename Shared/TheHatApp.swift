//
//  TheHatApp.swift
//  Shared
//
//  Created by Christopher Papa on 11/13/20.
//

import SwiftUI

@main
struct TheHatApp: App {
    var body: some Scene {
        WindowGroup {
            HatPickerView()
                .onAppear {
                    Cache.appDidLoad()
                }
        }
    }
}
