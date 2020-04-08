//
//  MainHolderView.swift
//  Vivex
//
//  Created by Nik, 9/01/2020
//

import Foundation
import PinLayout
import RxKeyboard
import RxSwift

public class MainHolderView : UIView {
    lazy var pixel : CGFloat = UIScreen.main.bounds.height / 811.0
    
    var configurator: MainHolderConfiguratorProtocol!
    
    var mainView: UIView!
    var backImageView : UIImageView?
    var backButton : UIButton?
    
    var closeImageView : UIImageView?
    var closeButton : UIButton?
    
    lazy var topArrowImageView = UIImageView()
    var nameLabel : UILabel?
    
    lazy var expandButton = UIButton()
    
    var headerView : UIView?
    var headerLabel : UILabel?
    var headerUnderline : UIView?
    
    let disposeBag = DisposeBag()
    
    private func createView() {
        backgroundColor = configurator.backgroundColor
        addSubview(mainView)
        addSubview(topArrowImageView)
        configurator.topArrowImageFactory(topArrowImageView)
        
        nameLabel = configurator.nameLabelFactory?()
        if nameLabel != nil {
          addSubview(nameLabel!)
        }
        
        if configurator.backImageFactory != nil {
            backImageView = UIImageView()
            configurator.backImageFactory!(backImageView!)
            mainView.addSubview(backImageView!)
            backButton = UIButton()
            backButton!.setTitle(nil, for: .normal)
            mainView.addSubview(backButton!)
        }
        
        if configurator.closeImageFactory != nil {
            closeImageView = UIImageView()
            configurator.closeImageFactory!(closeImageView!)
            addSubview(closeImageView!)
            closeButton = UIButton()
            closeButton!.setTitle(nil, for: .normal)
            addSubview(closeButton!)
        }
        
        addSubview(expandButton)
        expandButton.alpha = 0.0
        
        if configurator.headerLabelFactory != nil {
            headerView = UIView()
            headerView!.backgroundColor = configurator.headerLabelFactory!.backgroundColor
            headerLabel = configurator.headerLabelFactory!.labelFactory()
            headerUnderline = UIView()
            headerUnderline!.backgroundColor = configurator.headerLabelFactory!.underlineColor
            headerView!.addSubview(headerLabel!)
            headerView!.addSubview(headerUnderline!)
            addSubview(headerView!)
        }
    }
    
    init(configurator: MainHolderConfiguratorProtocol, mainView: UIView) {
        super.init(frame: .zero)
        self.configurator = configurator
        self.mainView = mainView
        createView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if headerView != nil {
            headerView!.pin.top().left().right().height(pixel * 56)
            headerLabel!.pin.center().sizeToFit()
            headerUnderline!.pin.bottom().left().right().height(1)
        }
        
        roundCorners(corners: [.topLeft, .topRight], radius: configurator.contentViewRadius)
        
        mainView.pin
            .all()
            .marginTop(headerView != nil ? headerView!.frame.height : 0.0)
        
        topArrowImageView.pin
            .top(18 * pixel)
            .hCenter()
            .sizeToFit()
        
        nameLabel?.pin
            .top(36 * pixel)
            .hCenter()
            .sizeToFit()
        
        
        if backImageView != nil {
            backImageView?.pin
                .left(20 * pixel)
                .top(29 * pixel)
                .sizeToFit()
            
            backButton?.pin.center(to: backImageView!.anchor.center).width(70).height(70)
        }
        
        if closeImageView != nil {
            closeImageView?.pin
                .right(20 * pixel)
                .top(29 * pixel)
                .sizeToFit()
            
            closeButton?.pin.center(to: closeImageView!.anchor.center).width(70).height(70)
        }
        
        expandButton.pin
            .top()
            .horizontally()
            .height(102 * pixel)
    }
}


/*public class MainHolderView : UIScrollView {
    lazy var pixel : CGFloat = UIScreen.main.bounds.height / 811.0
    
    var configurator: MainHolderConfiguratorProtocol!
    
    var mainView: UIView!
    var backImageView : UIImageView?
    var backButton : UIButton?
    
    var closeImageView : UIImageView?
    var closeButton : UIButton?
    
    lazy var topArrowImageView = UIImageView()
    var nameLabel : UILabel?
    
    lazy var expandButton = UIButton()
    
    let disposeBag = DisposeBag()
    
    private func createView() {
        backgroundColor = configurator.backgroundColor
        addSubview(mainView)
        addSubview(topArrowImageView)
        configurator.topArrowImageFactory(topArrowImageView)
        
        nameLabel = configurator.nameLabelFactory?()
        if nameLabel != nil {
          addSubview(nameLabel!)
        }
        
        if configurator.backImageFactory != nil {
            backImageView = UIImageView()
            configurator.backImageFactory!(backImageView!)
            addSubview(backImageView!)
            backButton = UIButton()
            backButton!.setTitle(nil, for: .normal)
            addSubview(backButton!)
        }
        
        if configurator.closeImageFactory != nil {
            closeImageView = UIImageView()
            configurator.closeImageFactory!(closeImageView!)
            addSubview(closeImageView!)
            closeButton = UIButton()
            closeButton!.setTitle(nil, for: .normal)
            addSubview(closeButton!)
        }
        
        addSubview(expandButton)
        expandButton.alpha = 0.0
    }
    
    init(configurator: MainHolderConfiguratorProtocol, mainView: UIView) {
        super.init(frame: .zero)
        self.configurator = configurator
        self.mainView = mainView
        createView()
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
        roundCorners(corners: [.topLeft, .topRight], radius: configurator.contentViewRadius)
        pin.left().right().top().bottom(keyboardHeight)
        mainView.pin.all()
        //var size = bounds.size
        //size.height -= keyboardHeight
        contentSize = mainView.sizeThatFits(bounds.size)
        topArrowImageView.pin
            .top(18 * pixel)
            .hCenter()
            .sizeToFit()
        
        nameLabel?.pin
            .top(36 * pixel)
            .hCenter()
            .sizeToFit()
        
        
        if backImageView != nil {
            backImageView?.pin
                .left(20 * pixel)
                .top(29 * pixel)
                .sizeToFit()
            
            backButton?.pin.center(to: backImageView!.anchor.center).width(70).height(70)
        }
        
        if closeImageView != nil {
            closeImageView?.pin
                .right(20 * pixel)
                .top(29 * pixel)
                .sizeToFit()
            
            closeButton?.pin.center(to: closeImageView!.anchor.center).width(70).height(70)
        }
        
        expandButton.pin
            .top()
            .horizontally()
            .height(102 * pixel)
    }
}
*/
