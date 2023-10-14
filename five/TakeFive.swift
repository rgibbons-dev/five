//
//  TakeFive.swift
//  five
//
//  Created by Ryan Gibbons on 10/13/23.
//

import SwiftUI

let timer = Timer
    .publish(every: 1, on: .main, in: .common)
    .autoconnect()

struct InnerCircle: View {
    var body: some View {
        Circle()
            .stroke(
                .gray,
                style: StrokeStyle(
                    lineWidth: 40,
                    lineCap: .round,
                    lineJoin: .round
                )
            )
            .fill(.yellow)
            .frame(width: 300, height: 300)
    }
}

struct OuterProgress: View {
    var countTo: Int
    var ct: Int
    var body: some View {
        Circle()
            .trim(
                from: 0,
                to: (CGFloat(ct) / CGFloat(countTo))
            )
            .stroke(
                .purple,
                style: StrokeStyle(
                    lineWidth: 20
                )
            )
            .frame(width: 320, height: 320)
            .animation(
                .easeInOut(duration: 0.1),
                value: 1
            )
    }
}

struct TakeFive: View {
    @State var ct: Int = 0
    @State var viewCt: Int = 10
    var countTo: Int = 10
    @State var elapsed: CGFloat = 0.0
    var body: some View {
        VStack {
            Text("\(viewCt)")
                .background(
                    ZStack {
                        InnerCircle()
                        OuterProgress(countTo: countTo, ct: ct)
                    }
                )
        } .onReceive(timer, perform: { time in
            if ct < countTo {
                ct += 1
                viewCt -= 1
            }
        })
    }
}

#Preview {
    TakeFive()
}
