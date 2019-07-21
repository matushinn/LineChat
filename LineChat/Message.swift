//
//  Message.swift
//  LineChat
//
//  Created by 大江祥太郎 on 2019/07/21.
//  Copyright © 2019 shotaro. All rights reserved.
//

import Foundation
import MessageKit

struct Message: MessageType {
    //classではなくstruct!
    var sender: Sender
    var sentDate: Date
    var messageId: String
    var kind: MessageKind
}
