//
//  MessageEntity.swift
//  iOSKyc
//
//  Created by Nik on 19/01/2020.
//  Copyright © 2020 Optherium. All rights reserved.
//

import RxRelay
import iOSBaseViews

public protocol MessageEntity {}

public protocol BotMessageEntity : MessageEntity {
    var avatarVisible : BehaviorRelay<Bool> { get }
}

public protocol BotLoadingMessageEntity : BotMessageEntity {
}

public protocol BotTextMessageEntity : BotMessageEntity {
    var text : BehaviorRelay<String> { get }
    var images: BehaviorRelay<[ConfigurationFactory<UIImageView>]> { get }
    var warningVisible : BehaviorRelay<Bool> { get }
    var isError : BehaviorRelay<Bool> { get }
}

public protocol UserTextMessageEntity : MessageEntity {
    var text : BehaviorRelay<String> { get }
}

public protocol UserPhotoMessageEntity : MessageEntity {
    var photo : BehaviorRelay<Data> { get }
    var name : BehaviorRelay<String> { get }
}

public protocol ActionMessageEntity : MessageEntity {
}

public protocol AddressInfoMessageEntity : MessageEntity {
    var form: TemplateFormConfigProtocol { get }
}

public protocol CongratulationsMessageEntity : MessageEntity {
    
}
