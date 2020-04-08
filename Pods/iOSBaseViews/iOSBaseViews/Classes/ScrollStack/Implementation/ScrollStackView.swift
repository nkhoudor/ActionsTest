//
//  ScrollStackView.swift
//  Vivex
//
//  Created by Nik, 6/01/2020
//

import Foundation
import PinLayout

public class ScrollStackView : UIScrollView {
    var configurator: ScrollStackConfiguratorProtocol!
    
    var views : [UIView]!
    
    init(configurator: ScrollStackConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        backgroundColor = configurator.backgroundColor
        
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never
        }
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(_ views: [UIView]) {
        self.views = views
        views.forEach({ addSubview($0) })
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        guard views.count > 0 else { return }
        for (i, view) in views.enumerated() {
            if i == 0 {
                print(configurator.margins.first!)
                view.pin.size(view.sizeThatFits(frame.size)).top(configurator.margins.first!).hCenter()
            } else {
                view.pin.size(view.sizeThatFits(frame.size)).below(of: views[i-1]).marginTop(configurator.margins[i]).hCenter()
            }
        }
        contentSize = CGSize(width: frame.width, height: views.last!.frame.maxY + configurator.margins.last!)
    }
}
