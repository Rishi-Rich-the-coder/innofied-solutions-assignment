//
//  Observable.swift
//  InnofiedSolutionAssignment
//
//  Created by Rishikesh Yadav on 3/16/21.
//

import Foundation

class Observable<T> {
    
    typealias Listener = ((T) -> Void)
    private var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(to closure: @escaping Listener) {
        closure(value)
        listener = closure
    }
}
