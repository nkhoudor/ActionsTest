//
//  StyleConfigModule.swift
//  iOSKyc
//
//  Created by Nik on 26/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import SwiftyJSON
import Swinject

class StyleConfigModule : ConfigModule {
    override func register(from source: JSON, container: Container, objectScope: ObjectScope) {
        super.register(from: source, container: container, objectScope: objectScope)
        for styleJSON in source["value"].arrayValue {
            print("STYLE\(styleJSON["type"].string!)")
            switch styleJSON["type"].string! {
            case "text":
                let name = styleJSON["name"].string!
                
                let factory : (Resolver) -> (TextStyleProfile) = { resolver in
                    let colorProfileName = styleJSON["color"].string!
                    let fontProfileName = styleJSON["font"].string!
                    let fontSize = styleJSON["size"].int!
                    
                    let colorProfile = resolver.resolve(ColorProfile.self, name: colorProfileName)!
                    
                    let fontProfile = resolver.resolve(FontProfile.self, name: fontProfileName)!
                    
                    return TextStyleProfile(name: name, colorProfile: colorProfile, fontProfile: fontProfile, size: fontSize)
                }
                container.register(TextStyleProfile.self, name: name, factory: factory).inObjectScope(objectScope)
                
            case "primary_button":
                let name = styleJSON["name"].string!
                
                let factory : (Resolver) -> (ButtonStyleProfile) = { resolver in
                    
                    let fontSize = styleJSON["size"].int!
                    let cornerRadius = styleJSON["cornerRadius"].float!
                    
                    let textColorProfile = resolver.resolve(ColorProfile.self, name: styleJSON["textColor"].string!)!
                    
                    let fontProfile = resolver.resolve(FontProfile.self, name: styleJSON["font"].string!)!
                    
                    let buttonColorProfile = resolver.resolve(ColorProfile.self, name: styleJSON["buttonColor"].string!)!
                    
                    let shadowColorProfile = resolver.resolve(ColorProfile.self, name: styleJSON["shadowColor"].string!)!
                    
                    let successColorProfile = resolver.resolve(ColorProfile.self, name: styleJSON["successColor"].string!)!
                    
                    let successShadowColorProfile = resolver.resolve(ColorProfile.self, name: styleJSON["successShadowColor"].string!)!
                    
                    return PrimaryButtonStyleProfile(name: name, fontProfile: fontProfile, size: fontSize, textColorProfile: textColorProfile, buttonColorProfile: buttonColorProfile, shadowColorProfile: shadowColorProfile, successColorProfile: successColorProfile, successShadowColorProfile: successShadowColorProfile, cornerRadius: CGFloat(cornerRadius))
                }
                container.register(ButtonStyleProfile.self, name: name, factory: factory).inObjectScope(objectScope)
                
            case "button":
                let name = styleJSON["name"].string!
                
                let factory : (Resolver) -> (ButtonStyleProfile) = { resolver in
                    
                    let fontSize = styleJSON["size"].int!
                    let cornerRadius = styleJSON["cornerRadius"].float!
                    
                    let textColorProfile = resolver.resolve(ColorProfile.self, name: styleJSON["textColor"].string!)!
                    
                    let fontProfile = resolver.resolve(FontProfile.self, name: styleJSON["font"].string!)!
                    
                    let buttonColorProfile = resolver.resolve(ColorProfile.self, name: styleJSON["buttonColor"].string!)!
                    
                    
                    return ButtonStyleProfile(name: name, fontProfile: fontProfile, size: fontSize, textColorProfile: textColorProfile, buttonColorProfile: buttonColorProfile, cornerRadius: CGFloat(cornerRadius))
                }
                container.register(ButtonStyleProfile.self, name: name, factory: factory).inObjectScope(objectScope)
                
            case "line":
                let name = styleJSON["name"].string!
                
                let factory : (Resolver) -> (LineStyleProfile) = { resolver in
                    let thickness = CGFloat(styleJSON["thickness"].float!)
                    let cornerRadius = CGFloat(styleJSON["cornerRadius"].float!)
                    
                    let colorProfile = resolver.resolve(ColorProfile.self, name: styleJSON["color"].string!)!
                    
                    
                    return LineStyleProfile(name: name, colorProfile: colorProfile, thickness: thickness, cornerRadius: cornerRadius)
                }
                container.register(LineStyleProfile.self, name: name, factory: factory).inObjectScope(objectScope)
                
            case "halfScreenModalStyle":
                let name = styleJSON["name"].string!
                
                let factory : (Resolver) -> (HalfScreenModalStyleProfile) = { resolver in
                    let coverRatio = CGFloat(styleJSON["coverRatio"].float!)
                    let cornerRadius = CGFloat(styleJSON["cornerRadius"].float!)
                    
                    let backgroundColorProfile = resolver.resolve(ColorProfile.self, name: styleJSON["backgroundColor"].string!)!
                    let coverColorProfile = resolver.resolve(ColorProfile.self, name: styleJSON["coverColor"].string!)!
                    let topArrowAssetProfile = resolver.resolve(AssetProfile.self, name: styleJSON["topArrowAsset"].string!)!
                    
                    
                    return HalfScreenModalStyleProfile(name: name, backgroundColorProfile: backgroundColorProfile, coverColorProfile: coverColorProfile, coverRatio: coverRatio, cornerRadius: cornerRadius, topArrowAssetProfile: topArrowAssetProfile)
                }
                container.register(HalfScreenModalStyleProfile.self, name: name, factory: factory).inObjectScope(objectScope)
            case "numTextFieldStyle":
                let name = styleJSON["name"].string!
                container.register(NumTextFieldStyleProfile.self, name: name, factory: { resolver -> NumTextFieldStyleProfile in
                    return NumTextFieldStyleProfile(from: styleJSON, resolver: resolver)
                }).inObjectScope(objectScope)
                
            case "pinCodeDot":
                let name = styleJSON["name"].string!
                container.register(PinCodeDotStyleProfile.self, name: name, factory: { resolver -> PinCodeDotStyleProfile in
                    return PinCodeDotStyleProfile(from: styleJSON, resolver: resolver)
                }).inObjectScope(objectScope)
                
            case "pinCodeDigitButton":
                let name = styleJSON["name"].string!
                container.register(PinCodeDigitButtonStyleProfile.self, name: name, factory: { resolver -> PinCodeDigitButtonStyleProfile in
                    return PinCodeDigitButtonStyleProfile(from: styleJSON, resolver: resolver)
                }).inObjectScope(objectScope)
                
            case "switch":
                let name = styleJSON["name"].string!
                container.register(SwitchStyleProfile.self, name: name, factory: { resolver -> SwitchStyleProfile in
                    return SwitchStyleProfile(from: styleJSON, resolver: resolver)
                }).inObjectScope(objectScope)
                
            default:
                ()
            }
            
        }
    }
}
