//
//  SDKCore.swift
//  iOSBankingSDK
//
//  Created by Maxim MAMEDOV on 20.02.2020.
//

import Foundation
import SocketIO
import RxSwift
import RxRelay

public typealias Closure<T> = (T) -> Void

public protocol ISDKCore {
    var state : Observable<State> { get }
    var onEvent : Observable<(name: String, data: String)> { get }
    func push(_ event: EmitProtocol, ackCallback: Closure<Data?>?)
    func push(_ event: EmitProtocol, ackCallback: Closure<Data?>?, onlyWhenReady: Bool)
    func generateFlowId() -> String
    func reinit()
    func logout()
}

public enum SDKDestination {
    case kyc
    case banking
}

public class SDKCore : ISDKCore {
    var server : String!
    var config : SDKCoreConfig?
    var manager : SocketManager!
    var socket : SocketIOClient!
    let storage : IStorage!
    let sdkDestination: SDKDestination

    let _state : BehaviorRelay<State> = BehaviorRelay.init(value: .NO_STATE)
    public var state : Observable<State> {
        return _state.asObservable()
    }
    
    let _onEvent : PublishSubject<(name: String, data: String)> = PublishSubject()
    public var onEvent : Observable<(name: String, data: String)> {
        return _onEvent.asObservable()
    }
    
    private let disposeBag = DisposeBag()
    
    public init(storage: IStorage, sdkDestination: SDKDestination = .kyc) {
        self.storage = storage
        self.sdkDestination = sdkDestination
    }
    
    func connect() {
        guard let serverURL = URL(string: server) else { return }
        manager = SocketManager(socketURL: serverURL, config: [.log(false), .compress, .forceWebsockets(true), .extraHeaders(["User-Agent" : UAString()])])
        socket = manager.defaultSocket
        
        socket.on(clientEvent: .connect) {[weak self] data, ack in
            self?.onReady()
        }
        
        socket.on(clientEvent: .error) {[weak self] data, ack in
            self?._state.accept(.INIT_FAIL(error: (data.first as? String)))
        }
        
        socket.onAny {[weak self] event in
            #if DEBUG
                print("SDKCore: \(event.event)")
            #endif
            
            let items : [String] = event.items?.fixed ?? [""]
            
            for item in items {
                self?._onEvent.onNext((name: event.event, data: item))
                guard let listenEvent = ListenEvent.getListenEvent(name: event.event, data: item) else { continue }
                self?.onListenEvent(listenEvent)
            }
        }
        socket.connect()
    }
    
    func onListenEvent(_ listenEvent: ListenEvent) {
        switch listenEvent {

        case .INIT_RES:
            receivedInitRes()

        case .GET_KEYS_REQ(let req):
            receivedGetKeysReq(req)

        case .SET_ITEM_REQ(let req):
            receivedSetItemReq(req)

        case .REMOVE_ITEM_REQ(let req):
            receivedRemoveItemReq(req)

        case .GET_ITEM_REQ(let req):
            receivedGetItemReq(req)
        }
    }
    
    func onReady() {
        _state.accept(.INIT_START)
        push(EmitEvent.PING, ackCallback: nil)
        switch sdkDestination {
        case .kyc:
            guard let config = config else {
                fatalError("SDKCoreConfig is empty, but it is required")
            }
            push(EmitEvent.INIT_REQ(uuid: generateFlowId(), config: config), ackCallback: nil)
        case .banking:
            guard let authData = storage.jwtData() else {
                fatalError("Auth data is empty, but it is required")
            }
            push(EmitEvent.AUTH(jwt: authData.token)) { [weak self] (ackData) in
                self?.receivedInitRes()
            }
        }
    }
    
    public func reinit() {
        onReady()
    }
    
    func receivedSetItemReq(_ req: SetItemReq) {
        storage.set(req.data.value, forKey: req.data.key)
        push(EmitEvent.SET_ITEM_RES(uuid: req.uuid, success: true), ackCallback: nil)
    }

    func receivedRemoveItemReq(_ req: RemoveItemReq) {
        storage.removeObject(forKey: req.data.key)
        push(EmitEvent.REMOVE_ITEM_RES(uuid: req.uuid, success: true), ackCallback: nil)
    }

    func receivedGetKeysReq(_ req: GetKeysReq) {
        push(EmitEvent.GET_KEYS_RES(uuid: req.uuid, success: true, data: storage.keys), ackCallback: nil)
    }

    func receivedGetItemReq(_ req: GetItemReq) {
        let value = storage.string(forKey: req.data.key)
        push(EmitEvent.GET_ITEM_RES(uuid: req.uuid, success: value != nil, value: value), ackCallback: nil)
    }

    func receivedInitRes() {
        _state.accept(.INIT_SUCCESS)
    }
    
    public func logout() {
        push(EmitEvent.LOGOUT, ackCallback: nil)
        storage.clear()
    }
    
    public func generateFlowId() -> String {
        return UUID().uuidString
    }
    
    public func push(_ event: EmitProtocol, ackCallback: Closure<Data?>?, onlyWhenReady: Bool) {
        if onlyWhenReady {
            switch _state.value {
            case .INIT_SUCCESS:
                push(event, ackCallback: ackCallback, onlyWhenReady: false)
            default:
                #if DEBUG
                    print("SDKCore is not ready, waiting...")
                #endif
                _ = state.subscribe { [weak self] _ in
                    self?.push(event, ackCallback: ackCallback, onlyWhenReady: true)
                }.disposed(by: disposeBag)
            }
        }
        #if DEBUG
            print("SDKCore: pushed \(event.emit.name)")
        #endif
        var message: SocketData?
        switch sdkDestination {
        case .banking:
            if let stringData = event.emit.data as? String {
                message = stringData
            } else {
                message = event.emit.data?.toString()
            }
        case .kyc:
            if let data = event.emit.data?.toJSONData() {
                message = [data]
            } else {
                message = []
            }
        }
        socket.emitWithAck(event.emit.name, message ?? "{}").timingOut(after: 15, callback: { result in
            guard let callback = ackCallback, var lastObject = result.last else {
                ackCallback?(nil)
                return
            }
            if let data = lastObject as? [String : Any] {
                lastObject = (try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)) ?? Data()
            }
            if let dataObject = lastObject as? Data {
                callback(dataObject)
            } else if let stringObject = lastObject as? String {
                callback(stringObject.data(using: .utf8))
            } else {
                callback(nil)
            }
        })
    }
    
    public func push(_ event: EmitProtocol, ackCallback: Closure<Data?>?) {
        push(event, ackCallback: ackCallback, onlyWhenReady: false)
    }
}

extension SDKCore : SDKCoreConfigurable {
    public func configure(server: String, config: SDKCoreConfig?) {
        self.server = server
        self.config = config
        connect()
    }
}
