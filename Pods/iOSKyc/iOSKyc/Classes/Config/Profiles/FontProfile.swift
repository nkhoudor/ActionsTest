//
//  FontProfile.swift
//  iOSKyc
//
//  Created by Nik on 26/02/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import UIKit

class FontProfile {
    let name: String
    let font: UIFont
    
    init(name: String, fontData: Data) {
        self.name = name

        let dataProvider = CGDataProvider(data: fontData as CFData)
        let cgFont = CGFont(dataProvider!)!

        var error: Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(cgFont, &error)
        
        let fontName = cgFont.postScriptName
        font = UIFont(name: fontName as! String, size: 30)!
    }
}
