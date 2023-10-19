//
//  ViewModel.swift
//  five
//
//  Created by Ryan Gibbons on 10/18/23.
//

import SwiftUI
import Foundation
import UIKit

enum Page {
    case open, pause
}

class ViewModel: ObservableObject {
    static let shared = ViewModel()
    
    @Published var path: Page = .open
    
    @Published var url: URL = URL(string: UIApplication.openSettingsURLString)!
    
    func navigateToPause() {
        path = .pause
    }
    
    func resetAfterExec() {
        path = .open
    }
    
    func updateUrl(changed: URL) {
        url = changed
    }
}
