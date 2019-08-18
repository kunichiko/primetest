//
//  ViewController.swift
//  primetest
//
//  Created by 大中邦彦 on 2019/08/18.
//  Copyright © 2019 Ripplex, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    var lastDate = Date()

    var primeGenerator : PrimeGenerator! {
        didSet {
            self.title = primeGenerator?.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.isEnabled = true
        stopButton.isEnabled = false
        textView.text = ""
    }

    @IBAction func startButtonTouchUpInside(_ sender: Any) {
        textView.text = ""
        startButton.isEnabled = false
        stopButton.isEnabled = true
        self.lastDate = Date()
        DispatchQueue.global(qos: .userInitiated).async {
            self.primeGenerator.start { (prime) in
                let now = Date()
                let interval = now.timeIntervalSince(self.lastDate)
                let intervalMsec = Int(interval * 1000)
                self.textView.text.append("\(prime) : \(intervalMsec) [msec]\n")
                self.lastDate = now
            }
        }
    }

    @IBAction func stopButtonTouchUpInside(_ sender: Any) {
        startButton.isEnabled = true
        stopButton.isEnabled = false
        primeGenerator.stop()
    }
    
}

