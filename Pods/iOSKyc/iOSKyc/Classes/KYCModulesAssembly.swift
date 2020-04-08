//
//  KYCModulesAssembly.swift
//  iOSKyc
//
//  Created by Nik on 13/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import Swinject

public typealias KycFinishCallback = (() -> ())?

public class KYCModulesAssembly {
    
    public static let resolver: Swinject.Resolver = {
        let assembler = Assembler(KYCModulesAssembly.getModulesAssemblies())
        let _ = assembler.resolver.resolve(ScreenStateService.self)
        return assembler.resolver
    }()
    
    public static var kycFinishCallback: (() -> ())?
    
    class func getModulesAssemblies() -> [Assembly] {
        return [
            ConfigAssembly(),
            ServicesAssembly(),
            StateNavigatorAssembly(),
            PrivacyPolicyAssembly(),
            PhoneRegistrationAssembly(),
            EnterSmsCodeAssembly(),
            CreatePinCodeAssembly(),
            ReenterPinCodeAssembly(),
            CheckPinCodeAssembly(),
            ChatAssembly(),
            TemplateFormAssembly(),
            EmailFormAssembly(),
            EmailCodeVerifyAssembly(),
            DevicesListAssembly(),
            NewDeviceAuthAssembly(),
            ErrorWarningInfoAssembly()
        ]
    }
}

