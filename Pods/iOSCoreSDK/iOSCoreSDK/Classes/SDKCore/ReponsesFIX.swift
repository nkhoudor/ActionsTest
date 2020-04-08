//
//  ReponsesFIX.swift
//  iOSBankingSDK
//
//  Created by Maxim MAMEDOV on 20.02.2020.
//

import Foundation

//===========================================

// TO BE DELETED ONCE BACKEND WILL BE FIXED

//===========================================

extension Sequence where Element == Any {
    var fixed : [String] {
        var stringItems : [String] = []
        
        for item in self {
            if let fixedItem = (item as? String)?.fixed {
                stringItems.append(fixedItem)
            } else if let dict = item as? [String : Any] {
                if let dictData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted), let str = String(data: dictData, encoding: .utf8) {
                    stringItems.append(str)
                }
            } else {
                #if DEBUG
                    print("ALERT(NOT A STRING): \(item)")
                #endif
            }
        }
        
        return stringItems
    }
}

extension String {
    // TO BE DELETED ONCE BACKEND FIXED
    
    var fixed : String? {
        guard var dict = self.convertToDictionary() else { return nil }
        /*if let error = dict["error"], error is [String: Any] {
            if let errorData = try? JSONSerialization.data(withJSONObject: error, options: .prettyPrinted) {
                if let errorStr = String(data: errorData, encoding: .utf8) {
                    dict["error"] = errorStr
                }
            }
        }*/
        if let dictData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
            return String(data: dictData, encoding: .utf8)
        }
        return nil
    }
    
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
