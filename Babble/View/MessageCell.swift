//
//  MessageCell.swift
//  Babble
//
//  Created by Pavan Kumar N on 28/12/2018.
//  Copyright © 2018 Pavan Kumar N. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    //outlets
    @IBOutlet weak var profileImg: CircleImage!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var msgTxtLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(message: Message){
        profileImg.image = UIImage(named: message.userAvatar)
        profileImg.backgroundColor = UserDataService.instance.getUserAvatorColorFromString(components: message.userAvatarColor)
        userNameLbl.text = message.userName
        msgTxtLbl.text = message.message
        
        ///to slice the ISO timestring to remove the microsecond part
        guard var isoDate = message.timeStamp else {return}
        let endIndex = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = isoDate.substring(to: endIndex)
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        
        if let finalDate = chatDate{
            let finalDate = newFormatter.string(from: finalDate)
            timeLbl.text = finalDate
        }
    }
}
  
