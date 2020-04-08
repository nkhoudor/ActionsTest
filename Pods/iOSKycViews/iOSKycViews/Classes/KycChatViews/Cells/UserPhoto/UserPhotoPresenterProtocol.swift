//
//  UserPhotoPresenterProtocol.swift
//
//  Created by Nik, 19/01/2020
//

import Foundation

public protocol UserPhotoPresenterProtocol {
    var configurator : UserPhotoConfiguratorProtocol { get }
    func viewDidLoad(view: UserPhotoViewProtocol)
    func imagePressed()
}
