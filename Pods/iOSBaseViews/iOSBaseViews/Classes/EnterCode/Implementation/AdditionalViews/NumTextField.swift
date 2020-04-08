//
//  NumTextField.swift
//  iOSBaseViews
//
//  Created by Nik on 06/01/2020.
//

import Foundation
import RxSwift
import RxRelay

public enum NumTextFieldState {
    case normal
    case success
    case error
}

public protocol NumTextFieldDelegate : class {
    func deleteBackward(textField: NumTextField)
}

public class NumTextField : UITextField {
    var textNormalColor : UIColor!
    var textSuccessColor : UIColor!
    var textErrorColor : UIColor!
    var normalColor : UIColor!
    var successColor : UIColor!
    var errorColor : UIColor!
    
    public weak var numDelegate: NumTextFieldDelegate?
    
    ///Accept and observe NumTextField state
    public let numState : BehaviorRelay<NumTextFieldState> = BehaviorRelay.init(value: .normal)
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        doInit()
    }
    
    init() {
        super.init(frame: .zero)
        doInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func doInit() {
        textAlignment = .center
        keyboardType = .numberPad
    }
    
    public override func deleteBackward() {
        text = ""
        numDelegate?.deleteBackward(textField: self)
    }
    
    public override func didMoveToSuperview() {
        numState.subscribe(onNext: {[weak self] state in
            self?.updateState(state)
        }).disposed(by: disposeBag)
    }
    
    private func updateState(_ state: NumTextFieldState) {
        switch state {
        case .normal:
            textColor = textNormalColor
            layer.backgroundColor = normalColor.cgColor
        case .success:
            textColor = textSuccessColor
            layer.backgroundColor = successColor.cgColor
        case .error:
            textColor = textErrorColor
            layer.backgroundColor = errorColor.cgColor
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 4
    }
}

public extension NumTextField {
    static func getFactory(font: UIFont, textNormalColor: UIColor, textSuccessColor: UIColor, textErrorColor: UIColor, normalColor: UIColor, successColor: UIColor, errorColor: UIColor) -> Factory<NumTextField> {
        let factory = { () -> NumTextField in
            let tf = NumTextField()
            tf.font = font
            tf.textNormalColor = textNormalColor
            tf.textSuccessColor = textSuccessColor
            tf.textErrorColor = textErrorColor
            tf.normalColor = normalColor
            tf.successColor = successColor
            tf.errorColor = errorColor
            return tf
        }
        return factory
    }
}
