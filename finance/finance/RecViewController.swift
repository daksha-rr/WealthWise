//
//  RecViewController.swift
//  finance
//
//  Created by Daksha Rajagopal on 3/8/25.
//

import UIKit

class RecViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func invest(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "risk")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: false)
    }
    
    @IBAction func budget(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "budget")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: false)
    }
    @IBAction func loan(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "loan")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: false)
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
