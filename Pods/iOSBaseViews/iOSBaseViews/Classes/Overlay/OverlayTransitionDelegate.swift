//
//  OverlayTransitionDelegate.swift
//  iOSBaseViews
//
//  Created by Nik on 09/01/2020.
//

import Foundation
import OverlayContainer

public protocol OverlayTransitionDelegate {
    func transition(transitionCoordinator: OverlayContainerTransitionCoordinator)
}
