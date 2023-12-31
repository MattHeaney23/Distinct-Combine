//
//  DistinctSubscription.swift
//  Distinct
//
//  Created by Matt Heaney on 03/07/2023.
//

import Combine
import Foundation

class DistinctSubscription<SubscriberType: Subscriber, OutputType: Hashable>: Subscription where SubscriberType.Input == OutputType {
    
    var subscriber: SubscriberType?
    var providedValues: [OutputType]
    var demand: Subscribers.Demand = .none
    
    private var previousValues: Set<OutputType> = []
    
    init(subscriber: SubscriberType, providedValues: [OutputType]) {
        self.providedValues = providedValues
        self.subscriber = subscriber
    }
    
    func request(_ demand: Subscribers.Demand) {
        self.demand = demand
        emitValuesIfNeeded()
    }
    
    private func emitValuesIfNeeded() {
    
        while self.demand > .none && !providedValues.isEmpty {
            let valueToEmit = providedValues.removeFirst()
            
            if !previousValues.contains(valueToEmit) {
                previousValues.insert(valueToEmit)
                self.demand -= .max(1)
                if let newDemand = subscriber?.receive(valueToEmit) {
                    self.demand += newDemand
                }
            }
        }
        
        if providedValues.isEmpty || self.demand == .none {
            self.subscriber?.receive(completion: .finished)
        }
    }
    
    func cancel() {
        subscriber = nil
    }
}
