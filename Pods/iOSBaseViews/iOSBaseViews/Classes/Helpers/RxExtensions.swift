//
//  RxExtensions.swift
//  CoreStore
//
//  Created by Nik on 26/02/2020.
//

import RxSwift

public extension ObservableType {

    func withPrevious(startWith first: Element) -> Observable<(previous: Element, current: Element)> {
        return scan((first, first)) { ($0.1, $1) }.skip(1)
    }
}
