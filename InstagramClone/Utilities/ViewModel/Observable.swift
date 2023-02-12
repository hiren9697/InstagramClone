//
//  Observable.swift
//  MVVMDemo
//
//  Created by Hiren Faldu Solution on 08/03/22.
//

import Foundation

//class Observable<T> {
//    var value: T? {
//        didSet {
//            listener?(value)
//        }
//    }
//
//    init(_ value: T?) {
//        self.value = value
//    }
//
//    private var listener: ((T?)-> Void)?
//
//    func bind(_ listener: @escaping (T?)-> Void) {
//        listener(value)
//        self.listener = listener
//    }
//}

public class Observable<ObservedType> {
    public typealias Observer = (_ observable: Observable<ObservedType>, ObservedType) -> Void

    private var observers: [Observer]

    public var value: ObservedType? {
        didSet {
            if let value = value {
                notifyObservers(value)
            }
        }
    }
    
    public var hasObservers: Bool {
        return !observers.isEmpty
    }

    public init(_ value: ObservedType? = nil) {
        self.value = value
        observers = []
    }

    public func bind(observer: @escaping Observer) {
        self.observers.append(observer)
    }

    private func notifyObservers(_ value: ObservedType) {
        self.observers.forEach { [unowned self](observer) in
            observer(self, value)
        }
    }
}
