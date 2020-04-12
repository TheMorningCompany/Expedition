//
//  DonationBoxViewController.swift
//  Expedition
//
//  Created by Zeqiel Golomb on 4/11/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import UIKit

class DonationBoxViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

            self.navigationController!.navigationBar.layer.borderWidth = 0.50
           self.navigationController!.navigationBar.layer.borderColor = UIColor.clear.cgColor
           self.navigationController?.navigationBar.clipsToBounds = true
           let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
           navigationItem.backBarButtonItem = backBarButtton
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
