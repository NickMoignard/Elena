//
//  loggedInViewController.swift
//  Elena
//
//  Created by Nicholas Moignard on 9/7/16.
//  Copyright © 2016 Elena. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
  
  var username = ""
  
  @IBOutlet weak var usernameLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    usernameLabel.text = username
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}
