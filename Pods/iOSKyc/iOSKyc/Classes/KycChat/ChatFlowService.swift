//
//  ChatFlowService.swift
//  iOSKyc
//
//  Created by Nik on 17/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import iOSKycSDK
import iOSBaseViews
import Swinject
import iOSKycViews

enum ChatFlowState {
    case NO_STATE
    case HELLO
    case HELLO_RECOVER_DESCRIPTION
    case HELLO_DESCRIPTION
    case LETS_BEGIN
    case LETS_BEGIN_USER_MESSAGE
    case CHOOSE_TYPE_OF_DOCUMENT_DESCRIPTION
    case CHOOSE_TYPE_OF_DOCUMENT(deleteCount: Int)
    
    case CAMERA_SETTINGS_DESCRIPTION
    case CAMERA_SETTINGS
    
    case CHOOSE_PASSPORT_USER_MESSAGE
    case CHOOSE_DRIVER_LICENSE_USER_MESSAGE
    case CHOOSE_ID_CARD_USER_MESSAGE
    
    case PASSPORT_PHOTO_DESCRIPTION
    case PASSPORT_PHOTO_ACTION
    case PASSPORT_PHOTO_TAKEN(photoData: Data)
    
    case DRIVER_LICENSE_FRONT_PAGE_DESCRIPTION
    case DRIVER_LICENSE_FRONT_ACTION
    case DRIVER_LICENSE_FRONT_TAKEN(photoData: Data)
    case DRIVER_LICENSE_BACK_PAGE_DESCRIPTION
    case DRIVER_LICENSE_BACK_ACTION
    case DRIVER_LICENSE_BACK_TAKEN(photoData: Data)
    
    case ID_FRONT_PAGE_DESCRIPTION
    case ID_FRONT_ACTION
    case ID_FRONT_TAKEN(photoData: Data)
    case ID_BACK_PAGE_DESCRIPTION
    case ID_BACK_ACTION
    case ID_BACK_TAKEN(photoData: Data)
    
    case SELFIE_DESCRIPTION
    case SELFIE_ACTION
    case SELFIE_PHOTO_TAKEN(photoData: Data)
    case BOT_UPLOAD_DESCRIPTION
    case BOT_UPLOAD_LOADING
    case BOT_LAST_STEP
    case BOT_BILL_EXAMPLES
    case UTILITY_BILL_ACTION
    case UTILITY_BILL_BOT_MORE_DESCRIPTION
    case UTILITY_BILL_MORE_ACTION
    case UTILITY_BILL_USER_PHOTO(photoData: Data, showDescription: Bool, limitReached: Bool)
    case BOT_UTILITY_BILL_UPLOAD_LOADING
    case BOT_ADDRESS_UTILITY_BILL_DESCRIPTION
    case ADDRESS_UTILITY_BILL_ACTION
    case ADDRESS_INFO(_ address: TemplateFormConfigProtocol)
    case BOT_PLASTIC_DELIVERY_DESCRIPTION
    case PLASTIC_DELIVERY_ACTION
    case PLASTIC_DELIVERY_ADDRESS_INFO(_ address: TemplateFormConfig)
    case CONGRATULATIONS
    case BOT_CONNECT_EMAIL_DESCRIPTION
    case CONNECT_EMAIL_ACTION
    case USER_NO_EMAIL_DESCRIPTION
    case BOT_NO_EMAIL_DESCRIPTION
    case BOT_NEWS_DESCRIPTION
    case NEWS_AGREE_ACTION
    case NEWS_AGREE_RESULT(_ agree: Bool)
    case ENTER_EMAIL
    case BOT_NEWS_DISAGREE_DESCRIPTION
    case EMAIL_VERIFIED(_ email: String, _ code: String)
    
    //EMAIL_RECOVERY
    case BOT_UPLOAD_RECOVERY_EMAIL
    case BOT_ENTER_RECOVERY_EMAIL_CODE_DESCRIPTION
    
    case SOMETHING_WENT_WRONG
    
    //WRONG_COUNTRY
    case BOT_WRONG_COUNTRY_DESCRIPTION
    case BOT_WRONG_COUNTRY_EMAIL_DESCRIPTION
    case WRONG_COUNTRY_CONNECT_EMAIL_ACTION
    case USER_WRONG_COUNTRY_EMAIL_PROVIDED(_ email: String)
    case WRONG_COUNTRY_THANK_YOU
    case USER_WRONG_COUNTRY_NO_EMAIL
    case BOT_WRONG_COUNTRY_NO_EMAIL_DESCRIPTION
    case SITE_ACTION
    
    //WRONG_AGE
    case BOT_WRONG_AGE_DESCRIPTION
    
    //DUE_DILIGENCE
    case DUE_DILIGENCE_BOT_DESCRIPTION
    case DUE_DILIGENCE_ACTION
    case DUE_DILIGENCE_UPLOAD
    
    //COME_BACK_LATER
    case THANK_YOU_VERIFICATION_BOT_DESCRIPTION
    case THANK_YOU_VERIFICATION_ACTION
}

public class BotMessage : BotMessageEntity {
    public var avatarVisible: BehaviorRelay<Bool>
    
    public init(avatarVisible: Bool) {
        self.avatarVisible = BehaviorRelay(value: avatarVisible)
    }
}

public class BotTextMessage : BotMessage, BotTextMessageEntity {
    public var text: BehaviorRelay<String>
    public var images: BehaviorRelay<[ConfigurationFactory<UIImageView>]>
    public var warningVisible : BehaviorRelay<Bool>
    public var isError : BehaviorRelay<Bool>
    
    public init(text: String, images: [ConfigurationFactory<UIImageView>] = [], avatarVisible: Bool, warningVisible: Bool = false, isError: Bool = false) {
        self.text = BehaviorRelay(value: text)
        self.images = BehaviorRelay(value: images)
        self.warningVisible = BehaviorRelay(value: warningVisible)
        self.isError = BehaviorRelay(value: isError)
        super.init(avatarVisible: avatarVisible)
    }
}

public enum BotLoadingMessageType {
    case document
    case address
    case email_recovery
    case dueDiligence
}

public class BotLoadingMessage : BotMessage, BotLoadingMessageEntity {
    public let type: BotLoadingMessageType
    
    public init(type: BotLoadingMessageType, avatarVisible: Bool) {
        self.type = type
        super.init(avatarVisible: avatarVisible)
    }
}

public class AddressInfoMessage : AddressInfoMessageEntity {
    
    public var form: TemplateFormConfigProtocol
    
    init(form: TemplateFormConfigProtocol) {
        self.form = form
    }
}

public class CongratulationsMessage : CongratulationsMessageEntity {}
public class ThankyouMessage : CongratulationsMessageEntity {}

public class UserTextMessage : UserTextMessageEntity {
    public var text: BehaviorRelay<String>
    
    init(text: String) {
        self.text = BehaviorRelay(value: text)
    }
}

public class UserPhotoMessage : UserPhotoMessageEntity {
    public var photo : BehaviorRelay<Data>
    public var name : BehaviorRelay<String>
    
    init(photo: Data, name: String) {
        self.photo = BehaviorRelay(value: photo)
        self.name = BehaviorRelay(value: name)
    }
}


public enum ActionMessageType {
    case letsBegin
    case cameraSettings
    case chooseDocument
    case passport
    case driver_license_front
    case driver_license_back
    case id_front
    case id_back
    case selfie
    case utility_bill
    case utility_bill_more
    case utility_bill_address
    case plastic_delivery
    case connect_email
    case news_agree
    case wrong_country_connect_email
    case site
    case due_diligence
    case come_back_later_got_it
}


public class ActionMessage : ActionMessageEntity {
    var actionType : ActionMessageType
    
    init(actionType: ActionMessageType) {
        self.actionType = actionType
    }
}

public enum MessagesChange {
    case delete(Int)
    case add(MessageEntity)
}

extension IdentityGetResData {
    
    var isSuccess: Bool {
        let statuses: [ProofStatus] = [.SUCCESS]
        return statuses.contains(documentStatus) && statuses.contains(addressStatus) && statuses.contains(amlStatus) && statuses.contains(dueDiligenceStatus)
    }
    
    var isManualOrSuccess: Bool {
        let statuses: [ProofStatus] = [.MANUAL, .SUCCESS]
        return statuses.contains(documentStatus) && statuses.contains(addressStatus) && statuses.contains(amlStatus) && statuses.contains(dueDiligenceStatus)
    }
}

public class ChatFlowService {
    var timer : Timer?
    
    var state : BehaviorRelay<ChatFlowState> = BehaviorRelay(value: .NO_STATE)
    let disposeBag = DisposeBag()
    
    var messages : [MessageEntity] = []
    let messagesChange : PublishSubject<[MessagesChange]> = PublishSubject()
    
    var storage : IKycStorage
    let flowService : IFlowService
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    lazy var screenProfile : ScreenProfile = {
        return resolver.resolve(ScreenProfile.self, name: "CHAT")!
    }()
    
    lazy var cameraScreenProfile : ScreenProfile = {
        return resolver.resolve(ScreenProfile.self, name: "CAMERA")!
    }()
    
    var identity : IdentityGetResData?
    var deviceIdentity : DeviceIdentityGetResData?
    
    init(storage: IKycStorage, flowService: IFlowService) {
        self.storage = storage
        self.flowService = flowService
        print("CHAT_FLOW_CREATED")
        state.subscribe(onNext: {[weak self] state in
            self?.stateChanged(state)
        }).disposed(by: disposeBag)
        
        messagesChange.subscribe(onNext: {[weak self] changes in
            for change in changes {
                switch change {
                case .delete(let count):
                    self?.messages.removeFirst(count)
                case .add(let entity):
                    self?.messages.insert(entity, at: 0)
                }
            }
        }).disposed(by: disposeBag)
        
        flowService.state.skip(1).subscribe(onNext: {[weak self] state in
            self?.flowStateChanged(state)
        }).disposed(by: disposeBag)
    }
    
    func flowStateChanged(_ state: FlowState) {
        switch state {
        case .IDENTITY_REQUEST_RESULT(let res):
            switch res {
            case .success(_, let data):
                identity = data
                flowService.getDeviceIdentity(uuid: flowService.generateFlowId())
            case .failure(_):
                ()
            }
            
        case .DEVICE_IDENTITY_REQUEST_RESULT(let res):
            switch res {
            case .success(_, let data):
                deviceIdentity = data
                checkRecovery()
            case .failure(_):
                ()
            }
            
        case .RECOVERY_REQUEST_RESULT(let res):
            switch res {
            case .success(_):
                storage.isRecoveryMode = false
                fireNextProof()
            case .failure(_):
                ()
            }
            
        default:
            ()
        }
    }
    
    func fireNextState(_ state: ChatFlowState) {
        let delay = 0.7
        Timer.scheduledTimer(withTimeInterval: delay, repeats: false) {[weak self] _ in
            self?.state.accept(state)
        }
    }
    
    func updateRecovery() {
        flowService.getIdentity(uuid: flowService.generateFlowId())
    }
    
    func fireEventForProofType(_ proofType: ProofType) {
        switch proofType {
        case .DOCUMENT:
            state.accept(.CHOOSE_TYPE_OF_DOCUMENT_DESCRIPTION)
        case .ADDRESS_CONFIRM:
            state.accept(.BOT_LAST_STEP)
        case .DUE_DILIGENCE:
            state.accept(.DUE_DILIGENCE_BOT_DESCRIPTION)
        case .EMAIL:
            if storage.isRecoveryMode {
                state.accept(.BOT_UPLOAD_RECOVERY_EMAIL)
            } else {
                state.accept(.BOT_CONNECT_EMAIL_DESCRIPTION)
            }
        case .PHONE:
            ()
        }
    }
    
    func checkRecovery() {
        if storage.isRecoveryMode, let identityProofs = identity?.proofs, let deviceIdentityProofs = deviceIdentity?.proofs {
            var missingProof : ProofType?
            for identityProof in identityProofs {
                if !identityProof.recovery {
                    continue
                }
                if !deviceIdentityProofs.map({ $0.type }).contains(identityProof.type) {
                    missingProof = identityProof.type
                    break
                }
            }
            
            if missingProof == nil {
                flowService.sendRecoveryRequest(uuid: flowService.generateFlowId())
            } else {
                fireEventForProofType(missingProof!)
            }
            return
        }
        
        if !storage.isRecoveryMode, let identity = identity {
            if identity.documentStatus != .SUCCESS {
                fireEventForProofType(.DOCUMENT)
            } else if identity.addressStatus != .SUCCESS, identity.addressStatus != .MANUAL {
                fireEventForProofType(.ADDRESS_CONFIRM)
            } else if identity.dueDiligenceStatus != .SUCCESS {
                fireEventForProofType(.DUE_DILIGENCE)
            } else if identity.emailStatus != .SUCCESS, !storage.emailDenied {
                fireEventForProofType(.EMAIL)
            } else if identity.riskScore == .HIGH {
               (resolver as? Container)?.register(ErrorWarningInfoConfiguratorProtocol.self, factory: { _ in
                   return ErrorWarningInfoConfigurator.getHighRisk()
               }).inObjectScope(.weak)
               resolver.resolve(StateNavigatorProtocol.self)?.state.accept(.ERROR_WARNING_INFO)
            } else if !identity.isSuccess {
                state.accept(.THANK_YOU_VERIFICATION_BOT_DESCRIPTION)
            } else {
                state.accept(.CONGRATULATIONS)
            }
            return
        }
        /*if let deviceProofs = deviceIdentity?.proofs.map({ $0.type }) {
         if let proofType = proofTypes.first(where: { !deviceProofs.contains($0) }) {
         fireEventForProofType(proofType)
         return
         }
         }*/
    }
    
    func fireNextProof() {
        updateRecovery()
        /*if storage.isRecoveryMode {
         updateRecovery()
         } else {
         checkRecovery()
         }*/
    }
    
    func stateChanged(_ state: ChatFlowState) {
        
        switch state {
        case .NO_STATE:
            ()
        //self.state.accept(.HELLO)
        case .HELLO:
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("HELLO"), avatarVisible: true)
            messagesChange.onNext([.add(botTextMessage)])
            fireNextState(storage.isRecoveryMode ? .HELLO_RECOVER_DESCRIPTION : .HELLO_DESCRIPTION)
            
        case .HELLO_RECOVER_DESCRIPTION:
            (messages.first as? BotMessage)?.avatarVisible.accept(false)
            
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("HELLO_RECOVER_DESCRIPTION"), avatarVisible: true)
            messagesChange.onNext([.add(botTextMessage)])
            fireNextState(.LETS_BEGIN)
            
        case .HELLO_DESCRIPTION:
            (messages.first as? BotMessage)?.avatarVisible.accept(false)
            
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("HELLO_DESCRIPTION"), avatarVisible: true)
            messagesChange.onNext([.add(botTextMessage)])
            fireNextState(.LETS_BEGIN)
            
        case .LETS_BEGIN:
            let letsBeginActionMessage = ActionMessage(actionType: .letsBegin)
            messagesChange.onNext([.add(letsBeginActionMessage)])
            
        case .LETS_BEGIN_USER_MESSAGE:
            let userTextMessage = UserTextMessage(text: screenProfile.getLocalizedText("LETS_BEGIN_USER_MESSAGE"))
            messagesChange.onNext([.delete(1), .add(userTextMessage)])
            fireNextProof()
            
        case .CAMERA_SETTINGS_DESCRIPTION:
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("CAMERA_SETTINGS_DESCRIPTION"), avatarVisible: true)
            messagesChange.onNext([.add(botTextMessage)])
            fireNextState(.CAMERA_SETTINGS)
            
        case .CAMERA_SETTINGS:
            let actionMessage = ActionMessage(actionType: .cameraSettings)
            messagesChange.onNext([.add(actionMessage)])
            
        case .CHOOSE_TYPE_OF_DOCUMENT_DESCRIPTION:
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("CHOOSE_TYPE_OF_DOCUMENT_DESCRIPTION"), avatarVisible: true)
            messagesChange.onNext([.add(botTextMessage)])
            fireNextState(.CHOOSE_TYPE_OF_DOCUMENT(deleteCount: 0))
            
        case .CHOOSE_TYPE_OF_DOCUMENT(let deleteCount):
            let actionMessage = ActionMessage(actionType: .chooseDocument)
            messagesChange.onNext([.delete(deleteCount), .add(actionMessage)])
            
        case .CHOOSE_PASSPORT_USER_MESSAGE:
            let userTextMessage = UserTextMessage(text: screenProfile.getLocalizedText("CHOOSE_PASSPORT_USER_MESSAGE"))
            messagesChange.onNext([.delete(1), .add(userTextMessage)])
            fireNextState(.PASSPORT_PHOTO_DESCRIPTION)
            
        case .CHOOSE_DRIVER_LICENSE_USER_MESSAGE:
            let userTextMessage = UserTextMessage(text: screenProfile.getLocalizedText("CHOOSE_DRIVER_LICENSE_USER_MESSAGE"))
            messagesChange.onNext([.delete(1), .add(userTextMessage)])
            fireNextState(.DRIVER_LICENSE_FRONT_PAGE_DESCRIPTION)
            
        case .CHOOSE_ID_CARD_USER_MESSAGE:
            let userTextMessage = UserTextMessage(text: screenProfile.getLocalizedText("CHOOSE_ID_CARD_USER_MESSAGE"))
            messagesChange.onNext([.delete(1), .add(userTextMessage)])
            fireNextState(.ID_FRONT_PAGE_DESCRIPTION)
            
        case .PASSPORT_PHOTO_DESCRIPTION:
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("PASSPORT_PHOTO_DESCRIPTION"), avatarVisible: true)
            messagesChange.onNext([.add(botTextMessage)])
            fireNextState(.PASSPORT_PHOTO_ACTION)
            
        case .PASSPORT_PHOTO_ACTION:
            let actionMessage = ActionMessage(actionType: .passport)
            messagesChange.onNext([.add(actionMessage)])
            
        case .PASSPORT_PHOTO_TAKEN(let photoData):
            let userPhotoMessage = UserPhotoMessage(photo: photoData, name: cameraScreenProfile.getLocalizedText("PASSPORT"))
            messagesChange.onNext([.delete(1), .add(userPhotoMessage)])
            fireNextState(.SELFIE_DESCRIPTION)
            
        case .DRIVER_LICENSE_FRONT_PAGE_DESCRIPTION:
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("DRIVER_LICENSE_FRONT_PAGE_DESCRIPTION"), avatarVisible: true)
            messagesChange.onNext([.add(botTextMessage)])
            fireNextState(.DRIVER_LICENSE_FRONT_ACTION)
            
        case .DRIVER_LICENSE_FRONT_ACTION:
            let actionMessage = ActionMessage(actionType: .driver_license_front)
            messagesChange.onNext([.add(actionMessage)])
            
        case .DRIVER_LICENSE_FRONT_TAKEN(let photoData):
            let userPhotoMessage = UserPhotoMessage(photo: photoData, name: "\(cameraScreenProfile.getLocalizedText("DRIVER_LICENSE")): \(cameraScreenProfile.getLocalizedText("FRONTPAGE"))")
            messagesChange.onNext([.delete(1), .add(userPhotoMessage)])
            fireNextState(.DRIVER_LICENSE_BACK_PAGE_DESCRIPTION)
            
        case .DRIVER_LICENSE_BACK_PAGE_DESCRIPTION:
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("DRIVER_LICENSE_BACK_PAGE_DESCRIPTION"), avatarVisible: true)
            messagesChange.onNext([.add(botTextMessage)])
            fireNextState(.DRIVER_LICENSE_BACK_ACTION)
            
        case .DRIVER_LICENSE_BACK_ACTION:
            let actionMessage = ActionMessage(actionType: .driver_license_back)
            messagesChange.onNext([.add(actionMessage)])
            
        case .DRIVER_LICENSE_BACK_TAKEN(let photoData):
            let userPhotoMessage = UserPhotoMessage(photo: photoData, name: "\(cameraScreenProfile.getLocalizedText("DRIVER_LICENSE")): \(cameraScreenProfile.getLocalizedText("BACKPAGE"))")
            messagesChange.onNext([.delete(1), .add(userPhotoMessage)])
            fireNextState(.SELFIE_DESCRIPTION)
            
        case .ID_FRONT_PAGE_DESCRIPTION:
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("ID_FRONT_PAGE_DESCRIPTION"), avatarVisible: true)
            messagesChange.onNext([.add(botTextMessage)])
            fireNextState(.ID_FRONT_ACTION)
            
        case .ID_FRONT_ACTION:
            let actionMessage = ActionMessage(actionType: .id_front)
            messagesChange.onNext([.add(actionMessage)])
            
        case .ID_FRONT_TAKEN(let photoData):
            let userPhotoMessage = UserPhotoMessage(photo: photoData, name: "\(cameraScreenProfile.getLocalizedText("IDCARD")): \(cameraScreenProfile.getLocalizedText("FRONTPAGE"))")
            messagesChange.onNext([.delete(1), .add(userPhotoMessage)])
            fireNextState(.ID_BACK_PAGE_DESCRIPTION)
            
        case .ID_BACK_PAGE_DESCRIPTION:
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("ID_BACK_PAGE_DESCRIPTION"), avatarVisible: true)
            messagesChange.onNext([.add(botTextMessage)])
            fireNextState(.ID_BACK_ACTION)
            
        case .ID_BACK_ACTION:
            let actionMessage = ActionMessage(actionType: .id_back)
            messagesChange.onNext([.add(actionMessage)])
            
        case .ID_BACK_TAKEN(let photoData):
            let userPhotoMessage = UserPhotoMessage(photo: photoData, name: "\(cameraScreenProfile.getLocalizedText("IDCARD")): \(cameraScreenProfile.getLocalizedText("BACKPAGE"))")
            messagesChange.onNext([.delete(1), .add(userPhotoMessage)])
            fireNextState(.SELFIE_DESCRIPTION)
            
        case .SELFIE_DESCRIPTION:
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("SELFIE_DESCRIPTION"), avatarVisible: true)
            messagesChange.onNext([.add(botTextMessage)])
            fireNextState(.SELFIE_ACTION)
            
        case .SELFIE_ACTION:
            let actionMessage = ActionMessage(actionType: .selfie)
            messagesChange.onNext([.add(actionMessage)])
            
        case .SELFIE_PHOTO_TAKEN(let photoData):
            let userPhotoMessage = UserPhotoMessage(photo: photoData, name: cameraScreenProfile.getLocalizedText("SELFIE"))
            messagesChange.onNext([.delete(1), .add(userPhotoMessage)])
            fireNextState(.BOT_UPLOAD_DESCRIPTION)
            
        case .BOT_UPLOAD_DESCRIPTION:
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("BOT_UPLOAD_DESCRIPTION"), avatarVisible: true)
            messagesChange.onNext([.add(botTextMessage)])
            fireNextState(.BOT_UPLOAD_LOADING)
            
        case .BOT_UPLOAD_LOADING:
            (messages.first as? BotMessage)?.avatarVisible.accept(false)
            let botLoadingMessage = BotLoadingMessage(type: .document, avatarVisible: true)
            messagesChange.onNext([.add(botLoadingMessage)])
            
        case .BOT_LAST_STEP:
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("BOT_LAST_STEP"), avatarVisible: true)
            messagesChange.onNext([.add(botTextMessage)])
            fireNextState(.BOT_BILL_EXAMPLES)
            
        case .BOT_BILL_EXAMPLES:
            (messages.first as? BotMessage)?.avatarVisible.accept(false)
            let imageIds : [String] = screenProfile.getLocalizedText("BOT_BILL_EXAMPLES_ASSETS").split(separator: ",").map({ String($0) })
            let assets : [ConfigurationFactory<UIImageView>] = imageIds.map({ resolver.resolve(AssetProfile.self, name: $0)!.getAssetConfigurationFactory() })
            
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("BOT_BILL_EXAMPLES"), images: assets, avatarVisible: true)
            messagesChange.onNext([.add(botTextMessage)])
            fireNextState(.UTILITY_BILL_ACTION)
            
        case .UTILITY_BILL_ACTION:
            let actionMessage = ActionMessage(actionType: .utility_bill)
            messagesChange.onNext([.add(actionMessage)])
            
        case .UTILITY_BILL_USER_PHOTO(let photoData, let showDescription, let limitReached):
            let userPhotoMessage = UserPhotoMessage(photo: photoData, name: cameraScreenProfile.getLocalizedText("UTILITY_BILL"))
            messagesChange.onNext([.delete(1), .add(userPhotoMessage)])
            if limitReached {
                fireNextState(.BOT_ADDRESS_UTILITY_BILL_DESCRIPTION)
            } else if showDescription {
                fireNextState(.UTILITY_BILL_BOT_MORE_DESCRIPTION)
            } else {
                fireNextState(.UTILITY_BILL_MORE_ACTION)
            }
            
        case .UTILITY_BILL_BOT_MORE_DESCRIPTION:
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("UTILITY_BILL_BOT_MORE_DESCRIPTION"), avatarVisible: true)
            messagesChange.onNext([.add(botTextMessage)])
            fireNextState(.UTILITY_BILL_MORE_ACTION)
            
        case .UTILITY_BILL_MORE_ACTION:
            let actionMessage = ActionMessage(actionType: .utility_bill_more)
            messagesChange.onNext([.add(actionMessage)])
            
        case .BOT_ADDRESS_UTILITY_BILL_DESCRIPTION:
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("BOT_ADDRESS_UTILITY_BILL_DESCRIPTION"), avatarVisible: true)
            messagesChange.onNext([.delete(1), .add(botTextMessage)])
            fireNextState(.ADDRESS_UTILITY_BILL_ACTION)
            
        case .ADDRESS_UTILITY_BILL_ACTION:
            let actionMessage = ActionMessage(actionType: .utility_bill_address)
            messagesChange.onNext([.add(actionMessage)])
            
        case .ADDRESS_INFO(let form):
            let addressInfoMessage = AddressInfoMessage(form: form)
            messagesChange.onNext([.add(addressInfoMessage)])
            
        case .BOT_UTILITY_BILL_UPLOAD_LOADING:
            let botLoadingMessage = BotLoadingMessage(type: .address, avatarVisible: true)
            messagesChange.onNext([.add(botLoadingMessage)])
            
        case .BOT_PLASTIC_DELIVERY_DESCRIPTION:
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("BOT_PLASTIC_DELIVERY_DESCRIPTION"), avatarVisible: true)
            messagesChange.onNext([.add(botTextMessage)])
            fireNextState(.PLASTIC_DELIVERY_ACTION)
            
        case .PLASTIC_DELIVERY_ACTION:
            let actionMessage = ActionMessage(actionType: .plastic_delivery)
            messagesChange.onNext([.add(actionMessage)])
            
        case .PLASTIC_DELIVERY_ADDRESS_INFO(let address):
            let userTextMessage = UserTextMessage(text: address.stringPresentation)
            messagesChange.onNext([.add(userTextMessage)])
            
            fireNextProof()
            
        case .CONGRATULATIONS:
            let congratulationsMessage = CongratulationsMessage()
            messagesChange.onNext([.add(congratulationsMessage)])
            
        case .BOT_CONNECT_EMAIL_DESCRIPTION:
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("BOT_CONNECT_EMAIL_DESCRIPTION"), avatarVisible: true)
            messagesChange.onNext([.add(botTextMessage)])
            fireNextState(.CONNECT_EMAIL_ACTION)
            
        case .CONNECT_EMAIL_ACTION:
            let actionMessage = ActionMessage(actionType: .connect_email)
            messagesChange.onNext([.add(actionMessage)])
        
        case .BOT_NEWS_DESCRIPTION:
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("BOT_NEWS_DESCRIPTION"), avatarVisible: true)
            messagesChange.onNext([.delete(1), .add(botTextMessage)])
            fireNextState(.NEWS_AGREE_ACTION)
            
        case .NEWS_AGREE_ACTION:
            let actionMessage = ActionMessage(actionType: .news_agree)
            messagesChange.onNext([.add(actionMessage)])
            
        case .NEWS_AGREE_RESULT(let agree):
            let userTextMessage = UserTextMessage(text: agree ? screenProfile.getLocalizedText("NEWS_AGREE_RESULT_ACCEPT") : screenProfile.getLocalizedText("NEWS_AGREE_RESULT_DENY"))
            messagesChange.onNext([.delete(1), .add(userTextMessage)])
            if !agree {
                fireNextState(.BOT_NEWS_DISAGREE_DESCRIPTION)
            } else {
                fireNextState(.ENTER_EMAIL)
            }
            
        case .BOT_NEWS_DISAGREE_DESCRIPTION:
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("BOT_NEWS_DISAGREE_DESCRIPTION"), avatarVisible: true)
            messagesChange.onNext([.add(botTextMessage)])
            fireNextState(.ENTER_EMAIL)
            
        case .ENTER_EMAIL:
            //OPEN EMAIL FORM
            (resolver as? Container)!.register(EmailFormRouterProtocol.self, factory: { resolver in
                let router = EmailFormRouter()
                router.emailProvided = { email in
                    resolver.resolve(ConnectEmailViewModel.self)?.email = email
                    resolver.resolve(StateNavigatorProtocol.self)?.state.accept(.EMAIL_VERIFICATION)
                }
                return router
            }).inObjectScope(.weak)
            
            let viewModel = resolver.resolve(ConnectEmailViewModel.self)!
            
            (resolver as? Container)!.register(EmailFormInteractorProtocol.self, factory: { resolver in
                return ConnectEmailFormInteractor(flowService: resolver.resolve(IFlowService.self)!, viewModel: viewModel, storage: resolver.resolve(IKycStorage.self)!)
            }).inObjectScope(.weak)
            
            (resolver as? Container)!.register(EmailFormConfiguratorProtocol.self, factory: { _ in
                return EmailFormConfigurator(screenId: "ENTER_EMAIL")
            }).inObjectScope(.weak)
            resolver.resolve(StateNavigatorProtocol.self)?.state.accept(.EMAIL_FORM)
            fireNextState(.BOT_CONNECT_EMAIL_DESCRIPTION)
            
        case .USER_NO_EMAIL_DESCRIPTION:
            let userTextMessage = UserTextMessage(text: screenProfile.getLocalizedText("USER_NO_EMAIL_DESCRIPTION"))
            messagesChange.onNext([.delete(1), .add(userTextMessage)])
            fireNextState(.BOT_NO_EMAIL_DESCRIPTION)
            
        case .BOT_NO_EMAIL_DESCRIPTION:
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("BOT_NO_EMAIL_DESCRIPTION"), avatarVisible: true)
            messagesChange.onNext([.add(botTextMessage)])
            fireNextProof()
            
        case .BOT_UPLOAD_RECOVERY_EMAIL:
            let botLoadingMessage = BotLoadingMessage(type: .email_recovery, avatarVisible: true)
            messagesChange.onNext([.add(botLoadingMessage)])
            
        case .BOT_ENTER_RECOVERY_EMAIL_CODE_DESCRIPTION:
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("BOT_ENTER_RECOVERY_EMAIL_CODE_DESCRIPTION"), avatarVisible: true)
            messagesChange.onNext([.add(botTextMessage)])
            let delay = 0.7
            Timer.scheduledTimer(withTimeInterval: delay, repeats: false) {[weak self] _ in
                //self?.resolver.resolve(ConnectEmailViewModel.self)?.email = email
                self?.resolver.resolve(StateNavigatorProtocol.self)?.state.accept(.EMAIL_VERIFICATION)
            }
            
        case .EMAIL_VERIFIED(let email, let code):
            var newMessages : [MessagesChange] = []
            if messages.first is ActionMessage {
                newMessages.append(.delete(1))
            }
            if !email.isEmpty {
                newMessages.append(.add(UserTextMessage(text: email)))
            }
            newMessages.append(.add(UserTextMessage(text: code)))
            messagesChange.onNext(newMessages)
            fireNextProof()
            
        case .SOMETHING_WENT_WRONG:
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("SOMETHING_WENT_WRONG"), avatarVisible: true, isError: true)
            messagesChange.onNext([.add(botTextMessage)])
            fireNextProof()
            
            
        case .BOT_WRONG_COUNTRY_DESCRIPTION:
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("BOT_WRONG_COUNTRY_DESCRIPTION"), avatarVisible: true, warningVisible: true)
            messagesChange.onNext([.add(botTextMessage)])
            fireNextState(.BOT_WRONG_COUNTRY_EMAIL_DESCRIPTION)
            
        case .BOT_WRONG_COUNTRY_EMAIL_DESCRIPTION:
            (messages.first as? BotMessage)?.avatarVisible.accept(false)
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("BOT_WRONG_COUNTRY_EMAIL_DESCRIPTION"), avatarVisible: true)
            messagesChange.onNext([.add(botTextMessage)])
            fireNextState(.WRONG_COUNTRY_CONNECT_EMAIL_ACTION)
            
        case .WRONG_COUNTRY_CONNECT_EMAIL_ACTION:
            let actionMessage = ActionMessage(actionType: .wrong_country_connect_email)
            messagesChange.onNext([.add(actionMessage)])
            
        case .USER_WRONG_COUNTRY_NO_EMAIL:
            let userTextMessage = UserTextMessage(text: screenProfile.getLocalizedText("USER_WRONG_COUNTRY_NO_EMAIL"))
            messagesChange.onNext([.add(userTextMessage)])
            fireNextState(.BOT_WRONG_COUNTRY_NO_EMAIL_DESCRIPTION)
            
        case .BOT_WRONG_COUNTRY_NO_EMAIL_DESCRIPTION:
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("BOT_WRONG_COUNTRY_NO_EMAIL_DESCRIPTION"), avatarVisible: true)
            messagesChange.onNext([.add(botTextMessage)])
            fireNextState(.SITE_ACTION)
            
        case .SITE_ACTION:
            let actionMessage = ActionMessage(actionType: .site)
            messagesChange.onNext([.add(actionMessage)])
            
        case .USER_WRONG_COUNTRY_EMAIL_PROVIDED(let email):
            let userTextMessage = UserTextMessage(text: email)
            messagesChange.onNext([.add(userTextMessage)])
            fireNextState(.WRONG_COUNTRY_THANK_YOU)
            
        case .WRONG_COUNTRY_THANK_YOU:
            let thankyouMessage = ThankyouMessage()
            messagesChange.onNext([.add(thankyouMessage)])
            
        case .BOT_WRONG_AGE_DESCRIPTION:
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("BOT_WRONG_AGE_DESCRIPTION"), avatarVisible: true, warningVisible: true)
            messagesChange.onNext([.add(botTextMessage)])
            
        case .DUE_DILIGENCE_BOT_DESCRIPTION:
            (messages.first as? BotMessage)?.avatarVisible.accept(false)
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("DUE_DILIGENCE_BOT_DESCRIPTION"), avatarVisible: true)
            messagesChange.onNext([.add(botTextMessage)])
            fireNextState(.DUE_DILIGENCE_ACTION)
            
        case .DUE_DILIGENCE_ACTION:
            let actionMessage = ActionMessage(actionType: .due_diligence)
            messagesChange.onNext([.add(actionMessage)])
            
        case .DUE_DILIGENCE_UPLOAD:
            (messages.first as? BotMessage)?.avatarVisible.accept(false)
            let botLoadingMessage = BotLoadingMessage(type: .dueDiligence, avatarVisible: true)
            messagesChange.onNext([.add(botLoadingMessage)])
            
        case .THANK_YOU_VERIFICATION_BOT_DESCRIPTION:
            (messages.first as? BotMessage)?.avatarVisible.accept(false)
            let botTextMessage = BotTextMessage(text: screenProfile.getLocalizedText("THANK_YOU_VERIFICATION_BOT_DESCRIPTION"), avatarVisible: true)
            messagesChange.onNext([.add(botTextMessage)])
            fireNextState(.THANK_YOU_VERIFICATION_ACTION)
            
        case .THANK_YOU_VERIFICATION_ACTION:
            let actionMessage = ActionMessage(actionType: .come_back_later_got_it)
            messagesChange.onNext([.add(actionMessage)])
            
        default:
            ()
        }
    }
}
