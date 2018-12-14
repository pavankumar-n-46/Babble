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

}
