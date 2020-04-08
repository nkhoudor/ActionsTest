//
//  PrimaryButton.swift
//  iOSBaseViews
//
//  Created by Nik on 02/01/2020.
//

import Foundation
import RxSwift
import RxRelay
import PinLayout
import MaterialComponents.MaterialActivityIndicator

public typealias Factory<Instance> = () -> Instance
public typealias ConfigurationFactory<Instance> = (Instance) -> Void

///Possible states for Primare Button
public enum PrimaryButtonState {
    ///Normal state shows Title and normal background color
    case normal
    ///Pressed state shows Title. Background has 10% opaque black overlay
    case pressed
    ///Loading state hides Title, shows loading indicator. Background has 10% opaque black overlay
    case loading
    ///Success state hides Title, shows success icon. Backgroud is normal
    case success
}

///Primary action button
public class PrimaryButton : UIButton {
    
    ///Button color for normal state
    public var buttonColor : UIColor!
    ///Shadow color for normal state
    public var shadowColor : UIColor!
    ///Button color for success state
    public var successColor : UIColor!
    ///Shadow color for success state
    public var successShadowColor : UIColor!
    ///Icon for success state instead of title
    public var successImage : UIImage!
    
    public var cornerRadius : CGFloat = 4.0
    
    private var shadowLayer : CAShapeLayer!
    private var activityIndicator : MDCActivityIndicator!
    
    ///Accept and observe primary button state
    public let primaryState : BehaviorRelay<PrimaryButtonState> = BehaviorRelay.init(value: .normal)
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        doInit()
    }
    
    init() {
        super.init(frame: .zero)
        doInit()
    }
    
    private func doInit() {
        activityIndicator = MDCActivityIndicator()
        activityIndicator.isUserInteractionEnabled = false
        activityIndicator.cycleColors = [.white]
        activityIndicator.sizeToFit()
        addSubview(activityIndicator)
        primaryState.subscribe(onNext: {[weak self] state in
            self?.updateState(state)
        }).disposed(by: disposeBag)
        contentEdgeInsets = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var pressedLayer : CAShapeLayer!
    
    private func updateState(_ state: PrimaryButtonState) {
        if pressedLayer != nil {
            pressedLayer.isHidden = [.normal, .success].contains(state)
        }
        if state == .loading {
            titleLabel?.alpha = 0.0
            activityIndicator.alpha = 1.0
            activityIndicator.startAnimating()
        } else {
            titleLabel?.alpha = 1.0
            activityIndicator.alpha = 0.0
            activityIndicator.stopAnimating()
        }
    }
    
    public func setBackgroundColor(backgroundColor: UIColor, shadowColor: UIColor) {
        self.buttonColor = backgroundColor
        self.shadowColor = shadowColor
        if shadowLayer != nil {
            shadowLayer.fillColor = backgroundColor.cgColor
            shadowLayer.shadowColor = shadowColor.cgColor
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        activityIndicator.pin.center().sizeToFit()
        if shadowLayer == nil {
            pressedLayer = CAShapeLayer()
            pressedLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 4).cgPath
            pressedLayer.fillColor = UIColor.black.withAlphaComponent(0.1).cgColor
            layer.insertSublayer(pressedLayer, at: 0)
            pressedLayer.isHidden = true

            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 4).cgPath
            shadowLayer.fillColor = buttonColor.cgColor

            shadowLayer.shadowColor = shadowColor.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0, height: 7.0)
            shadowLayer.shadowOpacity = 0.4
            shadowLayer.shadowRadius = 7

            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}

public extension PrimaryButton {
    static func getFactory(font: UIFont, titleColor: UIColor, title: String?, buttonColor : UIColor, shadowColor : UIColor, successColor : UIColor, successShadowColor : UIColor, successImage : UIImage, cornerRadius: CGFloat = 4.0) -> Factory<PrimaryButton> {
        let factory = { () -> PrimaryButton in
            let button = PrimaryButton()
            button.setTitle(title, for: .normal)
            button.setTitleColor(titleColor, for: .normal)
            button.titleLabel?.font = font
            button.buttonColor = buttonColor
            button.shadowColor = shadowColor
            button.successColor = successColor
            button.successShadowColor = successShadowColor
            button.successImage = successImage
            button.cornerRadius = cornerRadius
            return button
        }
        return factory
    }
}
