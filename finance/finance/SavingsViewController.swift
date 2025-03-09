//
//  SavingsViewController.swift
//  finance
//
//  Created by Daksha Rajagopal on 3/8/25.
//

import UIKit

class SavingsViewController: UIViewController {

    @IBOutlet var misc: UITextField!
    @IBOutlet var bills: UITextField!
    @IBOutlet var grocceries: UITextField!
    @IBOutlet var loans: UITextField!
    @IBOutlet var rent: UITextField!
    @IBOutlet var save: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func calc(_ sender: Any) {
        let misc = Double(misc.text ?? "0") ?? 0.0
        let bills = Double(bills.text ?? "0") ?? 0.0
        let groceries = Double(grocceries.text ?? "0") ?? 0.0
        let loans = Double(loans.text ?? "0") ?? 0.0
        let rent = Double(rent.text ?? "0") ?? 0.0
        let finalIncome = UserDefaults.standard.double(forKey: "finalIncome")

        save.text = "$" + String(finalIncome - misc - bills - groceries - loans - rent)
        print(finalIncome - misc - bills - groceries - loans - rent)
        
        UserDefaults.standard.set(finalIncome - misc - bills - groceries - loans - rent, forKey: "finalSavings")
        
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
