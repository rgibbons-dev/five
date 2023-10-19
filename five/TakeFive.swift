//
//  Blocker.swift
//  five
//
//  Created by Ryan Gibbons on 10/15/23.
//

import AppIntents
import SwiftUI
import Foundation

enum ToBlock: String, AppEnum {
    case instagram
    case facebook
    case x
    case snapchat
    case youtube
    case settings
    
    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "ToBlock")
    
    static var caseDisplayRepresentations: [Self: DisplayRepresentation] = [
            .instagram: "Instagram",
            .facebook: "Facebook",
            .x: "X",
            .snapchat: "Snapchat",
            .youtube: "YouTube",
            .settings: "Settings"
    ]
}

let urlDict: [ToBlock: URL] = [
    ToBlock.instagram: URL(string: "instagram://")!,
    ToBlock.facebook: URL(string: "fb://")!,
    ToBlock.x: URL(string: "twitter://")!,
    ToBlock.snapchat: URL(string: "snapchat://")!,
    ToBlock.youtube: URL(string: "youtube://")!,
    ToBlock.settings: URL(string: UIApplication.openSettingsURLString)!,
]

struct TakeFive: AppIntent {
    static var title: LocalizedStringResource = "take five"
    
    static var description: IntentDescription =
    """
    Hello, world!
    """
    
    static var openAppWhenRun: Bool = true
    
    @Parameter(title: "App")
    var app: ToBlock
    
    static var parameterSummary: some ParameterSummary {
        Summary("take five from \(\.$app)")
    }
    
    @MainActor
    func perform() async throws -> some IntentResult {
        let dest: URL? = urlDict[$app.wrappedValue]
        ViewModel.shared.updateUrl(changed: dest!)
        ViewModel.shared.navigateToPause()
        return .result()
    }
}
