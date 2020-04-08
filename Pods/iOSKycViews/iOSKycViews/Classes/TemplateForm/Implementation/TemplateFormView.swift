//
//  TemplateFormView.swift
//  Vivex
//
//  Created by Nik, 20/02/2020
//

import PinLayout
import RxSwift
import iOSBaseViews
import IQKeyboardManagerSwift

public class TemplateFormView : UIScrollView {
    lazy var pixel : CGFloat = UIScreen.main.bounds.height / 811.0
    
    var configurator: TemplateFormConfiguratorProtocol!
    
    let textFieldsView = IQPreviousNextView()
    var textFields : [LabeledTextFieldView] = []
    var titleLabel : UILabel!
    var subtitleLabel : UILabel?
    var submitButton : UIButton!
    
    let disposeBag = DisposeBag()
    
    init(config: TemplateFormConfigProtocol, configurator: TemplateFormConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        
        titleLabel = configurator.titleLabelFactory()
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        if configurator.subtitleLabelFactory != nil {
            subtitleLabel = configurator.subtitleLabelFactory!()
            addSubview(subtitleLabel!)
        }
        
        addSubview(titleLabel)
        
        
        addSubview(textFieldsView)
        for field in config.fields {
            let tf = configurator.labeledTextFieldFactory()
            if let inputField = field as? InputFormFieldTemplateProtocol {
                tf.setMaxLength(inputField.maxLength)
            }
            tf.validator = field
            tf.label.text = field.title
            textFields.append(tf)
            textFieldsView.addSubview(tf)
        }
        
        submitButton = configurator.submitButtonFactory()
        addSubview(submitButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    private func layout() {
        pin.left().top().right().bottom()
        titleLabel.pin.top(pixel * 72).horizontally(16).sizeToFit(.width)
        subtitleLabel?.pin.below(of: titleLabel, aligned: .center).marginTop(4).sizeToFit()
        
        for (i, tf) in textFields.enumerated() {
            let size = tf.sizeThatFits(frame.size)
            if i == 0 {
                tf.pin.top().horizontally(16).height(size.height)
            } else {
                tf.pin.below(of: textFields[i-1], aligned: .left).horizontally(16).height(size.height)
            }
        }
        textFieldsView.pin.below(of: subtitleLabel ?? titleLabel).left().right().wrapContent(.vertically)
        submitButton.pin.below(of: textFieldsView).marginTop(24).left(16).right(16).height(50)
        contentSize = CGSize(width: frame.width, height: submitButton.frame.maxY + 15)
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        pin.width(size.width)
        layout()
        let maxY : CGFloat = submitButton.frame.maxY
        return CGSize(width: frame.width, height: maxY + 15)
    }
}
