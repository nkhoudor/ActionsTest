//
//  MaskCameraConfiguratorProtocol.swift
//
//  Created by Nik, 17/01/2020
//

import iOSBaseViews

public protocol MaskCameraConfiguratorProtocol {
    var maskType : MaskCameraType { get }
    var cameraType : CameraType { get }
    var maskColor : UIColor { get }
    var topLabelFactory : Factory<UILabel>? { get }
    var secondaryLabelFactory : Factory<UILabel>? { get }
    var photoButtonImageFactory : ConfigurationFactory<UIImageView> { get }
    
    var takeButtonFactory : Factory<UIButton> { get }
    var retakeButtonFactory : Factory<UIButton> { get }
}
