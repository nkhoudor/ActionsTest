//
//  OverlayVC.swift
//  Vivex
//
//  Created by Nik, 9/01/2020
//

import Foundation
import UIKit
import OverlayContainer

enum OverlayNotch: Int, CaseIterable {
    case minimum, maximum
}

public class OverlayVC : UIViewController, OverlayViewProtocol {
    public var presenter : OverlayPresenterProtocol!
    var containerController : OverlayContainerViewController!
    
    lazy var pixel : CGFloat = UIScreen.main.bounds.height / 811.0
    lazy var maximumNotchHeight : CGFloat = UIScreen.main.bounds.height - 84 * pixel
    lazy var minimumNotchHeight : CGFloat = 102 * pixel
    lazy var mainHolderTransitionCollapseHeight : CGFloat = 120.0
    lazy var mainHolderTransitionExpandHeight : CGFloat = 20.0
    lazy var transitionVelocity : CGFloat = 400.0
    
    weak var foregroundScrollView : UIScrollView?
    weak var foregroundVC : UIViewController?
    
    private var mainView: OverlayView {
        return view as! OverlayView
    }
    
    deinit {
        print("KILLED")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func handleKeyboardDidShow() {
        firstResponder = view.firstResponder
    }
    
    var disableKeyboardHideEvent : Bool = false
    
    @objc func handleKeyboardDidHide() {
        if currentNotch == .maximum, !disableKeyboardHideEvent {
            firstResponder = nil
        }
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    public override func loadView() {
        containerController = OverlayContainerViewController(style: .rigid)
        
        let mainHolderRouter = MainHolderRouter()
        mainHolderRouter.back = presenter.backPressed
        mainHolderRouter.close = presenter.closePressed
        
        let mainHolderVC = MainHolderVC.createInstance(presenter: MainHolderPresenter(interactor: MainHolderInteractor(), router: mainHolderRouter, configurator: presenter.configurator.mainFactory()))
        
        mainHolderVC.mainHolderDelegate = self
        
        containerController.delegate = self
        containerController.viewControllers = [
            presenter.configurator.sideBarFactory(),
            mainHolderVC
        ]
        foregroundVC = mainHolderVC
        addChild(containerController)
        view = OverlayView(configurator: presenter.configurator, containerView: containerController.view)
        containerController.didMove(toParent: self)
        containerController.moveOverlay(toNotchAt: OverlayNotch.maximum.rawValue, animated: false)
        foregroundScrollView = mainHolderVC.view.findSubview(condition: { $0 is UIScrollView }) as? UIScrollView
    }
    
    public class func createInstance(presenter : OverlayPresenterProtocol) -> OverlayVC {
        let instance = OverlayVC()
        instance.presenter = presenter
        return instance
    }
    
    private var previousCollapseTransitionHeight : CGFloat = 0.0
    private var previousExpandTransitionHeight : CGFloat = 0.0
    private var currentNotch : OverlayNotch = .maximum
    private weak var firstResponder : UIView?
}

extension OverlayVC : OverlayTranslationTargetNotchPolicy {
    public func targetNotchIndex(using context: OverlayContainerContextTargetNotchPolicy) -> Int {
        print(context.velocity)
        if currentNotch == .maximum {
            return maximumNotchHeight - context.overlayTranslationHeight > mainHolderTransitionCollapseHeight || context.velocity.y > transitionVelocity ? OverlayNotch.minimum.rawValue : OverlayNotch.maximum.rawValue
        } else {
            return context.overlayTranslationHeight - minimumNotchHeight > mainHolderTransitionExpandHeight || context.velocity.y < -transitionVelocity ? OverlayNotch.maximum.rawValue : OverlayNotch.minimum.rawValue
        }
    }
}

extension OverlayVC : OverlayContainerViewControllerDelegate, OverlayTransitioningDelegate {
    public func animationController(for overlayViewController: UIViewController) -> OverlayAnimatedTransitioning? {
        return nil
    }
    
    public func overlayContainerViewController(_ containerViewController: OverlayContainerViewController, heightForNotchAt index: Int, availableSpace: CGFloat) -> CGFloat {
        switch OverlayNotch.allCases[index] {
            case .maximum:
                return maximumNotchHeight
            case .minimum:
                return minimumNotchHeight
        }
    }
    
    public func overlayContainerViewController(_ containerViewController: OverlayContainerViewController, transitioningDelegateForOverlay overlayViewController: UIViewController) -> OverlayTransitioningDelegate? {
        //return self
        return nil
    }
    
    public func overlayTargetNotchPolicy(for overlayViewController: UIViewController) -> OverlayTranslationTargetNotchPolicy? {
        //return self
        return nil
    }
    
    public func numberOfNotches(in containerViewController: OverlayContainerViewController) -> Int {
        return OverlayNotch.allCases.count
    }
    
    public func overlayContainerViewController(_ containerViewController: OverlayContainerViewController, willStartDraggingOverlay overlayViewController: UIViewController) {
        disableKeyboardHideEvent = true
    }
    
    public func overlayContainerViewController(_ containerViewController: OverlayContainerViewController, scrollViewDrivingOverlay overlayViewController: UIViewController) -> UIScrollView? {
        foregroundVC?.view.endEditing(true)
        return foregroundScrollView
    }
    
    public func overlayContainerViewController(_ containerViewController: OverlayContainerViewController, shouldStartDraggingOverlay overlayViewController: UIViewController, at point: CGPoint, in coordinateSpace: UICoordinateSpace) -> Bool {
        foregroundVC?.view.endEditing(true)
        return true
    }
    
    public func overlayContainerViewController(_ containerViewController: OverlayContainerViewController,
    didMoveOverlay overlayViewController: UIViewController, toNotchAt index: Int) {
        currentNotch = OverlayNotch(rawValue: index)!
        previousCollapseTransitionHeight = 0.0
        previousExpandTransitionHeight = 0.0
        if currentNotch == .minimum {
            firstResponder?.resignFirstResponder()
        } else {
            disableKeyboardHideEvent = false
            firstResponder?.becomeFirstResponder()
        }
    }
    
    private func impactFeedback() {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .medium)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
    
    public func overlayContainerViewController(_ containerViewController: OverlayContainerViewController,
    willTranslateOverlay overlayViewController: UIViewController, transitionCoordinator: OverlayContainerTransitionCoordinator) {
        
        //COLLAPSE IMPACT
        let collapseTransitionHeight = maximumNotchHeight - transitionCoordinator.targetTranslationHeight
        
        if collapseTransitionHeight > mainHolderTransitionCollapseHeight, previousCollapseTransitionHeight < mainHolderTransitionCollapseHeight {
            firstResponder?.resignFirstResponder()
        } else if collapseTransitionHeight < mainHolderTransitionCollapseHeight, previousCollapseTransitionHeight > mainHolderTransitionCollapseHeight {
            firstResponder?.becomeFirstResponder()
        }
        
        if currentNotch == .maximum {
            if collapseTransitionHeight > mainHolderTransitionCollapseHeight, previousCollapseTransitionHeight < mainHolderTransitionCollapseHeight {
                impactFeedback()
            } else if collapseTransitionHeight < mainHolderTransitionCollapseHeight, previousCollapseTransitionHeight > mainHolderTransitionCollapseHeight {
                impactFeedback()
            }
        }
        previousCollapseTransitionHeight = collapseTransitionHeight
        
        //EXPAND IMPACT
        let expandTransitionHeight = transitionCoordinator.targetTranslationHeight - minimumNotchHeight
        if currentNotch == .minimum, ((expandTransitionHeight > mainHolderTransitionExpandHeight && previousExpandTransitionHeight < mainHolderTransitionExpandHeight) || (expandTransitionHeight < mainHolderTransitionExpandHeight && previousExpandTransitionHeight > mainHolderTransitionExpandHeight)) {
            impactFeedback()
            
        }
        previousExpandTransitionHeight = expandTransitionHeight
        
        containerViewController.viewControllers.forEach({ ($0 as? OverlayTransitionDelegate)?.transition(transitionCoordinator: transitionCoordinator) })
    }
}

extension OverlayVC : MainHolderDelegate {
    func expandMainHolder() {
        containerController.moveOverlay(toNotchAt: OverlayNotch.maximum.rawValue, animated: true)
    }
}

extension UIView {
    var firstResponder: UIView? {
        if isFirstResponder {
            return self
        }
        for v in subviews {
            let responder = v.firstResponder
            if responder != nil {
                return responder
            }
        }
        return nil
    }
    
    func findSubview(condition : (UIView) -> Bool) -> UIView? {
        if condition(self) {
            return self
        }
        for v in subviews {
            let satisfied = v.findSubview(condition: condition)
            if satisfied != nil {
                return satisfied
            }
        }
        return nil
    }
}
