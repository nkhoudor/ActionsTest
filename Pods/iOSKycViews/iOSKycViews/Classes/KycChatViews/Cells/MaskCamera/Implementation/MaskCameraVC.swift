//
//  MaskCameraVC.swift
//  Vivex
//
//  Created by Nik, 17/01/2020
//

import UIKit
import AVFoundation

public enum MaskCameraState {
    case capture
    case take
}

public class MaskCameraVC : UIViewController, MaskCameraViewProtocol {
    var presenter : MaskCameraPresenterProtocol!
    
    var captureSession = AVCaptureSession()
    var backCamera : AVCaptureDevice?
    var frontCamera : AVCaptureDevice?
    var currentCamera : AVCaptureDevice?
    
    var photoOutput : AVCapturePhotoOutput?
    
    
    private var mainView: MaskCameraView {
        return view as! MaskCameraView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    func updateState(_ state: MaskCameraState) {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            switch state {
            case .capture:
                self?.captureSession.startRunning()
                self?.mainView.takeButton.alpha = 0.0
                self?.mainView.retakeButton.alpha = 0.0
                self?.mainView.takenPhotoImageView.alpha = 0.0
            case .take:
                self?.captureSession.stopRunning()
                self?.mainView.photoImageView.alpha = 0.0
                self?.mainView.photoButton.alpha = 0.0
            }
        }) { _ in
            UIView.animate(withDuration: 0.2) {[weak self] in
                switch state {
                case .capture:
                    self?.mainView.photoImageView.alpha = 1.0
                    self?.mainView.photoButton.alpha = 1.0
                case .take:
                    self?.mainView.takeButton.alpha = 1.0
                    self?.mainView.retakeButton.alpha = 1.0
                    self?.mainView.takenPhotoImageView.alpha = 1.0
                }
            }
        }
    }
    
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .unspecified)
        let devices = deviceDiscoverySession.devices
        for device in devices {
            if device.position == .back {
                backCamera = device
            }
            if device.position == .front {
                frontCamera = device
            }
        }
        
        if presenter.configurator.cameraType == .back {
            currentCamera = backCamera
        } else {
            currentCamera = frontCamera
        }
    }
    
    func setupInputOutput() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        } catch {
            print(error)
        }
    }
    
    public override func loadView() {
        view = MaskCameraView(configurator: presenter.configurator)
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        mainView.setupPreviewLayer(captureSession: captureSession)
        captureSession.startRunning()
        mainView.photoButton.addTarget(self, action: #selector(photoPressed), for: .touchUpInside)
        mainView.takeButton.addTarget(self, action: #selector(takePressed), for: .touchUpInside)
        mainView.retakeButton.addTarget(self, action: #selector(retakePressed), for: .touchUpInside)
    }
    
    @objc func photoPressed() {
        photoOutput?.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
    @objc func takePressed() {
        guard let image = mainView.takenPhotoImageView.image else { return }
        let rect = mainView.getMaskRect()
        let scale = image.size.height / mainView.takenPhotoImageView.frame.height
        var scaledRect = rect
        scaledRect.size.width *= scale
        scaledRect.size.height = scaledRect.size.width
        scaledRect.origin.x = (image.size.width - scaledRect.size.width) / 2
        scaledRect.origin.y *= scale
        presenter.imageTaken(image.cropping(to: scaledRect))
    }
    
    @objc func retakePressed() {
        updateState(.capture)
    }
    
    public class func createInstance(presenter : MaskCameraPresenterProtocol) -> MaskCameraVC {
        let instance = MaskCameraVC()
        instance.presenter = presenter
        return instance
    }
}

extension MaskCameraVC : AVCapturePhotoCaptureDelegate {
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation(), var image = UIImage(data: imageData) {
            if presenter.configurator.cameraType == .front {
                image = UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: .leftMirrored)
            }
            mainView.takenPhotoImageView.image = image
            updateState(.take)
        }        
    }
}

extension UIImage {
    func cropping(to rect: CGRect) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, self.scale)

        self.draw(in: CGRect(x: -rect.origin.x, y: -rect.origin.y, width: self.size.width, height: self.size.height))

        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return croppedImage
    }
}
