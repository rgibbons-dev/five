//
//  TakeFive.swift
//  five
//
//  Created by Ryan Gibbons on 10/13/23.
//

import SwiftUI
import Foundation
import UIKit

let counter = Timer
    .publish(every: 1, on: .main, in: .common)
    .autoconnect()

let progress = Timer
    .publish(every: 0.01, on: .main, in: .common)
    .autoconnect()

let neon = Color(red: 0.1, green: 0.93, blue: 0.45)

struct InnerCircle: View {
    var body: some View {
        Circle()
            .stroke(
                .gray,
                style: StrokeStyle(
                    lineWidth: 20                )
            )
            .fill(.clear)
            .frame(width: 300, height: 300)
    }
}

struct OuterProgress: View {
    @State var elapsed: CGFloat = 0.0
    @State var seconds: CGFloat = 0.0
    var countTo: Int
    var body: some View {
        ZStack {
            Circle()
                .trim(
                    from: 0,
                    to: crawl()
                )
                .stroke(
                    neon,
                    style: StrokeStyle(
                        lineWidth: 20,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
                .frame(width: 300, height: 300)
                .animation(
                    .easeInOut(duration: 0.11),
                    value: 1
                )
        } .onReceive(progress, perform: { _ in
            elapsed += 0.01
            if elapsed >= 1.0 {
                seconds += 1
                elapsed = 0.0
            }
        })
    }
    
    func crawl() -> CGFloat {
        return (CGFloat(elapsed + seconds) / CGFloat(countTo))
    }
}

struct PauseView: View {
    @ObservedObject var vmodel = ViewModel.shared
    @State var viewCt: Int = 9
    @State var isComplete: Bool = false
    var countTo: Int = 9
    
    var body: some View {
        VStack {
            Image(systemName: "\(viewCt).circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundStyle(neon)
                .background(
                    ZStack {
                        InnerCircle()
                        OuterProgress(countTo: countTo)
                    }
                )
                .padding([.top, .bottom], 200)
            Button(
                action: {
                    UIApplication.shared.open($vmodel.url.wrappedValue)
                    vmodel.resetAfterExec()
                },
                label: {
                    Text("Continue to the app!")
                        .foregroundStyle(.white)
                }
            )
            .tint(neon)
            .buttonStyle(.bordered)
            .opacity(isComplete ? 1 : 0)
        } .onReceive(counter, perform: { _ in
            if viewCt > 0 {
                viewCt -= 1
            } else {
                isComplete = true
            }
        })
    }
}

#Preview {
    PauseView()
}
