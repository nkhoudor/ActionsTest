//
//  SideBarActionsSetView.swift
//  Vivex
//
//  Created by Nik, 8/01/2020
//

import Foundation
import PinLayout

public class SideBarActionsSetView : UIView {
    var configurator: SideBarActionsSetConfiguratorProtocol!
    
    lazy var pixel : CGFloat = UIScreen.main.bounds.height / 811.0
    lazy var viewHeight : CGFloat = pixel * 84.0
    
    var contentView : UIView!
    var actionIconViews : [UIView]!
    let actionWidth : CGFloat = 28.0 * UIScreen.main.bounds.width / 375.0
    let actionSpacing : CGFloat = 8.0 * UIScreen.main.bounds.width / 375.0
    
    private func createView() {
        backgroundColor = configurator.backgroundColor
        contentView = UIView.clearView()
        addSubview(contentView)
        actionIconViews = []
        for actionIconFactory in configurator.actionIconFactories {
            let actionView = UIImageView()
            actionIconFactory(actionView)
            actionIconViews.append(actionView)
            contentView.addSubview(actionView)
        }
    }
    
    init(configurator: SideBarActionsSetConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        createView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        for (i, actionView) in actionIconViews.enumerated() {
            if i == 0 {
                actionView.pin.topLeft().width(actionWidth).aspectRatio(1.0)
            } else {
                actionView.pin.right(of: actionIconViews[i-1], aligned: .top).marginLeft(actionSpacing).width(actionWidth).aspectRatio(1.0)
            }
        }
        contentView.pin.bottom(pixel * 12.0).wrapContent().hCenter()
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: viewHeight)
    }
}
