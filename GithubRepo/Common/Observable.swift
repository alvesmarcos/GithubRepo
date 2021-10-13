//
//  Observable.swift
//  GithubRepo
//
//  Created by Marcos Alves on 09/10/21.
//

import Foundation

final class Observable<T> {
    struct Observer<T> {
        weak var observer: AnyObject?
        let closure: (T) -> Void
    }
    
    
    private var observers = [Observer<T>]()
    
    var value: T {
        didSet {
            self.notifyObservers()
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    deinit {
        self.observers.removeAll()
    }
    
    func addObserver(_ observer: AnyObject, closure: @escaping (T) -> Void) {
        self.observers.append(Observer(observer: observer, closure: closure))
    }
    
    func addAndNotify(observer: AnyObject, closure: @escaping (T) -> Void) {
        self.addObserver(observer, closure: closure)
        closure(self.value)
    }
    
    func remove(observer: AnyObject) {
        self.observers = self.observers.filter { $0.observer !== observer }
    }
    
    func notifyObservers() {
        for observer in observers {
            if Thread.isMainThread {
                observer.closure(self.value)
            } else {
                DispatchQueue.main.async {
                    observer.closure(self.value)
                }
            }
        }
    }
    
}
