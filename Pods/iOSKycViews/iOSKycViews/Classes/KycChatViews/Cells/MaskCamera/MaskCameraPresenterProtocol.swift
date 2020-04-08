//
//  MaskCameraPresenterProtocol.swift
//
//  Created by Nik, 17/01/2020
//

import UIKit

public protocol MaskCameraPresenterProtocol {
    var configurator : MaskCameraConfiguratorProtocol { get }
    func viewDidLoad(view: MaskCameraViewProtocol)
    func imageTaken(_ image : UIImage)
}
