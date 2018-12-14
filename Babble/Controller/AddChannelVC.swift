//
//  AddChannelVC.swift
//  Babble
//
//  Created by Pavan Kumar N on 12/12/2018.
//  Copyright © 2018 Pavan Kumar N. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    //outlets
    @IBOutlet weak var channelName: UITextField!
    @IBOutlet weak var channelDesc: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func createChannelPressed(_ sender: Any) {
        guard let name = channelName.text, name != "" else{return alertDisplay(title: "Channel Name", msg: "provide channel name!")}
        guard let desc = channelName.text, desc != "" else{ return alertDisplay(title: "Channel Description", msg: "provide channel desc!")}
        SocketService.instance.addChannel(channelName: name, channelDesc: desc) { (success) in
            self.dismiss(animated: true, completion: nil)
        }
        
    }

    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupView(){
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        channelName.attributedPlaceholder = NSAttributedString(string: "Channel Name", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2588235294, green: 0.3294117647, blue: 0.7254901961, alpha: 1)])
        channelDesc.attributedPlaceholder = NSAttributedString(string: "Channel Description", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2588235294, green: 0.3294117647, blue: 0.7254901961, alpha: 1)])
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    
    //utility
    private func alertDisplay(title: String, msg: String){
        let alertStr = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)] )
        let alert = UIAlertController(title: alertStr.string, message: msg, preferredStyle: .alert)
        alert.setValue(alertStr, forKey: "attributedTitle")
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }

}
