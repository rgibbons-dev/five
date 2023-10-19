//
//  ShiftView.swift
//  five
//
//  Created by Ryan Gibbons on 10/18/23.
//

import SwiftUI

let skyBlue = Color(red: 0.4627, green: 0.8392, blue: 1.0)

let backgroundGradient = LinearGradient(
    colors: [skyBlue, Color.blue],
    startPoint: .top, endPoint: .bottom)

struct ShiftView: View {
    @ObservedObject var vmodel = ViewModel.shared

    var body: some View {
        ZStack {
            backgroundGradient
            if $vmodel.path.wrappedValue == Page.pause {
                PauseView()
            } else {
                OpenView()
            }
        } .ignoresSafeArea()
    }
}

#Preview {
    ShiftView()
}
