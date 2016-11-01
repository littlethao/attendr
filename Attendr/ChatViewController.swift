import UIKit
import JSQMessagesViewController
import FirebaseDatabase
import FirebaseCore
import FirebaseAuth


class ChatViewController: JSQMessagesViewController {
    
    var myID:String!
    var theirID:String!
    
    
    var messages = [JSQMessage]()
    var messageRef = FIRDatabase.database().reference().child("messages")


 
    override func viewDidLoad() {
        super.viewDidLoad()
        print(theirID)
        self.senderId = myID
        self.senderDisplayName = ""
        observeMessages()
    }
    
    func observeMessages() {
        messageRef.child(myID).child(theirID).observe(FIRDataEventType.childAdded, with: { (snapshot) in
            if let dict = snapshot.value as? [String: AnyObject] {
                let senderId = dict["senderId"] as! String
                let senderName = dict["senderName"] as! String
                let text = dict["text"] as! String
                self.messages.append(JSQMessage(senderId: senderId, displayName: senderName, text: text))
                self.collectionView.reloadData()
            }
            
            
        })
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let newMessage = messageRef.child("\(myID!)").child("\(theirID!)").childByAutoId()
        let theirMessage = messageRef.child("\(theirID ?? "")").child("\(myID!)").childByAutoId()
        let messageData = ["text": text, "senderId": senderId, "senderName": senderDisplayName]
        newMessage.setValue(messageData)
        theirMessage.setValue(messageData)
        self.finishSendingMessage()
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, messageDataForItemAt indexPath: IndexPath) -> JSQMessageData {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, messageBubbleImageDataForItemAt indexPath: IndexPath) -> JSQMessageBubbleImageDataSource{
        let message = messages[indexPath.item]
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        if message.senderId == self.senderId {
            return bubbleFactory!.outgoingMessagesBubbleImage(with: UIColor.lightGray)
        } else {
            return bubbleFactory!.incomingMessagesBubbleImage(with: UIColor.blue)
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("number of items:\(messages.count)")
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView,  cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        return cell
    }
}

