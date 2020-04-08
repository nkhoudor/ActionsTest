//
//  FlowEmitEvent.swift
//  CoreStore
//
//  Created by Nik on 26/12/2019.
//

import Foundation
import iOSCoreSDK

enum FlowEmitEvent : EmitProtocol {
    
    // Registration
    case REGISTRATION_PHONE_FLOW_REQ(RegistrationPhoneFlowReq)
    case REGISTRATION_PHONE_SUBMIT_CODE_RES(RegistrationPhoneSubmitCodeRes)
    case REGISTRATION_PHONE_RESEND_CODE_REQ(RegistrationPhoneResendCodeReq)
    
    //Email
    case REGISTRATION_EMAIL_FLOW_REQ(RegistrationEmailFlowReq)
    case REGISTRATION_EMAIL_SUBMIT_CODE_RES(RegistrationEmailSubmitCodeRes)
    case REGISTRATION_EMAIL_RESEND_CODE_REQ(RegistrationEmailResendCodeReq)
    
    // Document
    case REGISTRATION_DOCUMENT_FLOW_REQ(RegistrationDocumentFlowReq)
    
    // Address
    case REGISTRATION_ADDRESS_FLOW_REQ(RegistrationAddressFlowReq)

    // Due Diligence
    case REGISTRATION_DUE_DILIGENCE_REQ(RegistrationDueDiligenceReq)

    // Recovery Request
    case RECOVERY_REQUEST_REQ(RecoveryRequestReq)
    
    // Device authorization
    case AUTHORIZATION_FLOW_REQ(AuthorizationFlowReq)
    case AUTHORIZATION_REQUEST_RES(AuthorizationRequestRes)
    case AUTHORIZATION_DEVICE_LIST_REQ(AuthorizationDeviceListReq)
    case AUTHORIZATION_REQUEST_LIST_REQ(AuthorizationRequestListReq)
    
    //Get Identity
    case IDENTITY_GET_REQ(IdentityGetReq)
    case DEVICE_IDENTITY_GET_REQ(DeviceIdentityGetReq)
    
    //Get Countries
    case COUNTRIES_GET_REQ(CountriesGetReq)
    
    var emit : (name: String, data: Codable?) {
        switch self {
            
        case .REGISTRATION_PHONE_FLOW_REQ(let req):
            return (name: "Registration.App.Flow.Req", req)
            
        case .REGISTRATION_PHONE_SUBMIT_CODE_RES(let req):
            return (name: "Registration.App.SubmitCode.Res", data: req)
            
        case .REGISTRATION_PHONE_RESEND_CODE_REQ(let req):
            return (name: "Registration.App.ResendCode.Req", data: req)
            
        case .REGISTRATION_EMAIL_FLOW_REQ(let req):
            return (name: "Email.App.Flow.Req", data: req)
            
        case .REGISTRATION_EMAIL_SUBMIT_CODE_RES(let req):
            return (name: "Email.App.SubmitCode.Res", data: req)
        
        case .REGISTRATION_EMAIL_RESEND_CODE_REQ(let req):
            return (name: "Email.App.ResendCode.Req", data: req)
            
        case .REGISTRATION_DOCUMENT_FLOW_REQ(let req):
            return (name: "Document.App.Flow.Req", data: req)
            
        case .REGISTRATION_ADDRESS_FLOW_REQ(let req):
            return (name: "Address.App.Flow.Req", data: req)
            
        case .REGISTRATION_DUE_DILIGENCE_REQ(let req):
            return (name: "Kyc.App.Due.Diligence.Create.Req", data: req)
            
        case .RECOVERY_REQUEST_REQ(let req):
            return (name: "Recovery.App.Request.Req", data: req)
            
        case .AUTHORIZATION_FLOW_REQ(let req):
            return (name: "Authorization.App.Flow.Req", data: req)
        
        case .AUTHORIZATION_REQUEST_RES(let req):
            return (name: "Authorization.App.Request.Res", data: req)
        
        case .AUTHORIZATION_DEVICE_LIST_REQ(let req):
            return (name: "Authorization.Device.List.Req", data: req)
            
        case .AUTHORIZATION_REQUEST_LIST_REQ(let req):
            return (name: "Authorization.App.Request.List.Req", data: req)
            
        case .IDENTITY_GET_REQ(let req):
            return (name: "State.App.Identity.Get.Req", data: req)
            
        case .DEVICE_IDENTITY_GET_REQ(let req):
            return (name: "State.App.Device.Get.Req", data: req)
            
        case .COUNTRIES_GET_REQ(let req):
            return (name: "Kyc.App.Countries.Get.Req", data: req)
        }
    }
}

//REGISTRATION_PHONE_FLOW_REQ
struct RegistrationPhoneFlowReq : Codable {
    let uuid : String
    let phoneNumber : String
    let mainDeviceInfo : String
}

//REGISTRATION_PHONE_SUBMIT_CODE_RES
struct RegistrationPhoneSubmitCodeRes : Codable {
    let uuid : String
    let data : String
}

//REGISTRATION_PHONE_RESEND_CODE_REQ
struct RegistrationPhoneResendCodeReq : Codable {
    let uuid : String
}

//REGISTRATION_EMAIL_FLOW_REQ
struct RegistrationEmailFlowReq : Codable {
    let uuid : String
    let data : RegistrationEmailFlowReqData
}
struct RegistrationEmailFlowReqData : Codable {
    let isRecovery : Bool
    let emailAddress : String?
    let isAgree : Bool?
    let transactionId : String
}

//REGISTRATION_EMAIL_SUBMIT_CODE_RES
struct RegistrationEmailSubmitCodeRes : Codable {
    let uuid : String
    let data : String
}

//REGISTRATION_EMAIL_RESEND_CODE_REQ
struct RegistrationEmailResendCodeReq : Codable {
    let uuid : String
}

//REGISTRATION_DOCUMENT_FLOW_REQ
struct RegistrationDocumentFlowReq : Codable {
    let uuid : String
    let data : RegistrationDocumentFlowReqData
}
struct RegistrationDocumentFlowReqData : Codable {
    let documentType : DocumentType
    let isRecovery : Bool
    let documentImages : DocumentImages
}
struct DocumentImages : Codable {
    let frontImageFile : String? //Data
    let backImageFile : String? //Data
    let faceImageFile : String? //Data
}

//REGISTRATION_ADDRESS_FLOW_REQ
struct RegistrationAddressFlowReq : Codable {
    let uuid : String
    let data : RegistrationAddressFlowReqData
}
struct RegistrationAddressFlowReqData : Codable {
    let addressData : [String: String]
    let addressImages : [String]
}

//REGISTRATION_DUE_DILIGENCE_REQ
struct RegistrationDueDiligenceReq : Codable {
    let uuid : String
    let data : RegistrationDueDiligenceReqData
}
struct RegistrationDueDiligenceReqData : Codable {
    let data : [String: String]
}

//RECOVERY_REQUEST_REQ
struct RecoveryRequestReq : Codable {
    let uuid : String
}

//AUTHORIZATION_FLOW_REQ
struct AuthorizationFlowReq : Codable {
    let uuid : String
}

//AUTHORIZATION_REQUEST_RES
struct AuthorizationRequestRes : Codable {
    let uuid : String
    let data : AuthorizationRequestResData
}
struct AuthorizationRequestResData : Codable {
    let authRequestId : String
    let action : AuthorizationAction
}

//AUTHORIZATION_DEVICE_LIST_REQ
struct AuthorizationDeviceListReq : Codable {
    let uuid : String
}

//AUTHORIZATION_REQUEST_LIST_REQ
struct AuthorizationRequestListReq : Codable {
    let uuid : String
}

//IDENTITY_GET_REQ
struct IdentityGetReq : Codable {
    let uuid : String
}

//DEVICE_IDENTITY_GET_REQ
struct DeviceIdentityGetReq : Codable {
    let uuid : String
}

//COUNTRIES_GET_REQ
struct CountriesGetReq : Codable {
    let uuid : String
}
