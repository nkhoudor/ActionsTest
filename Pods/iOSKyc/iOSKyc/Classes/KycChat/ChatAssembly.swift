//
//  ChatAssembly.swift
//  iOSKyc
//
//  Created by Nik on 15/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Foundation
import Swinject
import iOSBaseViews
import iOSKycViews
import iOSKycSDK

extension ObjectScope {
    static let chat = ObjectScope(storageFactory: PermanentStorage.init)
}

class ChatAssembly: Assembly {
    
    private func getFactory(resolver: Resolver) -> Factory<UIViewController> {
        let factory: Factory<UIViewController> = {
            let chatFlowService = resolver.resolve(ChatFlowService.self)!
            let stateNavigator = resolver.resolve(StateNavigatorProtocol.self)!
            let stateService = resolver.resolve(ScreenStateService.self)!
            let flowService = resolver.resolve(IFlowService.self)!
            let storage = resolver.resolve(IKycStorage.self)!
            let overlayVC = OverlayVC()
            
            let screenProfile = resolver.resolve(ScreenProfile.self, name: "CHAT")!
            let upArrowAssetProfile = resolver.resolve(AssetProfile.self, name: "up_arrow")!
            
            let mainVCFactory = { () -> UIViewController in
                ChatVC.createInstance(presenter: ChatPresenter(interactor: KYCChatInteractor(chatFlowService: chatFlowService, flowService: flowService, stateNavigator: stateNavigator, stateService: stateService, storage: storage), router: ChatRouter(), configurator: ChatConfigurator()))
            }
            
            overlayVC.presenter = OverlayPresenter(interactor: OverlayInteractor(), router: OverlayRouter(), configurator: ChatOverlayConfigurator(mainVCFactory: mainVCFactory, screenProfile: screenProfile, upArrowAssetProfile: upArrowAssetProfile, isRecovery: storage.isRecoveryMode))
            return overlayVC
            
        }
        return factory
    }
    
    func assemble(container: Container) {
        
        container.autoregister(DocumentViewModel.self, initializer: DocumentViewModel.init).inObjectScope(.chat)
        
        container.register(AddressViewModel.self, name: ChatAssembly.homeAddress, factory: { resolver in
            return AddressViewModel(form: resolver.addressForm)
        }).inObjectScope(.chat)
        
        container.register(AddressViewModel.self, name: ChatAssembly.deliveryAddress, factory: { resolver in
            return AddressViewModel(form: resolver.addressForm)
        }).inObjectScope(.chat)
        
        container.register(DueDiligenceViewModel.self, factory: { resolver in
            return DueDiligenceViewModel(form: resolver.dueDiligenceForm)
        }).inObjectScope(.chat)
        
        container.autoregister(ConnectEmailViewModel.self, initializer: ConnectEmailViewModel.init).inObjectScope(.chat)
        
        container.autoregister(ChatFlowService.self, initializer: ChatFlowService.init).inObjectScope(.container)
        container.register(Factory<UIViewController>.self, name: ChatAssembly.registrationName, factory: getFactory)
    }
    
    /// Factory registration name, which should be used to differentiate from other registrations
    /// that have the same service and factory types.
    static var registrationName = "ChatFactory"
    
    static var homeAddress = "homeAddress"
    static var deliveryAddress = "deliveryAddress"
}
