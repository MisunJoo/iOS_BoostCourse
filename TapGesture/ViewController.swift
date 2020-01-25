//
//  ViewController.swift
//  TapGesture
//
//  Created by Misun Joo on 25/01/2020.
//  Copyright © 2020 Misun Joo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true) //강제로 종료
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let tapGesture: UITapGestureRecognizer =
//            UITapGestureRecognizer(target: self, action: #selector(self.tapView(_:)))
//        self.view.addGestureRecognizer(tapGesture)
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        
        self.view.addGestureRecognizer(tapGesture)
    }
    
    // 정교한 작업을 하고 싶다면, delegate를. 무난하게 쓴다면 Target action을!
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }


}

