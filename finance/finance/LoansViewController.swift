//
//  LoansViewController.swift
//  finance
//
//  Created by Daksha Rajagopal on 3/8/25.
//

import UIKit

class LoansViewController: UIViewController {

    @IBOutlet var month: UILabel!
    @IBOutlet var num: UITextField!
    @IBOutlet var interest: UITextField!
    @IBOutlet var amount: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "tab_dash")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: false)
    }
    @IBAction func calc(_ sender: Any) {
        let num = Double(self.num.text ?? "0") ?? 0
        let interest = Double(interest.text ?? "0")  ?? 0
        let amount = Double(self.amount.text ?? "0") ?? 0
        
        let monthlyPayment = (amount * (interest/12.0/100.0) * pow(1 + (interest/12.0/100.0) , Double(num*12.0))) /
        (pow(1 + (interest/12.0/100.0) , Double(num*12.0)) - 1)
        
        month.text = "$" + String(monthlyPayment)
        let save = UserDefaults.standard.double(forKey: "finalSavings")
        if monthlyPayment > save {
            showAlert()
            
        }
    }
    
    func showAlert() {
            let alert = UIAlertController(
                title: "Warning",
                message: "This payment period is too small for your average monthly savings.\n\nWe recommend allocating a max of 15% of monthly savings towards loans each month.",
                preferredStyle: .alert
            )

            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)

            present(alert, animated: true, completion: nil)
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
