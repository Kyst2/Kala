//
//  addOpacityBlinker.swift
//  AppCore
//
//  Created by UKS on 27.12.2020.
//  Copyright © 2020 Loki. All rights reserved.
//

import SwiftUI
import Combine

@available(OSX 11.0, *)
public extension View {
    func addTextBlinker<T: Publisher>(subscribedTo publisher: T, text: String = "Copied", duration: Double = 0.9)
        -> some View where T.Output == Void, T.Failure == Never {
            
            // here I take whatever publisher we got and type erase it to AnyPublisher
            //   that just simplifies the type so I don't have to add extra generics below
            self.modifier(CopiedBlinker(subscribedTo: publisher.eraseToAnyPublisher(), text: text,
                                         duration: duration))
    }
}

@available(OSX 11.0, *)
public struct CopiedBlinker: ViewModifier {
    @State private var isDisplayed = false
    var publisher: AnyPublisher<Void, Never>
    var text: String
    var duration: Double
    
    public init(subscribedTo publisher: AnyPublisher<Void, Never>, text: String, duration: Double = 1) {
        self.publisher = publisher
        self.duration = duration
        self.text = text
    }
    
    public func body(content: Content) -> some View {
        ZStack{
            content
                .opacity(isDisplayed ? 0 : 1)
                .onReceive(publisher) { _ in
                    withAnimation(.easeOut(duration: self.duration / 2)) {
                        self.isDisplayed = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + self.duration / 2) {
                            withAnimation(.easeIn(duration: self.duration / 2)) {
                                self.isDisplayed = false
                            }
                        }
                    }
                }
            
            Text(text)
                .opacity(isDisplayed ? 1 : 0)
        }
    }
}
