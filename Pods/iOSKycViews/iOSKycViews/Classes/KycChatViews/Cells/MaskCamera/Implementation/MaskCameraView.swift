//
//  MaskCameraView.swift
//  Vivex
//
//  Created by Nik, 17/01/2020
//

import Foundation
import PinLayout
import AVFoundation

public class MaskCameraView : UIView {
    lazy var pixel : CGFloat = UIScreen.main.bounds.height / 811.0
    lazy var margin : CGFloat = pixel * 16
    var configurator: MaskCameraConfiguratorProtocol!
    
    var cameraPreviewLayer : AVCaptureVideoPreviewLayer?
    var maskLayer : CAShapeLayer?
    var topLabel : UILabel?
    var secondaryLabel : UILabel?
    let photoImageView = UIImageView()
    let photoButton = UIButton()
    
    var takeButton : UIButton!
    var retakeButton : UIButton!
    
    var takenPhotoImageView = UIImageView()
    
    init(configurator: MaskCameraConfiguratorProtocol) {
        super.init(frame: .zero)
        self.configurator = configurator
        if configurator.topLabelFactory != nil {
            topLabel = configurator.topLabelFactory!()
            addSubview(topLabel!)
        }
        if configurator.secondaryLabelFactory != nil {
            secondaryLabel = configurator.secondaryLabelFactory!()
            addSubview(secondaryLabel!)
        }
        configurator.photoButtonImageFactory(photoImageView)
        
        takeButton = configurator.takeButtonFactory()
        retakeButton = configurator.retakeButtonFactory()
        takeButton.alpha = 0.0
        retakeButton.alpha = 0.0
        takenPhotoImageView.alpha = 0.0
        takenPhotoImageView.contentMode = .scaleAspectFill
        addSubview(photoImageView)
        addSubview(photoButton)
        addSubview(takeButton)
        addSubview(retakeButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupPreviewLayer(captureSession: AVCaptureSession) {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = .resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = .portrait
        layer.insertSublayer(cameraPreviewLayer!, at: 0)
        layer.insertSublayer(takenPhotoImageView.layer, at: 1)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        cameraPreviewLayer?.frame = bounds
        takenPhotoImageView.frame = bounds
        let maskOffset = drawMask()
        
        topLabel?.pin
            .top(maskOffset + margin)
            .hCenter()
            .sizeToFit()
        
        secondaryLabel?.pin
            .top(topLabel == nil ? maskOffset + margin : topLabel!.frame.maxY + 5)
            .hCenter()
            .sizeToFit()
        
        photoImageView.pin
            .bottom(pixel * 58)
            .hCenter()
            .sizeToFit()
        photoButton.pin
            .center(to: photoImageView.anchor.center)
            .size(photoImageView.frame.size)
        
        retakeButton.pin.bottom(pixel * 50).horizontally(16).height(48)
        takeButton.pin.above(of: retakeButton).marginBottom(8).horizontally(16).height(48)
    }
    
    public func getMaskRect() -> CGRect {
        switch configurator.maskType {
        case .rectangle:
            let maskWidth = bounds.size.width - margin * 2
            return CGRect(x: margin, y: pixel * 80, width: maskWidth, height: maskWidth)
        case .oval:
            return CGRect(x: margin * 2, y: pixel * 80, width: bounds.size.width - margin * 4, height: pixel * 420)
        case .utility_bill:
            let maskWidth = bounds.size.width - margin * 2
            return CGRect(x: margin, y: pixel * 80, width: maskWidth, height: pixel * 420)
        }
    }
    
    private func drawMask() -> CGFloat {
        if maskLayer != nil {
            maskLayer?.removeFromSuperlayer()
        }
        
        var maskOffset : CGFloat!
        
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height), cornerRadius: 0)
        var maskPath : UIBezierPath!
        
        switch configurator.maskType {
        case .rectangle:
            let maskWidth = bounds.size.width - margin * 2
            maskPath = UIBezierPath(roundedRect: CGRect(x: margin, y: pixel * 80, width: maskWidth, height: maskWidth), cornerRadius: 4)
            maskOffset = pixel * 80 + maskWidth
        case .oval:
            maskPath = UIBezierPath(ovalIn: CGRect(x: margin * 2, y: pixel * 80, width: bounds.size.width - margin * 4, height: pixel * 420))
            maskOffset = pixel * 500
        case .utility_bill:
            let maskWidth = bounds.size.width - margin * 2
            maskPath = UIBezierPath(roundedRect: CGRect(x: margin, y: pixel * 80, width: maskWidth, height: pixel * 450), cornerRadius: 4)
            maskOffset = pixel * 530
        }
        path.append(maskPath)
        path.usesEvenOddFillRule = true

        maskLayer = CAShapeLayer()
        maskLayer!.path = path.cgPath
        maskLayer!.fillRule = .evenOdd
        maskLayer!.fillColor = configurator.maskColor.cgColor
        layer.insertSublayer(maskLayer!, above: takenPhotoImageView.layer)
        return maskOffset
    }
}
