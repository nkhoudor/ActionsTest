//
//  State.swift
//  iOSBankingSDK
//
//  Created by Maxim MAMEDOV on 20.02.2020.
//

import Foundation

public enum State {
    case NO_STATE
    case INIT_START
    case INIT_SUCCESS
    case INIT_FAIL(error: String?)
}
