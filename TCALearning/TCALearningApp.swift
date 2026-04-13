//
//  TCALearningApp.swift
//  TCALearning
//
//  Created by Guilherme Ghise Rossoni on 13/04/26.
//

import ComposableArchitecture
import SwiftUI

@main
struct TCALearningApp: App {
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            CounterView(store: TCALearningApp.store)
        }
    }
}
