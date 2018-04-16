//
//  MyChatViewController.swift
//  graduatR
//
//  Created by Dhriti Chawla on 4/15/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController

class MyChatViewController: JSQMessagesViewController {
    
    @IBOutlet weak var detailsButton: UIBarButtonItem!
    var name = String()
    var username = String()
    var messages = [JSQMessage]()
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()
    var group = ""
    var messageRef = Database.database().reference().child("Chats")
    private var newMessageRefHandle: DatabaseHandle?
    
    override func viewDidLoad() {
        
        print(group)
        super.viewDidLoad()
        
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        self.senderId = AllVariables.Username
        self.senderDisplayName = self.username
        self.title = self.username
        
        Database.database().reference().child("GroupChats").observeSingleEvent(of: DataEventType.value, with:  { (snap) in
            if (snap.hasChild(self.username)) {
                self.group = "true"
                print("....check......")
                print(self.username)
                self.messageRef = Database.database().reference().child("GroupChats")
                
                
            }
            else {
                self.group = "false"
                self.messageRef = Database.database().reference().child("Chats")
                self.navigationItem.rightBarButtonItem = nil
            }
            self.observeMessages()
        })
        
        print (group)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // observeMessages()
        finishReceivingMessage()
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        let currTime = "\(date) \(hour):\(minutes):\(seconds)"
        
        
        if (group == "false") {
        var itemRef1 = messageRef.child(AllVariables.Username).child(username) // 1
        var itemRef2 = messageRef.child(username).child(AllVariables.Username) //
        Database.database().reference().child("Chats").child(AllVariables.Username).child(username).observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            itemRef1 = itemRef1.child("\(snapshot.childrenCount)")
            itemRef2 = itemRef2.child("\(snapshot.childrenCount)")
            
            print ("\(snapshot.childrenCount)...\(itemRef1)... goes here")
    
            let messageItem = [ // 2
                "senderId": senderId!,
                "senderName": "\(AllVariables.Fname) \(AllVariables.Lname)",
                "text": text!,
                "time": currTime
            ]
            
            itemRef1.setValue(messageItem) // 3
            itemRef2.setValue(messageItem) //
            
            JSQSystemSoundPlayer.jsq_playMessageSentSound() // 4
            
            self.finishSendingMessage() // 5
            
        })
    }
        else {
            var itemRef1 = messageRef.child(username).child("allgroupchats") //
            itemRef1.observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                itemRef1 = itemRef1.child("\(snapshot.childrenCount)")
                
                print ("\(snapshot.childrenCount)...\(itemRef1)... goes here")
                
                let messageItem = [ // 2
                    "senderId": senderId!,
                    "senderName": "\(AllVariables.Fname) \(AllVariables.Lname)",
                    "text": text!,
                    "time": currTime
                ]
                
                itemRef1.setValue(messageItem) //
                
                JSQSystemSoundPlayer.jsq_playMessageSentSound() // 4
                
                self.finishSendingMessage() // 5
                
            })
        }
    
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    private func observeMessages() {
        
        var Ref = messageRef.child(username).child("allgroupchats")
        
        if (group == "false") {
            Ref = messageRef.child(AllVariables.Username).child(username)
        }
        print("USERNAME is../////....")
        print(username)
        print("......")
        print(Ref)
        let messageQuery = Ref.queryLimited(toLast:25)
        
        // 2. We can use the observe method to listen for new
        // messages being written to the Firebase DB
        newMessageRefHandle = messageQuery.observe(.childAdded, with: { (snapshot) -> Void in
            // 3
            let messageData = snapshot.value as! NSDictionary
            
            if let id = messageData["senderId"] as! String!, let name = messageData["senderName"] as! String!,let time = messageData["time"] as! String!, let text = messageData["text"] as! String!, text.characters.count > 0 {
                // 4
                self.addMessage(withId: id, name: name, text: text)
                
                // 5
                self.finishReceivingMessage()
            } else {
                print("Error! Could not decode message data")
            }
        })
            
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addMessage(withId id: String, name: String, text: String) {
        if let message = JSQMessage(senderId: id, displayName: name, text: text) {
            messages.append(message)
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    private func setupOutgoingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor(red:0.89, green:0.87, blue:0.71, alpha:1.0))
    }
    
    private func setupIncomingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.incomingMessagesBubbleImage(with:  UIColor.jsq_messageBubbleLightGray())
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item] // 1
        if message.senderId == senderId { // 2
            return outgoingBubbleImageView
        } else { // 3
            return incomingBubbleImageView
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        let message = messages[indexPath.item]
        //print("collectionView functioooooooon")
        
        //        if message.senderId == senderId {
        cell.textView?.textColor = UIColor.black
        //        } else {
        //            cell.textView?.textColor = UIColor.black
        //        }
        return cell
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString!
    {
        return messages[indexPath.item].senderId == senderId ? nil : NSAttributedString(string: messages[indexPath.item].senderDisplayName)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat
    {
        return messages[indexPath.item].senderId == senderId ? 0 : 15
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! PopOverDetailsViewController
            let gc = username
            vc.groupname = gc
    
    }

}
