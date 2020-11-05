//
//  MelodyModel.swift
//  Melody
//
//  Created by Albert Kornas on 11/4/20.
//

import Foundation
import StoreKit





class MelodyModel : ObservableObject {
    @Published var labelText : String

    init() {
        labelText = "Hi"
    }
    
    
}
