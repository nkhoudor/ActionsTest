//
//  ListenEvent.swift
//  iOSBankingSDK
//
//  Created by Maxim MAMEDOV on 20.02.2020.
//

import Foundation

enum ListenEvent {
    
    case INIT_RES
    case GET_KEYS_REQ(GetKeysReq)
    case SET_ITEM_REQ(SetItemReq)
    case REMOVE_ITEM_REQ(RemoveItemReq)
    case GET_ITEM_REQ(GetItemReq)
    
    static func getListenEvent(name: String, data: String?) -> ListenEvent? {
        switch name {
        case "Core.Service.Init.Res":
            return .INIT_RES
        case "Storage.Service.GetKeys.Req":
            if let req = data?.decode(type: GetKeysReq.self) {
                return .GET_KEYS_REQ(req)
            }
        case "Storage.Service.SetItem.Req":
            if let req = data?.decode(type: SetItemReq.self) {
                return .SET_ITEM_REQ(req)
            }
        case "Storage.Service.RemoveItem.Req":
            if let req = data?.decode(type: RemoveItemReq.self) {
                return .REMOVE_ITEM_REQ(req)
            }
        case "Storage.Service.GetItem.Req":
            if let req = data?.decode(type: GetItemReq.self) {
                return .GET_ITEM_REQ(req)
            }
        default:
            return nil
        }
        return nil
    }
}

//GET_KEYS_REQ
struct GetKeysReq : Codable {
    let uuid : String
}

//SET_ITEM_REQ
struct SetItemReq : Codable {
    let uuid : String
    let data : KeyValue
}
struct KeyValue : Codable {
    let key : String
    let value : String
}

//REMOVE_ITEM_REQ
struct RemoveItemReq : Codable {
    let uuid : String
    let data : RemoveItemKey
}
struct RemoveItemKey : Codable {
    let key : String
}

//GET_ITEM_REQ
struct GetItemReq : Codable {
    let uuid : String
    let data : GetItemKey
}
struct GetItemKey : Codable {
    let key : String
}
