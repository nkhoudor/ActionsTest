//
//  EmailFormView.swift
//  Vivex
//
//  Created by Nik, 29/01/2020
//

import Foundation
import PinLayout
import RxSwift
import RxKeyboard

public class EmailFormView : UIView {
    lazy var pixel : CGFloat = UIScreen.main.bounds.height / 811.0
    var configurator: EmailFormConfiguratorProtocol!
    
    lazy var contentView : UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }()
    
    var titleLabel : UILabel!
    var subtitleLabel : UILabel?
    var textField : LabeledTextFieldView!
    var submitButton : UIButton!
    
    let disposeBag = DisposeBag()
    
    init(configurator: EmailFormConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        
        backgroundColor = configurator.backgroundColor
        
        addSubview(contentView)
        
        titleLabel = configurator.titleLabelFactory()
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
        if configurator.subtitleLabelFactory != nil {
            subtitleLabel = configurator.subtitleLabelFactory!()
            subtitleLabel!.textAlignment = .center
            subtitleLabel!.numberOfLines = 0
            contentView.addSubview(subtitleLabel!)
        }
        textField = configurator.labeledTextFieldFactory()
        contentView.addSubview(textField)
        submitButton = configurator.submitButtonFactory()
        addSubview(submitButton)
        
        RxKeyboard.instance.visibleHeight.drive(onNext: {[weak self] keyboardVisibleHeight in
            guard keyboardVisibleHeight != self?.keyboardHeight else { return }
            self?.keyboardHeight = keyboardVisibleHeight
            UIView.animate(withDuration: 0.3) {
                self?.layoutSubviews()
            }
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var keyboardHeight : CGFloat = 0.0
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonBottomOffset = keyboardHeight > 0 ? keyboardHeight + 16.0 : pin.safeArea.bottom + 16
        
        contentView.pin.top().left().right().bottom(keyboardHeight)
        
        titleLabel.pin.top(pixel * 72).left(16).right(16).sizeToFit(.width)
        
        subtitleLabel?.pin.below(of: titleLabel).marginTop(4).left(16).right(16).sizeToFit(.width)
        
        submitButton.pin.bottom(buttonBottomOffset).left(16).right(16).height(48)
        
        let size = textField.sizeThatFits(frame.size)
        let topY : CGFloat = subtitleLabel != nil ? subtitleLabel!.frame.maxY : titleLabel.frame.maxY
        let textFieldCenter : CGFloat = (submitButton.frame.minY - topY) / 2.0 + topY - size.height
        textField.pin.top(textFieldCenter).left(16).right(16).height(size.height)
    }
}
