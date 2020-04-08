//
//  FlowService.swift
//  CoreStore
//
//  Created by Nik on 25/12/2019.
//

import Foundation
import RxSwift
import RxRelay
import iOSCoreSDK

public protocol IFlowService {
    var state : BehaviorRelay<FlowState> { get }
    func setPhone(uuid: String, phoneNumber: String, device: String, model: String?, deviceType: DeviceType)
    func confirmPhone(uuid: String, code: String)
    func retrySendPhoneCode(uuid: String)
    func setEmail(uuid: String, email: String, isAgree: Bool)
    func approveEmail(uuid: String)
    func confirmEmail(uuid: String, code: String)
    func retrySendEmailCode(uuid: String)
    func uploadDocument(uuid: String, documentType: DocumentType, frontImageFile: Data?, backImageFile: Data?, faceImageFile: Data?)
    func approveDocument(uuid: String, documentType: DocumentType, frontImageFile: Data?, backImageFile: Data?, faceImageFile: Data?)
    func uploadAddress(uuid: String, addressData: [String: String], addressImages: [Data])
    func setDueDiligence(uuid: String, data: [String: String])
    func sendRecoveryRequest(uuid: String)
    func deviceAuthorizationRequest(uuid: String)
    func handleDeviceAuthorizationRequest(uuid: String, authRequestId: String, action: AuthorizationAction)
    func getUserDevices(uuid: String)
    func getAuthorizationRequestList(uuid: String)
    func generateFlowId() -> String
    func getIdentity(uuid: String)
    func getDeviceIdentity(uuid: String)
    func getCountries(uuid: String)
}

public class FlowService : IFlowService {
    
    public private(set) var core : ISDKCore!
    let disposeBag = DisposeBag()
    
    let _state : BehaviorRelay<FlowState> = BehaviorRelay.init(value: .NO_STATE)
    public var state : BehaviorRelay<FlowState> {
        return _state //.asObservable()
    }
    
    public init(core: ISDKCore) {
        self.core = core
        core.onEvent.subscribe(onNext: {[weak self] (name, data) in
            self?.onEvent(name: name, data: data)
        }).disposed(by: disposeBag)
    }
    
    public func generateFlowId() -> String {
        return core.generateFlowId()
    }
    
    func onEvent(name: String, data: String) {
        guard let flowListenEvent = FlowListenEvent.getListenEvent(name: name, data: data) else { return }
        onFlowListenEvent(flowListenEvent)
    }
    
    func onFlowListenEvent(_ listenEvent: FlowListenEvent) {
        switch listenEvent {
        case .PHONE_FLOW_RES(let req):
            receivedPhoneFlowRes(req)
            
        case .PHONE_SUBMIT_PHONE_REQ(let req):
            receivedPhoneSubmitPhoneReq(req)
            
        case .PHONE_SUBMIT_CODE_REQ(let req):
            receivedPhoneSubmitCodeReq(req)
            
        case .PHONE_RESEND_CODE_RES(let req):
            receivedPhoneResendCodeReq(req)
            
        case .EMAIL_FLOW_RES(let req):
            receivedEmailFlowRes(req)
            
        case .EMAIL_SUBMIT_CODE_REQ(let req):
            receivedEmailSubmitCodeReq(req)
            
        case .EMAIL_RESEND_CODE_RES(let req):
            receivedEmailResendCodeReq(req)
            
        case .DOCUMENT_FLOW_RES(let req):
            receivedDocumentFlowRes(req)
            
        case .ADDRESS_FLOW_RES(let req):
            receivedAddressFlowRes(req)
            
        case .DUE_DILIGENCE_CREATE_RES(let req):
            receivedDueDiligenceFlowRes(req)
        
        case .DEVICE_AUTHORIZATION_FLOW_RES(let req):
            receivedDeviceAuthorizationFlowRes(req)
            
        case .AUTHORIZATION_DEVICE_NEW(let req):
            receivedAuthorizationDeviceNew(req)
            
        case .AUTHORIZATION_REQUEST_LIST_RES(let req):
            receivedAuthorizationRequestListRes(req)
            
        case .AUTHORIZATION_REQUEST_REQ(let req):
            receivedAuthorizationRequestReq(req)
            
        case .AUTHORIZATION_DEVICE_LIST_RES(let req):
            receivedAuthorizationDeviceListRes(req)
            
        case .RECOVERY_REQUEST_RES(let req):
            receivedRecoveryRequestRes(req)
            
        case .IDENTITY_GET_RES(let req):
            identityRequestRes(req)
            
        case .DEVICE_IDENTITY_GET_RES(let req):
            deviceIdentityRequestRes(req)
            
        case .COUNTRIES_GET_RES(let req):
            countriesRequestRes(req)
            
        case .DOCUMENT_PROCESSED:
            _state.accept(.DOCUMENT_PROCESSED)
            
        case .ADDRESS_PROCESSED:
            _state.accept(.ADDRESS_PROCESSED)
            
        case .AML_PROCESSED:
            _state.accept(.AML_PROCESSED)
        }
    }
    
    //PHONE FLOW
    func receivedPhoneFlowRes(_ req: PhoneFlowRes) {
        switch req.success {
        case true:
            _state.accept(.REGISTRATION_PHONE_FLOW_RESULT(.success(data: req.data!)))
        case false:
            _state.accept(.REGISTRATION_PHONE_FLOW_RESULT(.failure(error: req.error)))
        }
    }
    
    func receivedPhoneSubmitPhoneReq(_ req: PhoneSubmitPhoneReq) {
        switch req.success {
        case true:
            _state.accept(.REGISTRATION_PHONE_SUBMIT(.success(uuid: req.uuid, data: req.data!)))
        case false:
            _state.accept(.REGISTRATION_PHONE_SUBMIT(.failure(uuid: req.uuid, error: req.lastError ?? "")))
        }
    }
    
    func receivedPhoneSubmitCodeReq(_ req: PhoneSubmitCodeReq) {
        switch req.success {
        case true:
            _state.accept(.REGISTRATION_PHONE_SUBMIT_SOLUTION(.success(uuid: req.uuid, data: req.data!)))
        case false:
            _state.accept(.REGISTRATION_PHONE_SUBMIT_SOLUTION(.failure(uuid: req.uuid, error: nil)))
        }
    }
    
    func receivedPhoneResendCodeReq(_ req: PhoneSubmitCodeReq) {
        switch req.success {
        case true:
            _state.accept(.REGISTRATION_PHONE_SUBMIT_SOLUTION(.success(uuid: req.uuid, data: req.data!)))
        case false:
            _state.accept(.REGISTRATION_PHONE_SUBMIT_SOLUTION(.failure(uuid: req.uuid, error: nil)))
        }
    }
    
    //EMAIL FLOW
    func receivedEmailFlowRes(_ req: EmailFlowRes) {
        switch req.success {
        case true:
            _state.accept(.REGISTRATION_EMAIL_FLOW_RESULT(.success(data: req.data)))
        case false:
            _state.accept(.REGISTRATION_EMAIL_FLOW_RESULT(.failure(error: req.error)))
        }
    }
    
    func receivedEmailSubmitCodeReq(_ req: EmailSubmitCodeReq) {
        switch req.success {
        case true:
            _state.accept(.REGISTRATION_EMAIL_SUBMIT_SOLUTION(.success(uuid: req.uuid, data: req.data)))
        case false:
            _state.accept(.REGISTRATION_EMAIL_SUBMIT_SOLUTION(.failure(uuid: req.uuid, error: req.lastError ?? "")))
        }
    }
    
    func receivedEmailResendCodeReq(_ req: EmailSubmitCodeReq) {
        switch req.success {
        case true:
            _state.accept(.REGISTRATION_EMAIL_SUBMIT_SOLUTION(.success(uuid: req.uuid, data: req.data)))
        case false:
            _state.accept(.REGISTRATION_EMAIL_SUBMIT_SOLUTION(.failure(uuid: req.uuid, error: req.lastError ?? "")))
        }
    }
    
    //DOCUMENT FLOW
    func receivedDocumentFlowRes(_ req: DocumentFlowRes) {
        switch req.success {
        case true:
            _state.accept(.REGISTRATION_DOCUMENT_FLOW_RESULT(.success(error: req.error)))
        case false:
            _state.accept(.REGISTRATION_DOCUMENT_FLOW_RESULT(.failure(error: req.error)))
        }
    }
    
    //ADDRESS FLOW
    func receivedAddressFlowRes(_ req: AddressFlowRes) {
        switch req.success {
        case true:
            _state.accept(.REGISTRATION_ADDRESS_FLOW_RESULT(.success(uuid: req.uuid!)))
        case false:
            _state.accept(.REGISTRATION_ADDRESS_FLOW_RESULT(.failure(error: req.error)))
        }
    }
    
    //DUE DILIGENCE FLOW
    func receivedDueDiligenceFlowRes(_ req: DueDiligenceCreateRes) {
        switch req.success {
        case true:
            _state.accept(.DUE_DILIGENCE_FLOW_RESULT(.success(uuid: req.uuid)))
        case false:
            _state.accept(.DUE_DILIGENCE_FLOW_RESULT(.failure(error: req.error)))
        }
    }
    
    //DEVICE AUTHORIZATION FLOW
    func receivedDeviceAuthorizationFlowRes(_ req: DeviceAuthorozationFlowRes) {
        switch req.success {
        case true:
            _state.accept(.DEVICE_AUTHORIZATION_FLOW_RESULT(.success(uuid: req.uuid!, data: req.data)))
        case false:
            _state.accept(.DEVICE_AUTHORIZATION_FLOW_RESULT(.failure(error: req.error)))
        }
    }
    
    func receivedAuthorizationDeviceNew(_ req: AuthorizationDeviceNew) {
        switch req.success {
        case true:
            _state.accept(.AUTHORIZATION_DEVICE_NEW(.success(data: req.data!)))
        case false:
            _state.accept(.AUTHORIZATION_DEVICE_NEW(.failure(error: req.error)))
        }
    }
    
    func receivedAuthorizationRequestListRes(_ req: AuthorizationRequestListRes) {
        switch req.success {
        case true:
            _state.accept(.AUTHORIZATION_REQUEST_LIST_RES(.success(data: req.data!)))
        case false:
            _state.accept(.AUTHORIZATION_REQUEST_LIST_RES(.failure(error: req.error)))
        }
    }
    
    func receivedAuthorizationRequestReq(_ req: AuthorizationRequestReq) {
        switch req.success {
        case true:
            _state.accept(.DEVICE_AUTHORIZATION_RESULT(.success(data: req.data!)))
        case false:
            _state.accept(.DEVICE_AUTHORIZATION_RESULT(.failure(error: req.error)))
        }
    }
    
    func receivedAuthorizationDeviceListRes(_ req: AuthorizationDeviceListRes) {
        switch req.success {
        case true:
            _state.accept(.AUTHORIZATION_DEVICE_LIST_RESULT(.success(uuid: req.uuid, devices: req.devices)))
        case false:
            _state.accept(.AUTHORIZATION_DEVICE_LIST_RESULT(.failure(error: req.error)))
        }
    }
    
    //RECOVERY REQUEST
    func receivedRecoveryRequestRes(_ req: RecoveryRequestRes) {
        switch req.success {
        case true:
            _state.accept(.RECOVERY_REQUEST_RESULT(.success(uuid: req.uuid)))
        case false:
            _state.accept(.RECOVERY_REQUEST_RESULT(.failure(error: req.error ?? "")))
        }
    }
    
    //IDENTITY REQUEST
    func identityRequestRes(_ req: IdentityGetRes) {
        switch req.success {
        case true:
            _state.accept(.IDENTITY_REQUEST_RESULT(.success(uuid: req.uuid, data: req.data!)))
        case false:
            _state.accept(.IDENTITY_REQUEST_RESULT(.failure(error: req.error)))
        }
    }
    
    func deviceIdentityRequestRes(_ req: DeviceIdentityGetRes) {
        switch req.success {
        case true:
            _state.accept(.DEVICE_IDENTITY_REQUEST_RESULT(.success(uuid: req.uuid, data: req.data!)))
        case false:
            _state.accept(.DEVICE_IDENTITY_REQUEST_RESULT(.failure(error: req.error)))
        }
    }
    
    //COUNTRIES
    func countriesRequestRes(_ req: CountriesGetRes) {
        switch req.success {
        case true:
            _state.accept(.COUNTRIES_REQUEST_RESULT(.success(uuid: req.uuid ?? "", data: req.data ?? [])))
        case false:
            _state.accept(.COUNTRIES_REQUEST_RESULT(.failure(error: req.error)))
        }
    }
    
    public func setPhone(uuid: String, phoneNumber: String, device: String, model: String?, deviceType: DeviceType) {
        core.push(FlowEmitEvent.REGISTRATION_PHONE_FLOW_REQ(RegistrationPhoneFlowReq(uuid: uuid, phoneNumber: phoneNumber, mainDeviceInfo: DeviceInfo(deviceType: deviceType, model: model, device: device).toString() ?? "")), ackCallback: nil)
    }
    
    public func confirmPhone(uuid: String, code: String) {
        core.push(FlowEmitEvent.REGISTRATION_PHONE_SUBMIT_CODE_RES(RegistrationPhoneSubmitCodeRes(uuid: uuid, data: code)), ackCallback: nil)
    }
    
    public func retrySendPhoneCode(uuid: String) {
        core.push(FlowEmitEvent.REGISTRATION_PHONE_RESEND_CODE_REQ(RegistrationPhoneResendCodeReq(uuid: uuid)), ackCallback: nil)
    }
    
    public func setEmail(uuid: String, email: String, isAgree: Bool) {
        core.push(FlowEmitEvent.REGISTRATION_EMAIL_FLOW_REQ(RegistrationEmailFlowReq(uuid: uuid, data: RegistrationEmailFlowReqData(isRecovery: false, emailAddress: email, isAgree: isAgree, transactionId: ""))), ackCallback: nil)
    }
    
    public func approveEmail(uuid: String) {
        core.push(FlowEmitEvent.REGISTRATION_EMAIL_FLOW_REQ(RegistrationEmailFlowReq(uuid: uuid, data: RegistrationEmailFlowReqData(isRecovery: true, emailAddress: nil, isAgree: nil, transactionId: ""))), ackCallback: nil)
    }
    
    public func confirmEmail(uuid: String, code: String) {
        core.push(FlowEmitEvent.REGISTRATION_EMAIL_SUBMIT_CODE_RES(RegistrationEmailSubmitCodeRes(uuid: uuid, data: code)), ackCallback: nil)
    }
    
    public func retrySendEmailCode(uuid: String) {
        core.push(FlowEmitEvent.REGISTRATION_EMAIL_RESEND_CODE_REQ(RegistrationEmailResendCodeReq(uuid: uuid)), ackCallback: nil)
    }
    
    public func uploadDocument(uuid: String, documentType: DocumentType, frontImageFile: Data?, backImageFile: Data?, faceImageFile: Data?) {
        core.push(FlowEmitEvent.REGISTRATION_DOCUMENT_FLOW_REQ(RegistrationDocumentFlowReq(uuid: uuid, data: RegistrationDocumentFlowReqData(documentType: documentType, isRecovery: false, documentImages: DocumentImages(frontImageFile: frontImageFile?.base64EncodedString(options: .lineLength64Characters), backImageFile: backImageFile?.base64EncodedString(options: .lineLength64Characters), faceImageFile: faceImageFile?.base64EncodedString(options: .lineLength64Characters))))), ackCallback: nil)
    }
    
    public func approveDocument(uuid: String, documentType: DocumentType, frontImageFile: Data?, backImageFile: Data?, faceImageFile: Data?) {
        core.push(FlowEmitEvent.REGISTRATION_DOCUMENT_FLOW_REQ(RegistrationDocumentFlowReq(uuid: uuid, data: RegistrationDocumentFlowReqData(documentType: documentType, isRecovery: true, documentImages: DocumentImages(frontImageFile: frontImageFile?.base64EncodedString(options: .lineLength64Characters), backImageFile: backImageFile?.base64EncodedString(options: .lineLength64Characters), faceImageFile: faceImageFile?.base64EncodedString(options: .lineLength64Characters))))), ackCallback: nil)
    }
    
    public func uploadAddress(uuid: String, addressData: [String: String], addressImages: [Data]) {
        core.push(FlowEmitEvent.REGISTRATION_ADDRESS_FLOW_REQ(RegistrationAddressFlowReq(uuid: uuid, data: RegistrationAddressFlowReqData(addressData: addressData, addressImages: addressImages.map({ $0.base64EncodedString(options: .lineLength64Characters) })))), ackCallback: nil)
    }
    
    public func setDueDiligence(uuid: String, data: [String: String]) {
        core.push(FlowEmitEvent.REGISTRATION_DUE_DILIGENCE_REQ(RegistrationDueDiligenceReq(uuid: uuid, data: RegistrationDueDiligenceReqData(data: data))), ackCallback: nil)
    }
    
    public func sendRecoveryRequest(uuid: String) {
        core.push(FlowEmitEvent.RECOVERY_REQUEST_REQ(RecoveryRequestReq(uuid: uuid)), ackCallback: nil)
    }
    
    public func deviceAuthorizationRequest(uuid: String) {
        core.push(FlowEmitEvent.AUTHORIZATION_FLOW_REQ(AuthorizationFlowReq(uuid: uuid)), ackCallback: nil)
    }
    
    public func handleDeviceAuthorizationRequest(uuid: String, authRequestId: String, action: AuthorizationAction) {
        core.push(FlowEmitEvent.AUTHORIZATION_REQUEST_RES(AuthorizationRequestRes(uuid: uuid, data: AuthorizationRequestResData(authRequestId: authRequestId, action: action))), ackCallback: nil)
    }
    
    public func getUserDevices(uuid: String) {
        core.push(FlowEmitEvent.AUTHORIZATION_DEVICE_LIST_REQ(AuthorizationDeviceListReq(uuid: uuid)), ackCallback: nil)
    }
    
    public func getAuthorizationRequestList(uuid: String) {
        core.push(FlowEmitEvent.AUTHORIZATION_REQUEST_LIST_REQ(AuthorizationRequestListReq(uuid: uuid)), ackCallback: nil)
    }
    
    public func getIdentity(uuid: String) {
        core.push(FlowEmitEvent.IDENTITY_GET_REQ(IdentityGetReq(uuid: uuid)), ackCallback: nil)
    }
    
    public func getDeviceIdentity(uuid: String) {
        core.push(FlowEmitEvent.DEVICE_IDENTITY_GET_REQ(DeviceIdentityGetReq(uuid: uuid)), ackCallback: nil)
    }
    
    public func getCountries(uuid: String) {
        core.push(FlowEmitEvent.COUNTRIES_GET_REQ(CountriesGetReq(uuid: uuid)), ackCallback: nil)
    }
}

