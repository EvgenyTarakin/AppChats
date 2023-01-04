//
//  Message.swift
//  AppChats
//
//  Created by Евгений Таракин on 04.01.2023.
//

import Foundation
import MessageKit

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}
