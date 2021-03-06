//
//  RRx+Extension.swift
//  RRSwiftListingWithoutStoryboard
//
//  Created by Rahul Mayani on 11/08/20.
//  Copyright © 2020 RR. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {
    
    /// Get observable
    /// The Defer operator waits until an observer subscribes to it, and then it generates an Observable,
    /// typically with an Observable factory function. It does this afresh for each subscriber, so although each subscriber may think it is subscribing to the same Observable,
    /// in fact each subscriber gets its own individual sequence.
    /// Default implementation of converting `ObservableType` to `Observable`.
    public func setDeferredAsObservable() -> Observable<Element> {
        return Observable.deferred {
            return self.asObservable()
        }
    }
    
    /**
     Makes the observable Subscribe to concurrent background thread and Observe on main thread
     */
    public func subscribeConcurrentBackgroundToMainThreads() -> Observable<Element> {
        return self.subscribeOn(RXScheduler.concurrentBackground)
            .observeOn(RXScheduler.main)
    }
    
    /**
     Makes the observable Subscribe to concurrent background thread with delay and Observe on main thread
     */
    public func delaySubscribeConcurrentBackgroundToMainThreads(_ time: RxTimeInterval = .seconds(2)) -> Observable<Element> {
        return self.delaySubscription(time, scheduler: RXScheduler.concurrentBackground)
            .observeOn(RXScheduler.main)
    }
}

public struct RXScheduler {
    static let main = MainScheduler.instance

    static let concurrentBackground = ConcurrentDispatchQueueScheduler.init(qos: .background)
}
