//
//  ChatViewController.swift
//  AppChats
//
//  Created by Евгений Таракин on 28.12.2022.
//

import UIKit
import MessageKit
import InputBarAccessoryView

class ChatViewController: MessagesViewController {
    
//     MARK: - property
    private var messages: [MessageType] = []
    private var selfUser = Sender(senderId: "self", displayName: "Me")
    private var otherUser = Sender(senderId: "other", displayName: "Other")
        
//    MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    MARK: - private func
    private func commonInit() {
        view.setWhiteBackgroundColor()
        
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        messagesCollectionView.reloadData()
    }
    
//    MARK: - func
    func configurate(_ title: String, lastMessage: String) {
        otherUser = Sender(senderId: "other", displayName: title)
        navigationItem.title = title
        messages.append(Message(sender: otherUser, messageId: "2", sentDate: Date(), kind: .text(lastMessage)))
        commonInit()
    }
}

extension ChatViewController: MessagesLayoutDelegate {
    
}

extension ChatViewController: MessagesDataSource {
    var currentSender: MessageKit.SenderType {
        return selfUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return messages.count
    }
}

extension ChatViewController: MessagesDisplayDelegate {
    
}

extension ChatViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        messages.append(Message(sender: selfUser, messageId: "1", sentDate: Date(), kind: .text(text)))
        inputBar.inputTextView.text = nil
        messagesCollectionView.reloadDataAndKeepOffset()
    }
}
