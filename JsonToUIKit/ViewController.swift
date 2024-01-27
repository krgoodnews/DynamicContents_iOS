//
//  ViewController.swift
//  JsonToUIKit
//
//  Created by Tim Guk on 1/27/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapButton(_ sender: UIButton) {
        let vc = ContentListViewController()
//        navigationController?.pushViewController(vc, animated: true)
        present(vc, animated: true, completion: nil)
    }
    
}
