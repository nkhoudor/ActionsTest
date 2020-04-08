//
//  UserPhotoInteractor.swift
//
//  Created by Nik, 19/01/2020
//

import Foundation
import iOSKycViews

public class UserPhotoInteractor : UserPhotoInteractorProtocol {
    public var userPhotoMessage : UserPhotoMessageEntity
    
    public init(userPhotoMessage : UserPhotoMessageEntity) {
        self.userPhotoMessage = userPhotoMessage
    }
}
