//
//  RiskViewController.swift
//  finance
//
//  Created by Daksha Rajagopal on 3/8/25.
//

import UIKit
import CoreML


class RiskViewController: UIViewController {
    
    @IBOutlet var marital_status_change: UITextField!
    @IBOutlet var country: UITextField!
    @IBOutlet var city: UITextField!
    @IBOutlet var loan_purpose: UITextField!
    @IBOutlet var loan_amt: UITextField!
    @IBOutlet var debt_income: UITextField!
    @IBOutlet var payment_history: UISegmentedControl!
    @IBOutlet var dependents: UITextField!
    @IBOutlet var emp_status: UITextField!
    @IBOutlet var prev_defaults: UITextField!
    @IBOutlet var job_stable: UITextField!
    @IBOutlet var education: UISegmentedControl!
    @IBOutlet var assets: UITextField!
    @IBOutlet var income: UITextField!
    @IBOutlet var state: UITextField!
    @IBOutlet var gender: UITextField!
    @IBOutlet var credit_score: UITextField!
    @IBOutlet var marital_status: UITextField!
    @IBOutlet var age: UITextField!
    
    let model = try? Risk(configuration: MLModelConfiguration())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func analyze(_ sender: Any) {
        let paymentHistoryOptions = ["Poor", "Fair", "Excellent"]
        let educationOptions = ["High School", "Bachelor's" , "Master's", "PhD"]
        
        var age = Int64(age.text ?? "") ?? 0
        var gender = gender.text ?? ""
        var education = educationOptions[education.selectedSegmentIndex]
        var married = marital_status.text ?? ""
        var income = Double(income.text ?? "") ?? 0.0
        var credit_score = Double(credit_score.text ?? "") ?? 0.0
        var loan_amount = Double(loan_amt.text ?? "") ?? 0.0
        var loan_purpose = loan_purpose.text ?? ""
        var employment_status = emp_status.text ?? ""
        var year_at_job = Int64(job_stable.text ?? "") ?? 0
        var payment_history = paymentHistoryOptions[payment_history.selectedSegmentIndex]
        var debt_to_income = Double(debt_income.text ?? "") ?? 0.0
        var assets = Double(assets.text ?? "") ?? 0.0
        var dependents = Double(dependents.text ?? "") ?? 0.0
        var city = city.text ?? ""
        var state = state.text ?? ""
        var country = country.text ?? ""
        var prev_defaults = Double(prev_defaults.text ?? "") ?? 0.0
        var marital_status_change = Int64(marital_status_change.text ?? "") ?? 0
        
        do {
            let prediction = try model?.prediction(
                Age: age,
                Gender: gender,
                Education_Level: education,
                Marital_Status: married,
                Income: income,
                Credit_Score: credit_score,
                Loan_Amount: loan_amount,
                Loan_Purpose: loan_purpose,
                Employment_Status: employment_status,
                Years_at_Current_Job: year_at_job,
                Payment_History: payment_history,
                Debt_to_Income_Ratio: debt_to_income,
                Assets_Value: assets,
                Number_of_Dependents: dependents,
                City: city,
                State: state,
                Country: country,
                Previous_Defaults: prev_defaults,
                Marital_Status_Change: marital_status_change
            )
            // Extracting the predicted risk score
            let riskScore = prediction?.Risk_Rating ?? ""
            print("Predicted Risk Score: \(riskScore)")
            if riskScore == "High" {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "result")
                vc.modalPresentationStyle = .overFullScreen
                present(vc, animated: false)
            }
            else if riskScore == "Medium" {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "medium")
                vc.modalPresentationStyle = .overFullScreen
                present(vc, animated: false)
            }
            else if riskScore == "Low" {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "high")
                vc.modalPresentationStyle = .overFullScreen
                present(vc, animated: false)
            }
            
            
            
        } catch {
            print("Error making prediction: \(error)")
        }
        
        
    }
    @IBAction func back(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "tab_dash")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: false)
    }
}
