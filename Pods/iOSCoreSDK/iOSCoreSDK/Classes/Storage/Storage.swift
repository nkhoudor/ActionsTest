//
//  Storage.swift
//  iOSBankingSDK
//
//  Created by Maxim MAMEDOV on 20.02.2020.
//

import Foundation

public protocol IStorage {
    func set(_ value: String, forKey: String)
    func set(_ value: Bool, forKey: String)
    func removeObject(forKey: String)
    func string(forKey: String) -> String?
    func integer(forKey: String) -> Int?
    func bool(forKey: String) -> Bool
    var keys : [String] { get }
    func clear()
    func jwtData() -> JWTData?
    init()
}

public class Storage : IStorage {
    let storage = UserDefaults.standard //UserDefaults(suiteName: "sdk.optherium.com")!
    
    required public init() {}
    
    let prefix = "sdk.optherium.com_"
    
    func generateKey(_ forKey: String) -> String {
        return prefix + forKey
    }
    
    public func set(_ value: String, forKey: String) {
        storage.set(value, forKey: generateKey(forKey))
    }
    
    public func set(_ value: Bool, forKey: String) {
        storage.set(value, forKey: generateKey(forKey))
    }
    
    public func removeObject(forKey: String) {
        storage.removeObject(forKey: generateKey(forKey))
    }
    
    public func string(forKey: String) -> String? {
        return storage.string(forKey: generateKey(forKey))
    }
    
    public func integer(forKey: String) -> Int? {
        return storage.integer(forKey: forKey)
    }
    
    public func bool(forKey: String) -> Bool {
        return storage.bool(forKey: generateKey(forKey))
    }
    
    public var keys : [String] {
        return Array(storage.dictionaryRepresentation().keys.filter({ $0.contains(prefix) })).map({ $0.replacingOccurrences(of: prefix, with: "") })
    }
    
    public func clear() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
    }
    
    public func jwtData() -> JWTData? {
        let keys = self.keys
        let keyMatchingPrefix = keys.first { $0.starts(with: "OPTM-CORE-JWT_") }
        guard let key = keyMatchingPrefix,
            let jsonString = string(forKey: key),
            let data = jsonString.data(using: .utf8) else {
            return nil
        }
        return try? JSONDecoder().decode(JWTData.self, from: data)
    }
}
