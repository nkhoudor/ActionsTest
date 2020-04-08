//
//  MaskCameraPresenter.swift
//
//  Created by Nik, 17/01/2020
//

import UIKit

public class MaskCameraPresenter : MaskCameraPresenterProtocol {
    public var configurator: MaskCameraConfiguratorProtocol
    var interactor : MaskCameraInteractorProtocol!
    var router : MaskCameraRouterProtocol!
    weak var view : MaskCameraViewProtocol?
    
    public init(interactor: MaskCameraInteractorProtocol, router : MaskCameraRouterProtocol, configurator : MaskCameraConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: MaskCameraViewProtocol) {
        self.view = view
    }
    
    public func imageTaken(_ image : UIImage) {
        router.imageTaken?(image.jpegData(compressionQuality: 0.8)!)
    }
}
