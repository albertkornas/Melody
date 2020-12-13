//
//  State.swift
//  Melody
//
//  Created by Albert Kornas on 12/12/20.
//

import Foundation
import Combine

class FlowState: ObservableObject {
    enum Process {
        case onboarding, home
    }
    let objectWillChange = PassthroughSubject<FlowState, Never>()
    
    @Published var process: Process = .onboarding {
        didSet {
            objectWillChange.send(self)
        }
    }
}
