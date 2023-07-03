//
//  DistinctSubscriber.swift
//  Distinct
//
//  Created by Matt Heaney on 03/07/2023.
//

import Combine
import Foundation

class DistinctSubscriber: Subscriber, Cancellable {
    
    typealias Input = Int
    typealias Failure = Never
    
    var onReceived: ((Input) -> ())
    var onCompletion: ((Subscribers.Completion<Failure>) -> ())
    private var subscription: Subscription?
    
    init(onCompletion: @escaping (Subscribers.Completion<Failure>) -> Void,
         onReceived: @escaping (Input) -> Void) {
        self.onReceived = onReceived
        self.onCompletion = onCompletion
    }
    
    func receive(_ input: Input) -> Subscribers.Demand {
        self.onReceived(input)
        return .max(1)
    }
    
    func receive(subscription: Subscription) {
        self.subscription = subscription
        subscription.request(.max(1))
    }
    
    func receive(completion: Subscribers.Completion<Failure>) {
        self.onCompletion(completion)
    }
    
    func cancel() {
       self.subscription = nil
    }
}
