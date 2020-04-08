//
//  AssetProfile.swift
//  iOSKyc
//
//  Created by Nik on 26/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import iOSBaseViews
import Kingfisher

class AssetProfile {
    let id: String
    let x2: String
    let x3: String
    
    init(id: String, x2: String, x3: String) {
        self.id = id
        self.x2 = x2
        self.x3 = x3
    }
    
    func getAssetConfigurationFactory() -> ConfigurationFactory<UIImageView> {
        let factory : ConfigurationFactory<UIImageView> = {[weak self] imageView in
            guard let x2 = self?.x2, let x3 = self?.x3 else { return }
            switch UIScreen.main.scale {
            case 2.0:
                imageView.kf.setImage(with: URL(string: x2), options: [.scaleFactor(2.0)])
            case 3.0:
                imageView.kf.setImage(with: URL(string: x3), options: [.scaleFactor(3.0)])
            default:
                ()
            }
            
        }
        return factory
    }
    
    func getAssetConfigurationFactory() -> ConfigurationFactory<UIButton> {
        let factory : ConfigurationFactory<UIButton> = {[weak self] button in
            guard let x2 = self?.x2, let x3 = self?.x3 else { return }
            switch UIScreen.main.scale {
            case 2.0:
                button.kf.setImage(with: URL(string: x2), for: .normal, options: [.scaleFactor(2.0)])
            case 3.0:
                button.kf.setImage(with: URL(string: x3), for: .normal, options: [.scaleFactor(3.0)])
            default:
                ()
            }
            
        }
        return factory
    }
}
