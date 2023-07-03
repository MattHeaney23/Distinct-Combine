//
//  DistinctPublisher.swift
//  Distinct
//
//  Created by Matt Heaney on 03/07/2023.
//

import Combine
import Foundation

class DistinctPublisher: Publisher {
    
    typealias Output = Int
    typealias Failure = Never
    
    let valuesToEmit: [Int]
    
    init(valuesToEmit: [Int]) {
        self.valuesToEmit = valuesToEmit
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        let subscription = DistinctSubscription(subscriber: subscriber,
                                                providedValues: valuesToEmit)
        subscriber.receive(subscription: subscription)
    }
}
