//
//  CodableExtension.swift
//  iOSBankingSDK
//
//  Created by Maxim MAMEDOV on 20.02.2020.
//

import Foundation

struct NestedContainer<T: Decodable>: Decodable {
    let data: T
}

public extension Data {
    func decode<T: Decodable>(type _: T.Type, nestedInData: Bool = false) -> T? {
        if nestedInData {
            if let decoded = try? JSONDecoder().decode(NestedContainer<T>.self, from: self) {
                return decoded.data
            } else {
                #if DEBUG
                print("SDKCore: Unable to decode: \(T.self)\n\(self)")
                #endif
            }
            return nil
        }
        if let decoded = try? JSONDecoder().decode(T.self, from: self) {
            return decoded
        } else {
            #if DEBUG
            print("SDKCore: Unable to decode: \(T.self)\n\(self)")
            #endif
        }
        return nil
    }
}

public extension String {
    func decode<T: Decodable>(type _: T.Type, nestedInData: Bool = false) -> T? {
        guard let _data = self.data(using: .utf8) else {
            return nil
        }
        if nestedInData {
            if let decoded = try? JSONDecoder().decode(T.self, from: _data) {
                return decoded
            } else {
                #if DEBUG
                print("SDKCore: Unable to decode: \(T.self)\n\(self)")
                #endif
            }
            return nil
        }
        if let decoded = try? JSONDecoder().decode(T.self, from: _data) {
            return decoded
        } else {
            #if DEBUG
            print("SDKCore: Unable to decode: \(T.self)\n\(self)")
            #endif
        }
        return nil
    }
}

public extension Encodable {
    func toString() -> String? {
        guard let data = toJSONData() else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

public extension Encodable {
    func toJSONData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
