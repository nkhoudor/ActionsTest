//
//  BotTextMessagePresenter.swift
//
//  Created by Nik, 16/01/2020
//

import Foundation
import RxSwift

public class BotTextMessagePresenter : BotTextMessagePresenterProtocol {
    public var configurator: BotTextMessageConfiguratorProtocol
    var interactor : BotTextMessageInteractorProtocol!
    var router : BotTextMessageRouterProtocol!
    weak var view : BotTextMessageViewProtocol?
    
    let disposeBag = DisposeBag()
    
    public init(interactor: BotTextMessageInteractorProtocol, router : BotTextMessageRouterProtocol, configurator : BotTextMessageConfiguratorProtocol) {
        self.interactor = interactor
        self.router = router
        self.configurator = configurator
    }
    
    public func viewDidLoad(view: BotTextMessageViewProtocol) {
        self.view = view
        interactor.botTextMessage.text.subscribe(onNext: {[weak self] text in
            self?.view?.update(text: text)
        }).disposed(by: disposeBag)
        interactor.botTextMessage.avatarVisible.subscribe(onNext: {[weak self] avatarVisible in
            self?.view?.update(avatarVisible: avatarVisible)
        }).disposed(by: disposeBag)
        interactor.botTextMessage.images.subscribe(onNext: {[weak self] images in
            self?.view?.update(images: images)
        }).disposed(by: disposeBag)
        interactor.botTextMessage.warningVisible.subscribe(onNext: {[weak self] warningVisible in
            self?.view?.update(warningVisible: warningVisible)
        }).disposed(by: disposeBag)
    }
    
    public func showImagesPressed() {
        guard let images = view?.getImages(), images.count > 0 else { return }
        router.showImages(images)
    }
}
