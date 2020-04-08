//
//  DigitButton.swift
//  iOSBaseViews
//
//  Created by Nik on 04/01/2020.
//

import Foundation

public protocol DigitButtonDelegate: class {
    func digitPressed(_ digit: Int)
}

public class DigitButton : UIButton {
    
    ///Button color for normal state
    public var buttonColor : UIColor!
    ///Button color for pressed state
    public var pressedColor : UIColor!
    
    public weak var delegate : DigitButtonDelegate?
    var pressTimer: Timer?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        doInit()
    }
    
    init() {
        super.init(frame: .zero)
        doInit()
    }
    
    private func doInit() {
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    public override func didMoveToSuperview() {
        layer.backgroundColor = buttonColor.cgColor
        
    }
    
    deinit {
        pressTimer?.invalidate()
    }
    
    @objc func buttonPressed() {
        pressTimer?.invalidate()
        pressTimer = Timer.scheduledTimer(withTimeInterval: 0.06, repeats: false, block: {[weak self] _ in
            self?.layer.backgroundColor = self?.buttonColor.cgColor
        })
        layer.backgroundColor = pressedColor.cgColor
        guard let title = titleLabel?.text, let digit = Int(title) else { return }
        delegate?.digitPressed(digit)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
}

public extension DigitButton {
    static func getFactory(font: UIFont, titleColor: UIColor, title: String?, buttonColor : UIColor, pressedColor : UIColor) -> Factory<DigitButton> {
        let factory = { () -> DigitButton in
            let button = DigitButton()
            button.setTitle(title, for: .normal)
            button.setTitleColor(titleColor, for: .normal)
            button.titleLabel?.font = font
            button.buttonColor = buttonColor
            button.pressedColor = pressedColor
            return button
        }
        return factory
    }
}
