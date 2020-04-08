//
//  Device.swift
//  CoreStore
//
//  Created by Nik on 26/12/2019.
//

import Foundation

public struct DeviceEntity : Codable {
    public let fileId : String?
    public let enrollmentId : String?
    public let createdAt : String?
    public let deviceInfo : DeviceInfo?
    
    enum CodingKeys: String, CodingKey {
        case fileId = "fileId"
        case enrollmentId = "enrollmentId"
        case createdAt = "createdAt"
        case deviceInfo = "deviceInfo"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fileId = try? values.decode(String.self, forKey: .fileId)
        enrollmentId = try? values.decode(String.self, forKey: .enrollmentId)
        createdAt = try? values.decode(String.self, forKey: .createdAt)
        if let deviceInfoStr = try? values.decode(String.self, forKey: .deviceInfo), let data = deviceInfoStr.data(using: .utf8) {
            deviceInfo = try? JSONDecoder().decode(DeviceInfo.self, from: data)
        } else {
            deviceInfo = nil
        }
    }
}

public struct DeviceInfo : Codable, Equatable {
    public let deviceType : DeviceType?
    public let model : String?
    public let device : String?
    
    public static func == (lhs: DeviceInfo, rhs: DeviceInfo) -> Bool {
        if lhs.model != rhs.model {
            return false
        }
        if lhs.device != rhs.device {
            return false
        }
        if lhs.deviceType != rhs.deviceType {
            return false
        }
        return true
    }
}

public enum DeviceType : String, Codable {
    case android
    case ios
    case mobile
    case pc
}
