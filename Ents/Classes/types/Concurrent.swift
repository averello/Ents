//
//  Concurrent.swift
//  Ents
//
//  Created by Georges Boumis on 06/12/2018.
//  Copyright © 2016-2019 Georges Boumis.
//  Licensed under MIT (https://github.com/averello/Ents/blob/master/LICENSE)
//

import Foundation

public protocol Concurrent {
    associatedtype V
    var value: V { get }
    func atomically(_ transform: (inout V) -> Void)
}

// sorted by perfomance
// best on top
public enum ConcurrentLock {
    case spinLock
    @available(iOS 10.0, *)
    case unfairLock
    case objc

    case mutex
    case nslock
    case nsrecursivelock
    case rwlock
    case queue
    case semaphore
}

public func ConcurrentValue<V>(_ lock: ConcurrentLock, value: V) -> ConcurrentBase<V> {
    switch lock {
    case .queue:
        return QueueConcurrent<V>(value)
    case .spinLock:
        return SpinLockConcurrent<V>(value)
    case .mutex:
        return MutexConcurrent<V>(value)
    case .rwlock:
        return ReadWriteConcurrent<V>(value)
    case .semaphore:
        return SemaphoreConcurrent<V>(value)
    case .nslock:
        return LockConcurrent<V>(value)
    case .nsrecursivelock:
        return RecursiveConcurrent<V>(value)
    case .objc:
        return ObjCConcurrent<V>(value)

    case .unfairLock:
        if #available(iOS 10.0, *) {
            return UnfairLockConcurrent<V>(value)
        }
        else {
            assert(false)
            return SpinLockConcurrent<V>(value)
        }
    }
}

open class ConcurrentBase<V>: Concurrent {
    final /* protected */ var _value: V

    public init(_ value: V) {
        self._value = value
    }

    // override point
    open var value: V {
        // abstract
        return _value
    }

    // override point
    open func atomically(_ transform: (inout V) -> Void) {
        // abstract
    }
}

final public class QueueConcurrent<A>: ConcurrentBase<A> {
    final private let queue = DispatchQueue(label: "Ents.Concurrent")

    final override public var value: A {
        return self.queue.sync { super.value }
    }

    final override public func atomically(_ transform: (inout A) -> Void) {
        self.queue.sync { transform(&self._value) }
    }
}

final public class MutexConcurrent<A>: ConcurrentBase<A> {
    final private var lock: pthread_mutex_t

    public override init(_ value: A) {
        var lock = pthread_mutex_t()
        pthread_mutex_init(&lock, nil)
        self.lock = lock
        super.init(value)
    }

    deinit {
        pthread_mutex_destroy(&self.lock)
    }

    final override public var value: A {
        let value: A
        pthread_mutex_lock(&self.lock)
        value = self._value
        pthread_mutex_unlock(&self.lock)
        return value
    }

    final override public func atomically(_ transform: (inout A) -> Void) {
        pthread_mutex_lock(&self.lock)
        transform(&self._value)
        pthread_mutex_unlock(&self.lock)
    }
}

@available(iOS 10.0, *)
final public class UnfairLockConcurrent<A>: ConcurrentBase<A> {
    final private var lock: os_unfair_lock_s

    public override init(_ value: A) {
        self.lock = os_unfair_lock_s()
        super.init(value)
    }

    final override public var value: A {
        let value: A
        if !os_unfair_lock_trylock(&self.lock) {
            os_unfair_lock_lock(&self.lock)
        }
        value = self._value
        os_unfair_lock_unlock(&self.lock)
        return value
    }

    final override public func atomically(_ transform: (inout A) -> Void) {
        if !os_unfair_lock_trylock(&self.lock) {
            os_unfair_lock_lock(&self.lock)
        }
        transform(&self._value)
        os_unfair_lock_unlock(&self.lock)
    }
}

final public class SemaphoreConcurrent<A>: ConcurrentBase<A> {
    final private var lock: DispatchSemaphore

    public override init(_ value: A) {
        self.lock = DispatchSemaphore(value: 1)
        super.init(value)
    }

    final override public var value: A {
        let value: A
        _ = self.lock.wait(timeout: .distantFuture)
        value = self._value
        self.lock.signal()
        return value
    }

    final override public func atomically(_ transform: (inout A) -> Void) {
        _ = self.lock.wait(timeout: .distantFuture)
        transform(&self._value)
        self.lock.signal()
    }
}

final public class SpinLockConcurrent<A>: ConcurrentBase<A> {
    final private var lock: OSSpinLock

    public override init(_ value: A) {
        self.lock = OS_SPINLOCK_INIT
        super.init(value)
    }

    final override public var value: A {
        let value: A
        OSSpinLockLock(&self.lock)
        value = self._value
        OSSpinLockUnlock(&self.lock)
        return value
    }

    final override public func atomically(_ transform: (inout A) -> Void) {
        OSSpinLockLock(&self.lock)
        transform(&self._value)
        OSSpinLockUnlock(&self.lock)
    }
}

final public class ObjCConcurrent<A>: ConcurrentBase<A> {
    public override init(_ value: A) {
        super.init(value)
    }

    final override public var value: A {
        let value: A
        objc_sync_enter(self)
        value = self._value
        objc_sync_exit(self)
        return value
    }

    final override public func atomically(_ transform: (inout A) -> Void) {
        objc_sync_enter(self)
        transform(&self._value)
        objc_sync_exit(self)
    }
}

final public class LockConcurrent<A>: ConcurrentBase<A> {
    final private let lock: NSLock
    public override init(_ value: A) {
        self.lock = NSLock()
        super.init(value)
    }

    final override public var value: A {
        let value: A
        self.lock.lock()
        value = self._value
        self.lock.unlock()
        return value
    }

    final override public func atomically(_ transform: (inout A) -> Void) {
        self.lock.lock()
        transform(&self._value)
        self.lock.unlock()
    }
}

final public class RecursiveConcurrent<A>: ConcurrentBase<A> {
    final private let lock: NSRecursiveLock
    public override init(_ value: A) {
        self.lock = NSRecursiveLock()
        super.init(value)
    }

    final override public var value: A {
        let value: A
        self.lock.lock()
        value = self._value
        self.lock.unlock()
        return value
    }

    final override public func atomically(_ transform: (inout A) -> Void) {
        self.lock.lock()
        transform(&self._value)
        self.lock.unlock()
    }
}

final public class ReadWriteConcurrent<A>: ConcurrentBase<A> {
    final private var lock: pthread_rwlock_t

    public override init(_ value: A) {
        var lock = pthread_rwlock_t()
        pthread_rwlock_init(&lock, nil)
        self.lock = lock
        super.init(value)
    }

    deinit {
        pthread_rwlock_destroy(&self.lock)
    }

    final override public var value: A {
        let value: A
        pthread_rwlock_rdlock(&self.lock)
        value = self._value
        pthread_rwlock_unlock(&self.lock)
        return value
    }

    final override public func atomically(_ transform: (inout A) -> Void) {
        pthread_rwlock_wrlock(&self.lock)
        transform(&self._value)
        pthread_rwlock_unlock(&self.lock)
    }
}
