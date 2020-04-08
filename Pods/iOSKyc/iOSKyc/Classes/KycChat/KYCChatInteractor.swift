//
//  KYCChatInteractor.swift
//  iOSKyc
//
//  Created by Nik on 17/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Foundation
import iOSBaseViews
import iOSKycSDK
import RxSwift
import RxRelay
import Swinject
import iOSKycViews

class KYCChatInteractor : ChatInteractorProtocol {
    let chatFlowService : ChatFlowService
    let flowService : IFlowService
    let stateNavigator : StateNavigatorProtocol
    let stateService : ScreenStateService
    let storage : IKycStorage
    
    var vcs : [UIViewController] = []
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    lazy var screenProfile : ScreenProfile = {
        return resolver.resolve(ScreenProfile.self, name: "CHAT")!
    }()
    
    lazy var userTextMessageProfile : UserTextMessageProfile = {
        return resolver.resolve(UserTextMessageProfile.self, name: "defaultUserTextMessage")!
    }()
    
    lazy var userPhotoMessageProfile : UserPhotoMessageProfile = {
        return resolver.resolve(UserPhotoMessageProfile.self, name: "defaultUserPhotoMessage")!
    }()
    
    lazy var botLoadingMessageProfile : BotLoadingMessageProfile = {
        return resolver.resolve(BotLoadingMessageProfile.self, name: "defaultBotLoadingMessage")!
    }()
    
    var vcsRelay : BehaviorRelay<[UIViewController]> = BehaviorRelay(value: [])
    
    let disposeBag = DisposeBag()
    
    public init(chatFlowService : ChatFlowService, flowService : IFlowService, stateNavigator : StateNavigatorProtocol, stateService : ScreenStateService, storage: IKycStorage) {
        self.chatFlowService = chatFlowService
        self.flowService = flowService
        self.stateNavigator = stateNavigator
        self.stateService = stateService
        self.storage = storage
        
        chatFlowService.messagesChange.subscribe(onNext: {[weak self] changes in
            self?.handleChanges(changes)
        }).disposed(by: disposeBag)
    }
    
    deinit {
        print("KILLED INTERACTOR")
    }
    
    func startChat() {
        chatFlowService.state.accept(.HELLO)
    }
    
    private func handleChanges(_ changes: [MessagesChange]) {
        for change in changes {
            switch change {
            case .delete(let count):
                vcs.removeFirst(count)
            case .add(let messageEntity):
                vcs.insert(createVC(entity: messageEntity), at: 0)
            }
        }
        vcsRelay.accept(vcs)
    }
    
    func createVC(entity: MessageEntity) -> UIViewController {
        switch entity {
        case is BotTextMessageEntity:
            
            let botTextMessage = entity as! BotTextMessageEntity
            let profile : BotTextMessageProfile = botTextMessage.isError.value ? resolver.resolve(BotTextMessageProfile.self, name: "errorBotTextMessage")! : resolver.resolve(BotTextMessageProfile.self, name: "defaultBotTextMessage")!
            let configurator : BotTextMessageConfiguratorProtocol = BotTextMessageConfigurator(profile: profile)
            
            return BotTextMessageVC.createInstance(presenter: BotTextMessagePresenter(interactor: BotTextMessageInteractor(botTextMessage: entity as! BotTextMessageEntity), router: BotShowImagesRouter(), configurator: configurator))
            
        case is BotLoadingMessageEntity:
            var interactor : BotLoadingMessageInteractor!
            switch (entity as? BotLoadingMessage)!.type {
            case .document:
                interactor = BotUploadDocumentInteractor(viewModel : resolver.resolve(DocumentViewModel.self)!, storage: storage, chatFlowService : chatFlowService, flowService: flowService, botLoadingMessage: entity as! BotLoadingMessageEntity)
                
            case .address:
                interactor = BotUploadAddressInteractor(viewModel : resolver.resolve(AddressViewModel.self, name: ChatAssembly.homeAddress)!, chatFlowService : chatFlowService, flowService: flowService, botLoadingMessage: entity as! BotLoadingMessageEntity)
                
            case .email_recovery:
                interactor = BotUploadRecoveryEmailInteractor(chatFlowService: chatFlowService, flowService: flowService, botLoadingMessage: entity as! BotLoadingMessageEntity)
                
            case .dueDiligence:
                interactor = DueDiligenceUploadInteractor(viewModel: resolver.resolve(DueDiligenceViewModel.self)!, chatFlowService: chatFlowService, flowService: flowService, botLoadingMessage: entity as! BotLoadingMessageEntity)
            }
            return BotLoadingMessageVC.createInstance(presenter: BotLoadingMessagePresenter(interactor: interactor, router: BotLoadingMessageRouter(), configurator: BotLoadingMessageConfigurator(profile: botLoadingMessageProfile)))

        case is UserTextMessageEntity:
            return UserTextMessageVC.createInstance(presenter: UserTextMessagePresenter(interactor: UserTextMessageInteractor(userTextMessage: entity as! UserTextMessageEntity), router: UserTextMessageRouter(), configurator: UserTextMessageConfigurator(profile: userTextMessageProfile)))

        case is UserPhotoMessageEntity:
            return UserPhotoVC.createInstance(presenter: UserPhotoPresenter(interactor: UserPhotoInteractor(userPhotoMessage: entity as! UserPhotoMessageEntity), router: KYCUserPhotoRouter(), configurator: UserPhotoConfigurator(profile: userPhotoMessageProfile)))
            
        case is AddressInfoMessageEntity:
            return AddressInfoVC.createInstance(presenter: AddressInfoPresenter(interactor: AddressInfoInteractor(addressInfoMessage: entity as! AddressInfoMessageEntity), router: AddressInfoRouter(), configurator: AddressInfoConfigurator()))
            
        case is CongratulationsMessageEntity:
            var interactor : CongratulationsInteractorProtocol!
            var configurator : CongratulationsConfiguratorProtocol!
            switch entity {
            case is CongratulationsMessage:
                interactor = KYCCongratulationsInteractor(stateService: stateService)
                configurator = CongratulationsConfigurator(screenProfile: screenProfile)
            case is ThankyouMessage:
                interactor = CongratulationsInteractor()
                configurator = ThankyouConfigurator(screenProfile: screenProfile)
            default:
                ()
            }
            
            
            return CongratulationsVC.createInstance(presenter: CongratulationsPresenter(interactor: interactor, router: CongratulationsRouter(), configurator: configurator))
            
        case is ActionMessage:
            let actionMessage = entity as! ActionMessage
            switch actionMessage.actionType {
            case .letsBegin:
                return ChatActionVC.createInstance(presenter: ChatActionPresenter(interactor: ChatActionInteractor(), router: KYCLetsBeginRouter(chatFlowService: chatFlowService), configurator: KYCLetsBeginConfigurator(screenProfile: screenProfile)))
            case .chooseDocument:
                return ChatActionVC.createInstance(presenter: ChatActionPresenter(interactor: ChatActionInteractor(), router: KYCChooseDocumentRouter(chatFlowService: chatFlowService), configurator: KYCChooseDocumentConfigurator(screenProfile: screenProfile)))
            case .passport:
                return ChatActionVC.createInstance(presenter: ChatActionPresenter(interactor: ChatActionInteractor(), router: KYCPassportPhotoActionRouter(chatFlowService: chatFlowService, viewModel: resolver.resolve(DocumentViewModel.self)!), configurator: KYCPassportPhotoActionConfigurator(screenProfile: screenProfile)))
            case .driver_license_front:
                return ChatActionVC.createInstance(presenter: ChatActionPresenter(interactor: ChatActionInteractor(), router: DriverLicenseFrontActionRouter(chatFlowService: chatFlowService, viewModel: resolver.resolve(DocumentViewModel.self)!), configurator: DriverLicenseFrontActionConfigurator(screenProfile: screenProfile)))
            case .driver_license_back:
                return ChatActionVC.createInstance(presenter: ChatActionPresenter(interactor: ChatActionInteractor(), router: DriverLicenseBackActionRouter(chatFlowService: chatFlowService, viewModel: resolver.resolve(DocumentViewModel.self)!), configurator: DriverLicenseBackActionConfigurator(screenProfile: screenProfile)))
            case .id_front:
                return ChatActionVC.createInstance(presenter: ChatActionPresenter(interactor: ChatActionInteractor(), router: IDFrontActionRouter(chatFlowService: chatFlowService, viewModel: resolver.resolve(DocumentViewModel.self)!), configurator: IDFrontActionConfigurator(screenProfile: screenProfile)))
            case .id_back:
                return ChatActionVC.createInstance(presenter: ChatActionPresenter(interactor: ChatActionInteractor(), router: IDBackActionRouter(chatFlowService: chatFlowService, viewModel: resolver.resolve(DocumentViewModel.self)!), configurator: IDBackActionConfigurator(screenProfile: screenProfile)))
            case .selfie:
                return ChatActionVC.createInstance(presenter: ChatActionPresenter(interactor: ChatActionInteractor(), router: KYCSelfiePhotoActionRouter(chatFlowService: chatFlowService, viewModel: resolver.resolve(DocumentViewModel.self)!), configurator: KYCSelfieActionConfigurator(screenProfile: screenProfile)))
            case .utility_bill:
                return ChatActionVC.createInstance(presenter: ChatActionPresenter(interactor: ChatActionInteractor(), router: KYCUtilityBillActionRouter(chatFlowService: chatFlowService, viewModel: resolver.resolve(AddressViewModel.self, name: ChatAssembly.homeAddress)!), configurator: KYCUtilityBillActionConfigurator(screenProfile: screenProfile)))
            case .utility_bill_more:
                return ChatActionVC.createInstance(presenter: ChatActionPresenter(interactor: ChatActionInteractor(), router: KYCUtilityBillMoreActionRouter(chatFlowService: chatFlowService, viewModel: resolver.resolve(AddressViewModel.self, name: ChatAssembly.homeAddress)!), configurator: KYCUtilityBillMoreActionConfigurator(screenProfile: screenProfile)))
            case .utility_bill_address:
                return ChatActionVC.createInstance(presenter: ChatActionPresenter(interactor: ChatActionInteractor(), router: UtilityBillAddressActionRouter(chatFlowService: chatFlowService), configurator: UtilityBillAddressActionConfigurator(screenProfile: screenProfile)))
            case .plastic_delivery:
                return ChatActionVC.createInstance(presenter: ChatActionPresenter(interactor: ChatActionInteractor(), router: PlasticDeliveryActionRouter(chatFlowService: chatFlowService, viewModel: resolver.resolve(AddressViewModel.self, name: ChatAssembly.homeAddress)!), configurator: PlasticDeliveryActionConfigurator(screenProfile: screenProfile)))
            case .due_diligence:
                return ChatActionVC.createInstance(presenter: ChatActionPresenter(interactor: ChatActionInteractor(), router: DueDiligenceActionRouter(chatFlowService: chatFlowService, viewModel: resolver.resolve(DueDiligenceViewModel.self)!), configurator: DueDiligenceActionConfigurator(screenProfile: screenProfile)))
            case .connect_email:
                return ChatActionVC.createInstance(presenter: ChatActionPresenter(interactor: ChatActionInteractor(), router: ConnectEmailActionRouter(chatFlowService: chatFlowService, storage: storage), configurator: ConnectEmailActionConfigurator(screenProfile: screenProfile)))
            case .news_agree:
                return ChatActionVC.createInstance(presenter: ChatActionPresenter(interactor: ChatActionInteractor(), router: NewsAgreeActionRouter(viewModel: resolver.resolve(ConnectEmailViewModel.self)!, chatFlowService: chatFlowService), configurator: NewsAgreeActionConfigurator(screenProfile: screenProfile)))
            case .wrong_country_connect_email:
                return ChatActionVC.createInstance(presenter: ChatActionPresenter(interactor: ChatActionInteractor(), router: WrongCountryConnectEmailActionRouter(chatFlowService: chatFlowService), configurator: WrongCountryConnectEmailActionConfigurator(screenProfile: screenProfile)))
            case .site:
                return ChatActionVC.createInstance(presenter: ChatActionPresenter(interactor: ChatActionInteractor(), router: SiteActionRouter(screenProfile: screenProfile), configurator: SiteActionConfigurator(screenProfile: screenProfile)))
            case .cameraSettings:
                return ChatActionVC.createInstance(presenter: ChatActionPresenter(interactor: ChatActionInteractor(), router: CameraSettingsActionRouter(chatFlowService: chatFlowService), configurator: CameraSettingsActionConfigurator(screenProfile: screenProfile)))
            case .come_back_later_got_it:
                return ChatActionVC.createInstance(presenter: ChatActionPresenter(interactor: ChatActionInteractor(), router: ComeBackLaterGotItActionRouter(), configurator: ComeBackLaterGotItActionConfigurator(screenProfile: screenProfile)))
            }
        default:
            return UIViewController()
        }
    }
}
