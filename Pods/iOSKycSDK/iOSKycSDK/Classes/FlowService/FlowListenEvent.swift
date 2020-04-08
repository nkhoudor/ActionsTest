//
//  FlowListenEvent.swift
//  CoreStore
//
//  Created by Nik on 25/12/2019.
//

import Foundation
import iOSCoreSDK

enum FlowListenEvent {
    
    // Registration
    case PHONE_FLOW_RES(PhoneFlowRes)
    case PHONE_SUBMIT_PHONE_REQ(PhoneSubmitPhoneReq)
    case PHONE_SUBMIT_CODE_REQ(PhoneSubmitCodeReq)
    case PHONE_RESEND_CODE_RES(PhoneSubmitCodeReq)
    
    // Email
    case EMAIL_FLOW_RES(EmailFlowRes)
    case EMAIL_SUBMIT_CODE_REQ(EmailSubmitCodeReq)
    case EMAIL_RESEND_CODE_RES(EmailSubmitCodeReq)
    
    // Document
    case DOCUMENT_FLOW_RES(DocumentFlowRes)

    // Address
    case ADDRESS_FLOW_RES(AddressFlowRes)

    // Due Diligence Res
    case DUE_DILIGENCE_CREATE_RES(DueDiligenceCreateRes)

    // Device authorization
    case DEVICE_AUTHORIZATION_FLOW_RES(DeviceAuthorozationFlowRes)
    case AUTHORIZATION_DEVICE_NEW(AuthorizationDeviceNew)
    case AUTHORIZATION_REQUEST_LIST_RES(AuthorizationRequestListRes)
    case AUTHORIZATION_REQUEST_REQ(AuthorizationRequestReq)
    case AUTHORIZATION_DEVICE_LIST_RES(AuthorizationDeviceListRes)
    
    //Recovery
    case RECOVERY_REQUEST_RES(RecoveryRequestRes)
    
    //Identity
    case IDENTITY_GET_RES(IdentityGetRes)
    case DEVICE_IDENTITY_GET_RES(DeviceIdentityGetRes)
    
    //Countries
    case COUNTRIES_GET_RES(CountriesGetRes)
    
    //WATCHERS
    case DOCUMENT_PROCESSED
    case ADDRESS_PROCESSED
    case AML_PROCESSED
    
    static func getListenEvent(name: String, data: String?) -> FlowListenEvent? {
        switch name {
        case "Registration.App.Flow.Res":
            if let req = data?.decode(type: PhoneFlowRes.self) {
                return .PHONE_FLOW_RES(req)
            }
        case "Registration.Service.SubmitPhone.Req":
            if let req = data?.decode(type: PhoneSubmitPhoneReq.self) {
                return .PHONE_SUBMIT_PHONE_REQ(req)
            }
        case "Registration.Service.SubmitCode.Req":
            if let req = data?.decode(type: PhoneSubmitCodeReq.self) {
                return .PHONE_SUBMIT_CODE_REQ(req)
            }
        case "Registration.Service.ResendCode.Res":
            if let req = data?.decode(type: PhoneSubmitCodeReq.self) {
                return .PHONE_RESEND_CODE_RES(req)
            }
        case "Email.Service.Flow.Res":
            if let req = data?.decode(type: EmailFlowRes.self) {
                return .EMAIL_FLOW_RES(req)
            }
        case "Email.Service.SubmitCode.Req":
            if let req = data?.decode(type: EmailSubmitCodeReq.self) {
                return .EMAIL_SUBMIT_CODE_REQ(req)
            }
        case "Email.Service.ResendCode.Res":
            if let req = data?.decode(type: EmailSubmitCodeReq.self) {
                return .EMAIL_RESEND_CODE_RES(req)
            }
        case "Document.Service.Flow.Res":
            if let req = data?.decode(type: DocumentFlowRes.self) {
                return .DOCUMENT_FLOW_RES(req)
            }
        case "Address.Service.Flow.Res":
            if let req = data?.decode(type: AddressFlowRes.self) {
                return .ADDRESS_FLOW_RES(req)
            }
        case "Kyc.Service.Due.Diligence.Create.Res":
            if let req = data?.decode(type: DueDiligenceCreateRes.self) {
                return .DUE_DILIGENCE_CREATE_RES(req)
            }
        case "Authorization.Service.Flow.Res":
            if let req = data?.decode(type: DeviceAuthorozationFlowRes.self) {
                return .DEVICE_AUTHORIZATION_FLOW_RES(req)
            }
        case "Authorization.Device.Request.New":
            if let req = data?.decode(type: AuthorizationDeviceNew.self) {
                return .AUTHORIZATION_DEVICE_NEW(req)
            }
        case "Authorization.App.Request.List.Res":
            if let req = data?.decode(type: AuthorizationRequestListRes.self) {
                return .AUTHORIZATION_REQUEST_LIST_RES(req)
            }
        case "Authorization.Service.Request.Req":
            if let req = data?.decode(type: AuthorizationRequestReq.self) {
                return .AUTHORIZATION_REQUEST_REQ(req)
            }
        case "Authorization.Device.List.Res":
            if let req = data?.decode(type: AuthorizationDeviceListRes.self) {
                return .AUTHORIZATION_DEVICE_LIST_RES(req)
            }
        case "Recovery.Service.Request.Res":
            if let req = data?.decode(type: RecoveryRequestRes.self) {
                return .RECOVERY_REQUEST_RES(req)
            }
        case "State.Service.Identity.Get.Res":
            if let req = data?.decode(type: IdentityGetRes.self) {
                return .IDENTITY_GET_RES(req)
            }
        case "State.Service.Device.Get.Res":
            if let req = data?.decode(type: DeviceIdentityGetRes.self) {
                return .DEVICE_IDENTITY_GET_RES(req)
            }
            
        case "Kyc.Service.Countries.Get.Res":
            if let req = data?.decode(type: CountriesGetRes.self) {
                return .COUNTRIES_GET_RES(req)
            }
            
        case "documentService.document.processed":
            return .DOCUMENT_PROCESSED
            
        case "documentService.addressConfirm.processed":
            return .ADDRESS_PROCESSED
            
        case "amlService.document.processed":
            return .AML_PROCESSED
            
        default:
            return nil
        }
        return nil
    }
}

//PHONE_FLOW_RES
struct PhoneFlowRes : Codable {
    let success : Bool
    let error : LastError?
    let data : PhoneFlowResData?
}
public struct PhoneFlowResData : Codable {
    public let isRecovery : Bool?
    public let identityProofs : [IdentityProof]?
}

public struct IdentityProof : Codable {
    let type : String?
    let id : String?
    let recovery : Bool?
}

//PHONE_SUBMIT_PHONE_REQ
struct PhoneSubmitPhoneReq : Codable {
    let uuid : String
    let success : Bool
    let lastError : String?
    let data : PhoneSubmitPhoneReqData?
}
public struct PhoneSubmitPhoneReqData : Codable {
    //TODO
}

//PHONE_SUBMIT_CODE_REQ
struct PhoneSubmitCodeReq : Codable {
    let uuid : String
    let success : Bool
    let data : PhoneSubmitCodeReqData?
}
//TODO: SERVER SENDS DIFFERENT RESULTS
public struct LastError : Codable {
    public let code : Int
}
public struct PhoneSubmitCodeReqData : Codable {
    public let phoneNumber : String?
    public let attemptsLeft : Int?
}

//EMAIL_FLOW_RES
struct EmailFlowRes : Codable {
    let success : Bool
    let error : LastError?
    let data : EmailFlowResData?
}
public struct EmailFlowResData : Codable {
    //TODO
}

//EMAIL_SUBMIT_CODE_REQ
struct EmailSubmitCodeReq : Codable {
    let uuid : String
    let success : Bool
    let lastError : String?
    let data : EmailSubmitCodeReqData?
}
public struct EmailSubmitCodeReqData : Codable {
    public let attemptsLeft : Int?
}

//DOCUMENT_FLOW_RES
struct DocumentFlowRes : Codable {
    let success : Bool
    let error : LastError?
}

//ADDRESS_FLOW_RES
struct AddressFlowRes : Codable {
    let success : Bool
    let uuid : String?
    let error : LastError?
}

//DUE_DILIGENCE_CREATE_RES
struct DueDiligenceCreateRes : Codable {
    let success : Bool
    let uuid : String?
    let error : LastError?
}

//AUTHORIZATION_FLOW_RES
struct DeviceAuthorozationFlowRes : Codable {
    let success : Bool
    let uuid : String?
    let error : LastError?
    let data : DeviceAuthorozationFlowResData?
}
public struct DeviceAuthorozationFlowResData : Codable {
    //TODO
}

//AUTHORIZATION_DEVICE_NEW
struct AuthorizationDeviceNew : Codable {
    let success : Bool
    let error : LastError?
    let data : AuthorizationDeviceNewData?
}
public struct AuthorizationDeviceNewData : Codable, Equatable {
    public let id : String?
    public let deviceInfo : DeviceInfo?
    
    public static func == (lhs: AuthorizationDeviceNewData, rhs: AuthorizationDeviceNewData) -> Bool {
        if lhs.id != rhs.id {
            return false
        }
        if lhs.deviceInfo != rhs.deviceInfo {
            return false
        }
        return true
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case deviceInfo = "deviceInfo"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decode(String.self, forKey: .id)
        if let deviceInfoStr = try? values.decode(String.self, forKey: .deviceInfo), let data = deviceInfoStr.data(using: .utf8) {
            deviceInfo = try? JSONDecoder().decode(DeviceInfo.self, from: data)
        } else {
            deviceInfo = nil
        }
    }
}

//AUTHORIZATION_REQUEST_LIST_RES
struct AuthorizationRequestListRes : Codable {
    let success : Bool
    let error : LastError?
    let data : [AuthorizationDeviceNewData]?
}

//AUTHORIZATION_REQUEST_REQ
struct AuthorizationRequestReq : Codable {
    let success : Bool
    let data : AuthorizationRequestReqData?
    let error : LastError?
}
//AUTHORIZATION_REQUEST_REQ_DATA
public struct AuthorizationRequestReqData : Codable {
    public let id : String
    public let status : String
}

//AUTHORIZATION_DEVICE_LIST_RES
struct AuthorizationDeviceListRes : Codable {
    let success : Bool
    let uuid : String
    let error : LastError?
    let devices : [DeviceEntity]?
}

//RECOVERY_REQUEST_RES
struct RecoveryRequestRes : Codable {
    let success : Bool
    let uuid : String
    let error : String?
}

//IDENTITY_GET_RES
struct IdentityGetRes : Codable {
    let success : Bool
    let uuid : String?
    let data : IdentityGetResData?
    let error : ErrorRes?
}

public struct IdentityGetResData : Codable {
    public let identityId: String
    public let proofs: [IProof]
    public let phoneStatus: ProofStatus
    public let documentStatus: ProofStatus
    public let addressStatus: ProofStatus
    public let emailStatus: ProofStatus
    public let dueDiligenceId: String?
    public let dueDiligenceStatus: ProofStatus
    public let amlStatus : ProofStatus
    public let riskScore : RiskScoreStatus
}

public enum ProofStatus : String, Codable {
    case SUCCESS
    case INIT
    case MANUAL
    case NONE = ""
    case FAIL
}

public enum RiskScoreStatus : String, Codable {
    case LOW
    case MEDIUM
    case HIGH
    case NONE = ""
}

public struct ErrorRes : Codable {
    public let code : Int
    
    public init(code: Int) {
        self.code = code
    }
}

//DEVICE_IDENTITY_GET_RES
struct DeviceIdentityGetRes : Codable {
    let success : Bool
    let uuid : String?
    let data : DeviceIdentityGetResData?
    let error : ErrorRes?
}

public struct DeviceIdentityGetResData : Codable {
    public let enrollmentId: String
    public let identityId: String
    public let proofs: [IProof]
}

public struct IProof : Codable {
    public let type: ProofType
    public let recovery: Bool
}

public enum ProofType : String, Codable {
    case PHONE
    case DOCUMENT
    case ADDRESS_CONFIRM
    case EMAIL
    case DUE_DILIGENCE
}

//COUNTRIES_GET_RES
struct CountriesGetRes : Codable {
    let success : Bool
    let uuid : String?
    let data : [Country]?
    let error : ErrorRes?
}

public struct Country : Codable {
    public let common: String
    public let official: String
    public let cca2: String
    public let ccn3: String
    public let cca3: String
    public let cioc: String
}
