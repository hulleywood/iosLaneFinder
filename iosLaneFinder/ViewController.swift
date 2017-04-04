//
//  ViewController.swift
//  iosLaneFinder
//
//  Created by James Hulley on 3/30/17.
//  Copyright © 2017 James Hulley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var previewView: UIView!
    let wrapper = OpenCVWrapper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        wrapper.setTargetView(previewView);
        wrapper.start();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

