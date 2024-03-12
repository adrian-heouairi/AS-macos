//
//  TestXXXXXXXXXXXApp.swift
//  TestXXXXXXXXXXX
//
//  Created by Jean-Baptiste Yunès on 22/02/2024.
//

import SwiftUI

var counter = 0

@main
struct TestXXXXXXXXXXXApp: App {
    let manager = DataManager(true)
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    var body: some Scene {
        WindowGroup {
            ContentView(manager: manager)
                .onReceive(timer) {
                _ in
                if counter<30 {
                    manager.add()
                    counter += 1
                } else {
                    timer.upstream.connect().cancel()
                }
            }
        }
    }
}
