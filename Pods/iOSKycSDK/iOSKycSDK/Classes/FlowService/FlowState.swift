//
//  FlowState.swift
//  CoreStore
//
//  Created by Nik on 26/12/2019.
//

import Foundation

public enum FlowState {
    case NO_STATE
    //PHONE
    case REGISTRATION_PHONE_START
    case REGISTRATION_PHONE_SUBMIT(RegistrationPhoneSubmitRes)
    case REGISTRATION_PHONE_FLOW_RESULT(RegistrationPhoneFlowResult)
    case REGISTRATION_PHONE_SUBMIT_SOLUTION(RegistrationPhoneSubmitSolution)
    
    //EMAIL
    case REGISTRATION_EMAIL_FLOW_RESULT(RegistrationEmailFlowResult)
    case REGISTRATION_EMAIL_SUBMIT_SOLUTION(RegistrationEmailSubmitSolution)
    
    //DOCUMENT
    case REGISTRATION_DOCUMENT_FLOW_RESULT(RegistrationDocumentFlowResult)
    
    //ADDRESS
    case REGISTRATION_ADDRESS_FLOW_RESULT(RegistrationAddressFlowResult)
    
    //DUE DILIGENCE
    case DUE_DILIGENCE_FLOW_RESULT(DueDiligenceFlowResult)
    
    //AUTHORIZATION
    case DEVICE_AUTHORIZATION_FLOW_RESULT(DeviceAuthorizationFlowResult)
    case AUTHORIZATION_DEVICE_NEW(AuthorizationDeviceNewResult)
    case AUTHORIZATION_REQUEST_LIST_RES(AuthorizationRequestListResult)
    case DEVICE_AUTHORIZATION_RESULT(DeviceAuthorizationResult)
    case AUTHORIZATION_DEVICE_LIST_RESULT(AuthorizationDeviceListResult)
    
    //RECOVERY
    case RECOVERY_REQUEST_RESULT(RecoveryRequestResult)
    
    //IDENTITY
    case IDENTITY_REQUEST_RESULT(IdentityRequestResult)
    case DEVICE_IDENTITY_REQUEST_RESULT(DeviceIdentityRequestResult)
    
    //COUNTRIES
    case COUNTRIES_REQUEST_RESULT(CountriesRequestResult)
    
    //WATCHERS
    case DOCUMENT_PROCESSED
    case ADDRESS_PROCESSED
    case AML_PROCESSED
}

//REGISTRATION_PHONE_FLOW_RESULT
public enum RegistrationPhoneFlowResult {
    case success(data: PhoneFlowResData)
    case failure(error: LastError?)
}

//REGISTRATION_PHONE_SUBMIT
public enum RegistrationPhoneSubmitRes {
    case success(uuid: String, data: PhoneSubmitPhoneReqData)
    case failure(uuid: String, error: String)
}

//REGISTRATION_PHONE_SUBMIT_SOLUTION
public enum RegistrationPhoneSubmitSolution {
    case success(uuid: String, data: PhoneSubmitCodeReqData)
    case failure(uuid: String, error: LastError?)
}

//REGISTRATION_EMAIL_FLOW_RESULT
public enum RegistrationEmailFlowResult {
    case success(data: EmailFlowResData?)
    case failure(error: LastError?)
}


//REGISTRATION_EMAIL_SUBMIT_SOLUTION
public enum RegistrationEmailSubmitSolution {
    case success(uuid: String, data: EmailSubmitCodeReqData?)
    case failure(uuid: String, error: String)
}

//REGISTRATION_DOCUMENT_FLOW_RESULT
public enum RegistrationDocumentFlowResult {
    case success(error: LastError?)
    case failure(error: LastError?)
}

//REGISTRATION_ADDRESS_FLOW_RESULT
public enum RegistrationAddressFlowResult {
    case success(uuid: String)
    case failure(error: LastError?)
}

//REGISTRATION_ADDRESS_FLOW_RESULT
public enum DeviceAuthorizationFlowResult {
    case success(uuid: String, data: DeviceAuthorozationFlowResData?)
    case failure(error: LastError?)
}

//DUE_DILIGENCE_FLOW_RESULT
public enum DueDiligenceFlowResult {
    case success(uuid: String?)
    case failure(error: LastError?)
}

//AUTHORIZATION_DEVICE_NEW
public enum AuthorizationDeviceNewResult {
    case success(data: AuthorizationDeviceNewData)
    case failure(error: LastError?)
}

//AUTHORIZATION_REQUEST_LIST_RES
public enum AuthorizationRequestListResult {
    case success(data: [AuthorizationDeviceNewData])
    case failure(error: LastError?)
}

//DEVICE_AUTHORIZATION_RESULT
public enum DeviceAuthorizationResult {
    case success(data: AuthorizationRequestReqData)
    case failure(error: LastError?)
}

//AUTHORIZATION_DEVICE_LIST_RESULT
public enum AuthorizationDeviceListResult {
    case success(uuid: String, devices: [DeviceEntity]?)
    case failure(error: LastError?)
}

//RECOVERY_REQUEST_RESULT
public enum RecoveryRequestResult {
    case success(uuid: String)
    case failure(error: String)
}

//IDENTITY_REQUEST_RESULT
public enum IdentityRequestResult {
    case success(uuid: String?, data: IdentityGetResData)
    case failure(error: ErrorRes?)
}

//DEVICE_IDENTITY_REQUEST_RESULT
public enum DeviceIdentityRequestResult {
    case success(uuid: String?, data: DeviceIdentityGetResData)
    case failure(error: ErrorRes?)
}

//COUNTRIES_REQUEST_RESULT
public enum CountriesRequestResult {
    case success(uuid: String?, data: [Country])
    case failure(error: ErrorRes?)
}
