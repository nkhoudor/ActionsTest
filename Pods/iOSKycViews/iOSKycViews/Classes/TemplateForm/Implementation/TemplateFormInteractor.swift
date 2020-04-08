//
//  TemplateFormInteractor.swift
//
//  Created by Nik, 20/02/2020
//


public class TemplateFormInteractor : TemplateFormInteractorProtocol {
    
    public var config: TemplateFormConfigProtocol
    
    public init(config: TemplateFormConfigProtocol) {
        self.config = config
    }
}
