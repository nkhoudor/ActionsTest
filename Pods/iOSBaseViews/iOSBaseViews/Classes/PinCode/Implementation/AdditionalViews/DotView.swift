//
//  DotView.swift
//  iOSBaseViews
//
//  Created by Nik on 04/01/2020.
//

import Foundation
import RxSwift
import RxRelay

///Possible states for Dot
public enum DotState {
    ///State for normal dot
    case normal
    ///State for filled dot
    case filled
    ///State for success dot
    case success
    ///State for error dot
    case error
}

public class DotView : UIView {
    var normalColor : UIColor!
    var filledColor : UIColor!
    var successColor : UIColor!
    var errorColor : UIColor!
    
    ///Accept and observe primary button state
    public let dotState : BehaviorRelay<DotState> = BehaviorRelay.init(value: .normal)
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didMoveToSuperview() {
        dotState.subscribe(onNext: {[weak self] state in
            self?.updateState(state)
        }).disposed(by: disposeBag)
    }
    
    private func updateState(_ state: DotState) {
        switch state {
        case .normal:
            layer.backgroundColor = normalColor.cgColor
        case .filled:
            layer.backgroundColor = filledColor.cgColor
        case .success:
            layer.backgroundColor = successColor.cgColor
        case .error:
            layer.backgroundColor = errorColor.cgColor
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
    }
}

public extension DotView {
    static func getFactory(normalColor : UIColor, filledColor : UIColor, successColor : UIColor, errorColor: UIColor) -> Factory<DotView> {
        let factory = { () -> DotView in
            let v = DotView()
            v.normalColor = normalColor
            v.filledColor = filledColor
            v.successColor = successColor
            v.errorColor = errorColor
            return v
        }
        return factory
    }
}

///Possible states for Dot Array
public enum DotArrayState {
    ///State for normal dots
    case normal
    ///State for filled dots
    case filled(count: Int)
    ///State for success dots
    case success
    ///State for error dots
    case error
}

extension Array where Element == DotView {
    func updateState(_ state: DotArrayState) {
        switch state {
        case .normal:
            forEach({ $0.dotState.accept(.normal) })
        case .filled(let count):
            for (i, dot) in enumerated() {
                dot.dotState.accept(i < count ? .filled : .normal)
            }
        case .success:
            forEach({ $0.dotState.accept(.success) })
        case .error:
            forEach({ $0.dotState.accept(.error) })
        }
    }
}
