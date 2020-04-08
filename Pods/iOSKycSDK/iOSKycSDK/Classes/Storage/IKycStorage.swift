//
//  IKycStorage.swift
//  iOSKycSDK
//
//  Created by Admin on 10/03/2020.
//

import iOSCoreSDK

public protocol IKycStorage : IStorage {
    var isRecoveryMode : Bool { get set }
    var pinHash : String? { get set }
    var isPPConfirmed : Bool { get set }
    var phoneProvided : Bool { get set }
    var wrongCountry : Bool { get set }
    var wrongAge : Bool { get set }
    var emailDenied : Bool { get set }
}

extension Storage : IKycStorage {
    public var isRecoveryMode: Bool {
        get {
            return bool(forKey: "isRecoveryMode")
        }
        set(newValue) {
            set(newValue, forKey: "isRecoveryMode")
        }
    }
    
    public var pinHash: String? {
        get {
            return string(forKey: "pinHash")
        }
        set(newValue) {
            if newValue != nil {
                set(newValue!, forKey: "pinHash")
            } else {
                removeObject(forKey: "pinHash")
            }
        }
    }
    
    public var isPPConfirmed: Bool {
        get {
            return bool(forKey: "isPPConfirmed")
        }
        set(newValue) {
            set(newValue, forKey: "isPPConfirmed")
        }
    }
    
    
    public var phoneProvided: Bool {
        get {
            return bool(forKey: "phoneProvided")
        }

        set(newValue) {
            set(newValue, forKey: "phoneProvided")
        }
    }

    public var wrongCountry: Bool {
        get {
            return bool(forKey: "wrongCountry")
        }

        set(newValue) {
            set(newValue, forKey: "wrongCountry")
        }
    }

    public var wrongAge: Bool {
        get {
            return bool(forKey: "wrongAge")
        }

        set(newValue) {
            set(newValue, forKey: "wrongAge")
        }
    }
    
    public var emailDenied: Bool {
        get {
            return bool(forKey: "emailDenied")
        }
        set(newValue) {
            set(newValue, forKey: "emailDenied")
        }
    }
}
