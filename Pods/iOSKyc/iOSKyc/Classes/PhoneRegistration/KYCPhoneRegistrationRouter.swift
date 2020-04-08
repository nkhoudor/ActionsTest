//
//  KYCPhoneRegistrationRouter.swift
//  iOSKyc
//
//  Created by Nik on 12/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import iOSKycViews
import Swinject
import RxSwift

class KYCPhoneRegistrationRouter : PhoneRegistrationRouterProtocol {
    func finish() {}
    
    var swipeVC : UIViewController!
    
    public var clearPhone: PublishSubject<Void> = PublishSubject()
    
    var resolver : Swinject.Resolver {
        KYCModulesAssembly.resolver
    }
    
    func restrictedCountry() {
        
        let interactor = RestrictedCountryPopupInteractor()
        interactor.changeNumber = { [weak self] in
            self?.clearPhone.onNext(())
        }
        
        let screenProfile = resolver.resolve(ScreenProfile.self, name: "UNAVAILABLE_COUNTRY_DIALOG")!
        let halfScreenModalStyleProfile = resolver.resolve(HalfScreenModalStyleProfile.self, name: "basicHalfScreenModal")
        
        let vcFactory = {
            RestrictedCountryPopupVC.createInstance(presenter: RestrictedCountryPopupPresenter(interactor: interactor, router: RestrictedCountryPopupRouter(), configurator: RestrictedCountryConfigurator(screenProfile: screenProfile)))
            
        }
        swipeVC = HalfSceenModalVC.createInstance(configurator: HalfSceenModalConfigurator(titleLabelFactory: screenProfile.getLabelFactory("HEADER"), titleUnderlineFactory: screenProfile.getLineFactory("HEADER_UNDERLINE"), halfScreenModalStyleProfile: halfScreenModalStyleProfile), presentingVCFactory: vcFactory, baseVC: resolver.resolve(UINavigationController.self)!.visibleViewController!)
        swipeVC.modalPresentationStyle = .overCurrentContext
        swipeVC.modalTransitionStyle = .coverVertical
        resolver.resolve(UINavigationController.self)?.visibleViewController?.present(swipeVC!, animated: true, completion: nil)
        
    }
}
