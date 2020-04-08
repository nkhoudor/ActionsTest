//
//  UserPhotoVC.swift
//  Vivex
//
//  Created by Nik, 19/01/2020
//

import Foundation
import UIKit

public class UserPhotoVC : UIViewController, UserPhotoViewProtocol {
    var presenter : UserPhotoPresenterProtocol!
    
    private var mainView: UserPhotoView {
        return view as! UserPhotoView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
    }
    
    public override func loadView() {
        view = UserPhotoView(configurator: presenter.configurator)
        mainView.clickableArea.addTarget(self, action: #selector(imagePressed), for: .touchUpInside)
    }
    
    @objc func imagePressed() {
        presenter.imagePressed()
    }
    
    public func update(photoData: Data) {
        mainView.photoImageView.image = UIImage(data: photoData)
    }
    
    public class func createInstance(presenter : UserPhotoPresenterProtocol) -> UserPhotoVC {
        let instance = UserPhotoVC()
        instance.presenter = presenter
        return instance
    }
}
