//
//  UserPhotoPresenter.swift
//
//  Created by Nik, 19/01/2020
//

import RxSwift
import RxRelay

public class UserPhotoPresenter : UserPhotoPresenterProtocol {
    public var configurator: UserPhotoConfiguratorProtocol
    var interactor : UserPhotoInteractorProtocol!
    var router : UserPhotoRouterProtocol!
    weak var view : UserPhotoViewProtocol?
    
    let disposeBag = DisposeBag()
    
    public init(interactor: UserPhotoInteractorProtocol, router : UserPhotoRouterProtocol, configurator : UserPhotoConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: UserPhotoViewProtocol) {
        self.view = view
        interactor.userPhotoMessage.photo.subscribe(onNext: {[weak self] data in
            self?.view?.update(photoData: data)
        }).disposed(by: disposeBag)
    }
    
    public func imagePressed() {
        guard let image = UIImage(data: interactor.userPhotoMessage.photo.value) else { return }
        router.showImage(image)
    }
}
