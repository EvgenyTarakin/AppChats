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
    private var otherUser = Sender(senderId: "other", displayName: "Вася дыркин")
        
//    MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
//    MARK: - private func
    private func commonInit() {
        navigationItem.title = "Чаты"
        view.setWhiteBackgroundColor()
        
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        
        messages.append(Message(sender: otherUser, messageId: "1", sentDate: Date().addingTimeInterval(-1), kind: .text("Ку")))
        messagesCollectionView.reloadData()
//        showMessageTimestampOnSwipeLeft = true
        
        messagesCollectionView.removeConstraints(messagesCollectionView.constraints)
//        messagesCollectionView
        
    }
    
//    MARK: - func

}

extension ChatViewController: MessagesLayoutDelegate {
    
}

extension ChatViewController: MessagesDataSource {
    var currentSender: MessageKit.SenderType {
        return selfUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        messages.count
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
