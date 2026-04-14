//
//  TCALearningTests.swift
//  TCALearningTests
//
//  Created by Guilherme Ghise Rossoni on 14/04/26.
//

import ComposableArchitecture
import Testing


@testable import TCALearning

@MainActor
struct CounterFeatureTests {
    
    // MARK: - Basics
    
    @Test
    func basics() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        
        await store.send(.incrementButtonTapped) {
            $0.count = 1
        }
        
        await store.send(.decrementButtonTapped) {
            $0.count = 0
        }
    }
    
    // MARK: - Timer
    
    @Test
    func timer() async {
        let clock = TestClock()
        
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.continuousClock = clock
        }
        
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = true
        }
        
        await clock.advance(by: .seconds(1))
        await store.receive(\.timerTick) {
            $0.count += 1
        }
        
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = false
        }
    }
    
    // MARK: - Requisitions
    
    @Test
    func numberFact() async {
        let store = TestStore(initialState: CounterFeature.State()) {
          CounterFeature()
        } withDependencies: {
            $0.numberFact.fetch = { "\($0) is a good number." }
          }
        
        await store.send(.factButtonTapped) {
          $0.isLoading = true
        }
        await store.receive(\.factResponse) {
             $0.isLoading = false
             $0.fact = "0 is a good number."
           }
      }
    
    @Test
      func incrementInFirstTab() async {
          let store = TestStore(initialState: AppFeature.State()) {
              AppFeature()
          }
          
          await store.send(\.tab1.incrementButtonTapped) {
              $0.tab1.count = 1
          }
      }
}


