//
//  EmailFormConfiguratorProtocol.swift
//
//  Created by Nik, 29/01/2020
//

public protocol EmailFormConfiguratorProtocol {
    var backgroundColor : UIColor { get }
    var titleLabelFactory : Factory<UILabel> { get }
    var subtitleLabelFactory : Factory<UILabel>? { get }
    var labeledTextFieldFactory : Factory<LabeledTextFieldView> { get }
    var submitButtonFactory : Factory<UIButton> { get }
}
