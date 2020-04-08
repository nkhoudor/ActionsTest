//
//  TemplateFormPresenterProtocol.swift
//
//  Created by Nik, 20/02/2020
//

import Foundation

public protocol TemplateFormPresenterProtocol {
    var configurator : TemplateFormConfiguratorProtocol { get }
    func viewDidLoad(view: TemplateFormViewProtocol)
    func getConfig() -> TemplateFormConfigProtocol
    func submitPressed()
}
