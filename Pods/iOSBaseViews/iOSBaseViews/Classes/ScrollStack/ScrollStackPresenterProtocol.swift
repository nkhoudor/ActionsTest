//
//  ScrollStackPresenterProtocol.swift
//
//  Created by Nik, 6/01/2020
//

import Foundation

public protocol ScrollStackPresenterProtocol {
    var configurator : ScrollStackConfiguratorProtocol { get }
    func viewInited(view: ScrollStackViewProtocol)
    
}
