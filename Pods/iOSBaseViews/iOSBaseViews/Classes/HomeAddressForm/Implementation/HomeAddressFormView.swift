//
//  HomeAddressFormView.swift
//  Vivex
//
//  Created by Nik, 22/01/2020
//

import Foundation
import PinLayout
import RxKeyboard
import RxSwift

public class HomeAddressFormView : UIScrollView {
    lazy var pixel : CGFloat = UIScreen.main.bounds.height / 811.0
    var configurator: HomeAddressFormConfiguratorProtocol!
    
    var textFields : [LabeledTextFieldView] = []
    var titleLabel : UILabel!
    var subtitleLabel : UILabel!
    var submitButton : UIButton!
    
    let disposeBag = DisposeBag()
    
    init(inputs: [String], configurator: HomeAddressFormConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        
        titleLabel = configurator.titleLabelFactory()
        subtitleLabel = configurator.subtitleLabelFactory()
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        
        
        for input in inputs {
            let tf = configurator.labeledTextFieldFactory()
            tf.label.text = input
            textFields.append(tf)
            addSubview(tf)
        }
        
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
    
    var keyboardHeight : CGFloat = 0.0
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    private func layout() {
        pin.left().top().right().bottom(keyboardHeight)
        titleLabel.pin.top(pixel * 72).hCenter().sizeToFit()
        subtitleLabel.pin.below(of: titleLabel, aligned: .center).marginTop(4).sizeToFit()
        
        for (i, tf) in textFields.enumerated() {
            let size = tf.sizeThatFits(frame.size)
            if i == 0 {
                tf.pin.below(of: subtitleLabel).horizontally(16).height(size.height)
            } else {
                tf.pin.below(of: textFields[i-1], aligned: .left).horizontally(16).height(size.height)
            }
        }
        submitButton.pin.below(of: textFields.last!).marginTop(24).left(16).right(16).height(50)
        contentSize = CGSize(width: frame.width, height: submitButton.frame.maxY + 15)
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        pin.width(size.width)
        layout()
        let maxY : CGFloat = submitButton.frame.maxY
        return CGSize(width: frame.width, height: maxY + 15)
    }
}
