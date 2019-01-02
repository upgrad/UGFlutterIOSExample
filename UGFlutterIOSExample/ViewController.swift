//
//  ViewController.swift
//  UGFlutterIOSExample
//
//  Created by Prateek Grover on 02/01/19.
//  Copyright © 2019 UpGrad Education Private Limited. All rights reserved.
//

import UIKit
import UGFlutter

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let button = UIButton(frame: CGRect(origin: CGPoint(x: 80, y: 80), size: CGSize(width: 100, height: 100)))
        button.backgroundColor = UIColor.black
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Click me!", for: .normal)
        button.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func buttonTapped() {
        UGFlutter.present(initialRoute: "/path", onViewController: self, animated: true, completion: nil)
        //        UGFlutter.push(initialRoute: "/path", onNavigationController: self.navigationController!, animated: true)
    }
}
