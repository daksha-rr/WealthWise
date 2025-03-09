//
//  TaxViewController.swift
//  Finance App
//
//  Created by Daksha Rajagopal on 3/5/25.
//

import UIKit

struct MyVariables {
    static var i = 0.0
}
extension Double {
    func truncate(places : Int)-> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}

class TaxViewController: UIViewController {
    @IBOutlet weak var gross_income: UITextField!
    @IBOutlet weak var four: UITextField!
    @IBOutlet weak var roth: UITextField!
    @IBOutlet weak var non_tax: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var extra_inc: UITextField!
    var status = 0
    @IBOutlet var income: UILabel!
    @IBAction func filing(_ sender: Any) {
        switch (sender as AnyObject).selectedSegmentIndex {
            case 0:
                status = 0
            case 1:
                status = 1
            case 2:
                status = 2
            case 3:
                status = 3
            default:
                break
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

    }
    
    
    @IBAction func calc(_ sender: Any) {
        let gross = Int(gross_income.text ?? "") ?? 0
        let four = Int(four.text ?? "") ?? 0
        let roth = Int(roth.text ?? "") ?? 0
        let non_tax = Int(non_tax.text ?? "") ?? 0
        let state = self.state.text ?? ""
        let extra_inc = Int(extra_inc.text ?? "") ?? 0
        
        let tax_inc = gross - four - roth - non_tax + extra_inc
        var inc = 0.0
        var taxed = 0.0
        
        
        switch state {
        case "AL":
            if [0, 1, 2].contains(status) {
                var tax: Double = 0.0
                let firstBracket = min(inc, 500)
                    tax += firstBracket * 0.02
                    
                    if inc > 500 {
                        // 4% on the next $2,500 (between $500 and $3,000)
                        let secondBracket = min(inc - 500, 2500)
                        tax += secondBracket * 0.04
                    }
                    
                    if inc > 3000 {
                        // 5% on anything over $3,000
                        let thirdBracket = inc - 3000
                        tax += thirdBracket * 0.05
                    }
                    
                    taxed = tax
                
            }
            if [3].contains(status) {
                var tax: Double = 0.0
                let firstBracket = min(inc, 1000)
                    tax += firstBracket * 0.02
                    
                    if inc > 500 {
                        // 4% on the next $2,500 (between $500 and $3,000)
                        let secondBracket = min(inc - 1000, 5000)
                        tax += secondBracket * 0.04
                    }
                    
                    if inc > 6000 {
                        // 5% on anything over $3,000
                        let thirdBracket = inc - 6000
                        tax += thirdBracket * 0.05
                    }
                    
                    taxed = tax
                
            }

        case "AK":
            // Handle Alaska
            inc = Double(tax_inc)
        case "AZ":
            // Handle Arizona
            inc = Double(tax_inc) * 0.975

        case "CA":
            if [0, 2].contains(status) {
                var tax: Double = 0.0
                    
                    let brackets: [(limit: Double, rate: Double)] = [
                        (10756, 0.01),
                        (25499, 0.02),
                        (40245, 0.04),
                        (55866, 0.06),
                        (70606, 0.08),
                        (360659, 0.093),
                        (432787, 0.103),
                        (721314, 0.113),
                        (Double.infinity, 0.123)
                    ]
                    
                    var previousLimit: Double = 0.0
                    
                    for (limit, rate) in brackets {
                        if inc > previousLimit {
                            let taxableAmount = min(inc, limit) - previousLimit
                            tax += taxableAmount * rate
                            previousLimit = limit
                        } else {
                            break
                        }
                    }
                    
                    taxed = tax
                
            }
            if [3].contains(status) {
                var tax: Double = 0.0
        
                let brackets: [(limit: Double, rate: Double)] = [
                    (21512, 0.01),
                    (50998, 0.02),
                    (80490, 0.04),
                    (111732, 0.06),
                    (141212, 0.08),
                    (721318, 0.093),
                    (865574, 0.103),
                    (1442628, 0.113),
                    (Double.infinity, 0.123)
                ]
                
                var previousLimit: Double = 0.0
                
                for (limit, rate) in brackets {
                    if inc > previousLimit {
                        let taxableAmount = min(inc, limit) - previousLimit
                        tax += taxableAmount * rate
                        previousLimit = limit
                    } else {
                        break
                    }
                }
                
                taxed = tax
                
            }
            if [1].contains(status) {
                var tax: Double = 0.0
        
                let brackets: [(limit: Double, rate: Double)] = [
                    (21527, 0.01),
                    (51000, 0.02),
                    (65744, 0.04),
                    (81364, 0.06),
                    (96107, 0.08),
                    (490493, 0.093),
                    (588593, 0.103),
                    (980987, 0.113),
                    (Double.infinity, 0.123)
                ]
                
                var previousLimit: Double = 0.0
                
                for (limit, rate) in brackets {
                    if inc > previousLimit {
                        let taxableAmount = min(inc, limit) - previousLimit
                        tax += taxableAmount * rate
                        previousLimit = limit
                    } else {
                        break
                    }
                }
                
                taxed = tax
                
            }
        case "CO":
            // Handle Colorado
            inc = Double(tax_inc) * 0.956
        case "CT":
            if [0,2].contains(status) {
                var tax: Double = 0.0
        
                let brackets: [(limit: Double, rate: Double)] = [
                    (10000, 0.02),
                    (50000, 0.045),
                    (100000, 0.055),
                    (200000, 0.06),
                    (250000, 0.065),
                    (500000, 0.069),
                    (Double.infinity, 0.0699)
                ]
                
                var previousLimit: Double = 0.0
                
                for (limit, rate) in brackets {
                    if inc > previousLimit {
                        let taxableAmount = min(inc, limit) - previousLimit
                        tax += taxableAmount * rate
                        previousLimit = limit
                    } else {
                        break
                    }
                }
                
                taxed = tax
                
            }
            if [1].contains(status) {
                var tax: Double = 0.0
        
                let brackets: [(limit: Double, rate: Double)] = [
                    (16000, 0.02),
                    (80000, 0.045),
                    (160000, 0.055),
                    (320000, 0.06),
                    (400000, 0.065),
                    (800000, 0.069),
                    (Double.infinity, 0.0699)
                ]
                
                var previousLimit: Double = 0.0
                
                for (limit, rate) in brackets {
                    if inc > previousLimit {
                        let taxableAmount = min(inc, limit) - previousLimit
                        tax += taxableAmount * rate
                        previousLimit = limit
                    } else {
                        break
                    }
                }
                
                taxed = tax
                
            }
            if [3].contains(status) {
                var tax: Double = 0.0
        
                let brackets: [(limit: Double, rate: Double)] = [
                    (20000, 0.02),
                    (100000, 0.045),
                    (200000, 0.055),
                    (400000, 0.06),
                    (500000, 0.065),
                    (1000000, 0.069),
                    (Double.infinity, 0.0699)
                ]
                
                var previousLimit: Double = 0.0
                
                for (limit, rate) in brackets {
                    if inc > previousLimit {
                        let taxableAmount = min(inc, limit) - previousLimit
                        tax += taxableAmount * rate
                        previousLimit = limit
                    } else {
                        break
                    }
                }
                
                taxed = tax
                
            }
        case "DE":
            // Handle Delaware
            if [0,1,2,3].contains(status) {
                var tax: Double = 0.0
                let brackets: [(limit: Double, rate: Double)] = [
                    (2000, 0.00),
                    (5000, 0.022),
                    (10000, 0.039),
                    (20000, 0.048),
                    (25000, 0.052),
                    (60000, 0.0555),
                    (Double.infinity, 0.066)
                ]
                var previousLimit: Double = 0.0
                for (limit, rate) in brackets {
                    if inc > previousLimit {
                        let taxableAmount = min(inc, limit) - previousLimit
                        tax += taxableAmount * rate
                        previousLimit = limit
                    } else {
                        break
                    }
                }
                taxed = tax
             }

        case "FL":
            // Handle Florida
            inc = Double(tax_inc)
        case "GA":
            // Handle Georgia
            inc = Double(tax_inc) * 0.9461
 
        case "ID":
            // Handle Idaho
            inc = Double(tax_inc) * 0.942
        case "IL":
            // Handle Illinois
            inc = Double(tax_inc) * 0.9505
        case "IN":
            // Handle Indiana
            inc = Double(tax_inc) * 0.9695
        case "IA":
            // Handle Iowa
            if [0,1,2].contains(status) {
                var tax: Double = 0.0
                let brackets: [(limit: Double, rate: Double)] = [
                    (6210, 0.044),
                    (31050, 0.0482),
                    (Double.infinity, 0.057)
                ]
                var previousLimit: Double = 0.0
                for (limit, rate) in brackets {
                    if inc > previousLimit {
                        let taxableAmount = min(inc, limit) - previousLimit
                        tax += taxableAmount * rate
                        previousLimit = limit
                    } else {
                        break
                    }
                }
                taxed = tax
             }
            else if [3].contains(status) {
                var tax: Double = 0.0
                let brackets: [(limit: Double, rate: Double)] = [
                    (12420, 0.044),
                    (62100, 0.0482),
                    (Double.infinity, 0.057)
                ]
                var previousLimit: Double = 0.0
                for (limit, rate) in brackets {
                    if inc > previousLimit {
                        let taxableAmount = min(inc, limit) - previousLimit
                        tax += taxableAmount * rate
                        previousLimit = limit
                    } else {
                        break
                    }
                }
                taxed = tax
             }

        case "KS":
            if [3].contains(status) {
                if tax_inc <= 46000 {
                    taxed = Double(tax_inc) * 0.052
                } else if tax_inc > 46000 {
                    taxed = 2392 + (0.0558 * Double((tax_inc - 46000)))
                }
            }
            if [0,1,2].contains(status) {
                if tax_inc <= 23000 {
                    taxed = Double(tax_inc) * 0.052
                } else if tax_inc > 23000 {
                    taxed = 1196 + (0.0558 * Double((tax_inc - 23000)))
                }
            }
        case "KY":
            // Handle Kentucky
            inc = Double(tax_inc) * 0.96
        case "LA":
            // Handle Louisiana
            if [0,2].contains(status) {
                var tax: Double = 0.0
                let brackets: [(limit: Double, rate: Double)] = [
                    (12500, 0.0185),
                    (50000, 0.035),
                    (Double.infinity, 0.0425)
                ]
                var previousLimit: Double = 0.0
                for (limit, rate) in brackets {
                    if inc > previousLimit {
                        let taxableAmount = min(inc, limit) - previousLimit
                        tax += taxableAmount * rate
                        previousLimit = limit
                    } else {
                        break
                    }
                }
                taxed = tax
            }
            else if [1,3].contains(status) {
                var tax: Double = 0.0
                let brackets: [(limit: Double, rate: Double)] = [
                    (25000, 0.0185),
                    (100000, 0.035),
                    (Double.infinity, 0.0425)
                ]
                var previousLimit: Double = 0.0
                for (limit, rate) in brackets {
                    if inc > previousLimit {
                        let taxableAmount = min(inc, limit) - previousLimit
                        tax += taxableAmount * rate
                        previousLimit = limit
                    } else {
                        break
                    }
                }
                taxed = tax
             }


           
        case "ME":
            if [0,2].contains(status) {
                if tax_inc <= 26050 {
                    taxed = Double(tax_inc) * 0.058
                } else if tax_inc > 23000, tax_inc <= 61599 {
                    taxed = 1511 + (0.0675 * Double((tax_inc - 26050)))
                } else if tax_inc > 61600  {
                    taxed = 1511 + (0.0715 * Double((tax_inc - 26050)))
                }
            }
            if [3].contains(status) {
                if tax_inc <= 52100 {
                    taxed = Double(tax_inc) * 0.058
                } else if tax_inc > 52100, tax_inc <= 123249  {
                    taxed = 3022 + (0.0675 * Double((tax_inc - 52100)))
                } else if tax_inc > 123249   {
                    taxed = 7825 + (0.0715 * Double((tax_inc - 123249)))
                }

            }
            if [1].contains(status) {
                if tax_inc <= 39050 {
                    taxed = Double(tax_inc) * 0.058
                } else if tax_inc > 39050, tax_inc <= 92449  {
                    taxed = 2265 + (0.0675 * Double((tax_inc - 39050)))
                } else if tax_inc > 92450   {
                    taxed = 5870 + (0.0715 * Double((tax_inc - 92450)))
                }
            }
        case "MD":
            // Handle Maryland
            if [0, 2].contains(status) {
                if tax_inc <= 1000  {
                    taxed = Double(tax_inc) * 0.2
                } else if tax_inc > 1000, tax_inc <= 2000  {
                    taxed = 20 + (0.03 * Double((tax_inc - 1000)))
                } else if tax_inc > 2000, tax_inc <= 3000  {
                    taxed = 50 + (0.04 * Double((tax_inc - 2000)))
                } else if tax_inc > 3000, tax_inc <= 100000  {
                    taxed = 90 + (0.0475 * Double((tax_inc - 3000)))
                } else if tax_inc > 100000, tax_inc <= 125000  {
                    taxed = 4697.50 + (0.05 * Double((tax_inc - 100000)))
                } else if tax_inc > 125000, tax_inc <= 150000 {
                    taxed = 5947.50 + (0.0525 * Double((tax_inc - 125000)))
                } else if tax_inc > 150000, tax_inc <= 250000 {
                    taxed = 7260 + (0.055 * Double((tax_inc - 150000)))
                } else if tax_inc > 250000 {
                    taxed = 12760 + (0.0575 * Double((tax_inc - 250000)))
                }
            }
            if [1, 3].contains(status) {
                if tax_inc <= 1000  {
                    taxed = Double(tax_inc) * 0.2
                } else if tax_inc > 1000, tax_inc <= 2000  {
                    taxed = 20 + (0.03 * Double((tax_inc - 1000)))
                } else if tax_inc > 2000, tax_inc <= 3000  {
                    taxed = 50 + (0.04 * Double((tax_inc - 2000)))
                } else if tax_inc > 3000, tax_inc <= 150000  {
                    taxed = 90 + (0.0475 * Double((tax_inc - 3000)))
                } else if tax_inc > 150000, tax_inc <= 175000  {
                    taxed = 7072.50 + (0.05 * Double((tax_inc - 100000)))
                } else if tax_inc > 175000, tax_inc <= 225000 {
                    taxed = 8322.50 + (0.0525 * Double((tax_inc - 125000)))
                } else if tax_inc > 225000, tax_inc <= 300000 {
                    taxed = 10947.50 + (0.055 * Double((tax_inc - 150000)))
                } else if tax_inc > 300000 {
                    taxed = 15072.50 + (0.0575 * Double((tax_inc - 300000)))
                }
            }

        case "MI":
            // Handle Michigan
            inc = Double(tax_inc) * 0.9575
        case "MN":
            // Handle Minnesota
            if [0].contains(status) {
                var tax: Double = 0.0
                let brackets: [(limit: Double, rate: Double)] = [
                    (31690, 0.0535),
                    (104090, 0.0680),
                    (193240, 0.0785),
                    (Double.infinity, 0.0985)
                ]
                var previousLimit: Double = 0.0
                for (limit, rate) in brackets {
                    if inc > previousLimit {
                        let taxableAmount = min(inc, limit) - previousLimit
                        tax += taxableAmount * rate
                        previousLimit = limit
                    } else {
                        break
                    }
                }
                taxed = tax
            }
            else if [3].contains(status) {
                var tax: Double = 0.0
                let brackets: [(limit: Double, rate: Double)] = [
                    (46330, 0.0535),
                    (184040, 0.0680),
                    (321450, 0.0785),
                    (Double.infinity, 0.0985)
                ]
                var previousLimit: Double = 0.0
                for (limit, rate) in brackets {
                    if inc > previousLimit {
                        let taxableAmount = min(inc, limit) - previousLimit
                        tax += taxableAmount * rate
                        previousLimit = limit
                    } else {
                        break
                    }
                }
                taxed = tax
            }
            else if [2].contains(status) {
                var tax: Double = 0.0
                let brackets: [(limit: Double, rate: Double)] = [
                    (23165, 0.0535),
                    (92020, 0.0680),
                    (160725, 0.0785),
                    (Double.infinity, 0.0985)
                ]
                var previousLimit: Double = 0.0
                for (limit, rate) in brackets {
                    if inc > previousLimit {
                        let taxableAmount = min(inc, limit) - previousLimit
                        tax += taxableAmount * rate
                        previousLimit = limit
                    } else {
                        break
                    }
                }
                taxed = tax
            }
            else if [1].contains(status) {
                var tax: Double = 0.0
                let brackets: [(limit: Double, rate: Double)] = [
                    (39010, 0.0535),
                    (156760, 0.0680),
                    (256880, 0.0785),
                    (Double.infinity, 0.0985)
                ]
                var previousLimit: Double = 0.0
                for (limit, rate) in brackets {
                    if inc > previousLimit {
                        let taxableAmount = min(inc, limit) - previousLimit
                        tax += taxableAmount * rate
                        previousLimit = limit
                    } else {
                        break
                    }
                }
                taxed = tax
            }

        case "MT":
            // Handle Montana
            if [0,2].contains(status) {
                var tax: Double = 0.0
                let brackets: [(limit: Double, rate: Double)] = [
                    (20500, 0.047),
                    (Double.infinity, 0.059)
                ]
                var previousLimit: Double = 0.0
                for (limit, rate) in brackets {
                    if inc > previousLimit {
                        let taxableAmount = min(inc, limit) - previousLimit
                        tax += taxableAmount * rate
                        previousLimit = limit
                    } else {
                        break
                    }
                }
                taxed = tax
            }
            else if [1].contains(status) {
                var tax: Double = 0.0
                let brackets: [(limit: Double, rate: Double)] = [
                    (30750 , 0.047),
                    (Double.infinity, 0.059)
                ]
                var previousLimit: Double = 0.0
                for (limit, rate) in brackets {
                    if inc > previousLimit {
                        let taxableAmount = min(inc, limit) - previousLimit
                        tax += taxableAmount * rate
                        previousLimit = limit
                    } else {
                        break
                    }
                }
                taxed = tax
            }
            else if [3].contains(status) {
                var tax: Double = 0.0
                let brackets: [(limit: Double, rate: Double)] = [
                    (41000 , 0.047),
                    (Double.infinity, 0.059)
                ]
                var previousLimit: Double = 0.0
                for (limit, rate) in brackets {
                    if inc > previousLimit {
                        let taxableAmount = min(inc, limit) - previousLimit
                        tax += taxableAmount * rate
                        previousLimit = limit
                    } else {
                        break
                    }
                }
                taxed = tax
            }

        case "NE":
            // Handle Nebraska
            if [0].contains(status) {
                var tax: Double = 0.0
                let brackets: [(limit: Double, rate: Double)] = [
                    (2999, 0.0246),
                    (17999, 0.0351),
                    (28999, 0.0501),
                    (Double.infinity, 0.0584)
                ]
                var previousLimit: Double = 0.0
                for (limit, rate) in brackets {
                    if inc > previousLimit {
                        let taxableAmount = min(inc, limit) - previousLimit
                        tax += taxableAmount * rate
                        previousLimit = limit
                    } else {
                        break
                    }
                }
                taxed = tax
            }
            else if [3].contains(status) {
                var tax: Double = 0.0
                let brackets: [(limit: Double, rate: Double)] = [
                    (5999 , 0.0246),
                    (35999, 0.0351),
                    (57999, 0.0501),
                    (Double.infinity, 0.0584)
                ]
                var previousLimit: Double = 0.0
                for (limit, rate) in brackets {
                    if inc > previousLimit {
                        let taxableAmount = min(inc, limit) - previousLimit
                        tax += taxableAmount * rate
                        previousLimit = limit
                    } else {
                        break
                    }
                }
                taxed = tax
            }
            else if [1].contains(status) {
                var tax: Double = 0.0
                let brackets: [(limit: Double, rate: Double)] = [
                    (5999 , 0.0246),
                    (28799, 0.0351),
                    (42999, 0.0501),
                    (Double.infinity, 0.0584)
                ]
                var previousLimit: Double = 0.0
                for (limit, rate) in brackets {
                    if inc > previousLimit {
                        let taxableAmount = min(inc, limit) - previousLimit
                        tax += taxableAmount * rate
                        previousLimit = limit
                    } else {
                        break
                    }
                }
                taxed = tax
            }
            else if [2].contains(status) {
                var tax: Double = 0.0
                let brackets: [(limit: Double, rate: Double)] = [
                    (2999, 0.0246),
                    (17999, 0.0351),
                    (28999, 0.0501),
                    (Double.infinity, 0.0584)
                ]
                var previousLimit: Double = 0.0
                for (limit, rate) in brackets {
                    if inc > previousLimit {
                        let taxableAmount = min(inc, limit) - previousLimit
                        tax += taxableAmount * rate
                        previousLimit = limit
                    } else {
                        break
                    }
                }
                taxed = tax
            }


        case "NV":
            // Handle Nevada
            inc = Double(tax_inc)
        case "NH":
            // Handle New Hampshire
            inc = Double(tax_inc)
        case "NC":
            // Handle North Carolina
            inc = Double(tax_inc) * 0.955
        case "ND":
            // Handle North Dakota
            if [0].contains(status) {
                var tax: Double = 0.0
                let brackets: [(limit: Double, rate: Double)] = [
                    (47150, 0.0),
                    (238200, 0.0195),
                    (Double.infinity, 0.0250)
                ]
                var previousLimit: Double = 0.0
                for (limit, rate) in brackets {
                    if inc > previousLimit {
                        let taxableAmount = min(inc, limit) - previousLimit
                        tax += taxableAmount * rate
                        previousLimit = limit
                    } else {
                        break
                    }
                }
                taxed = tax
            }
            else if [3].contains(status) {
                var tax: Double = 0.0
                let brackets: [(limit: Double, rate: Double)] = [
                    (78775, 0.0),
                    (289975, 0.0195),
                    (Double.infinity, 0.0250)
                ]
                var previousLimit: Double = 0.0
                for (limit, rate) in brackets {
                    if inc > previousLimit {
                        let taxableAmount = min(inc, limit) - previousLimit
                        tax += taxableAmount * rate
                        previousLimit = limit
                    } else {
                        break
                    }
                }
                taxed = tax
            }
            else if [2].contains(status) {
                var tax: Double = 0.0
                let brackets: [(limit: Double, rate: Double)] = [
                    (39375, 0.0),
                    (144975, 0.0195),
                    (Double.infinity, 0.0250)
                ]
                var previousLimit: Double = 0.0
                for (limit, rate) in brackets {
                    if inc > previousLimit {
                        let taxableAmount = min(inc, limit) - previousLimit
                        tax += taxableAmount * rate
                        previousLimit = limit
                    } else {
                        break
                    }
                }
                taxed = tax
            }
            else if [1].contains(status) {
                var tax: Double = 0.0
                let brackets: [(limit: Double, rate: Double)] = [
                    (63175, 0.0),
                    (264100, 0.0195),
                    (Double.infinity, 0.0250)
                ]
                var previousLimit: Double = 0.0
                for (limit, rate) in brackets {
                    if inc > previousLimit {
                        let taxableAmount = min(inc, limit) - previousLimit
                        tax += taxableAmount * rate
                        previousLimit = limit
                    } else {
                        break
                    }
                }
                taxed = tax
            }

        case "VA":
            // Handle Virginia
            var tax: Double = 0.0
            let brackets: [(limit: Double, rate: Double)] = [
                (3000, 0.02),
                (5000, 0.03),
                (17000, 0.05),
                (Double.infinity, 0.0575)
            ]
            var previousLimit: Double = 0.0
            for (limit, rate) in brackets {
                if Double(tax_inc) > previousLimit {
                    let taxableAmount = min(Double(tax_inc), limit) - previousLimit
                    tax += taxableAmount * rate
                    previousLimit = limit
                } else {
                    break
                }
            }
            taxed = tax
  
        default:
            inc = Double(tax_inc)
        }
        
        var fed_tax = 0.0
        if [0].contains(status) {
            var tax: Double = 0.0
            let brackets: [(limit: Double, rate: Double)] = [
                (11600, 0.10),
                (47150, 0.12),
                (100525, 0.22),
                (191950, 0.24),
                (243725, 0.32),
                (609350, 0.35),
                (Double.infinity, 0.37)
            ]
            var previousLimit: Double = 0.0
            for (limit, rate) in brackets {
                if Double(tax_inc) > previousLimit {
                    let taxableAmount = min( Double(tax_inc), limit) - previousLimit
                    tax += taxableAmount * rate
                    previousLimit = limit
                } else {
                    break
                }
            }
            fed_tax = tax
         }
        else if [3].contains(status) {
            var tax: Double = 0.0
            let brackets: [(limit: Double, rate: Double)] = [
                (23300, 0.10),
                (94300, 0.12),
                (201050, 0.22),
                (383900, 0.24),
                (487450, 0.32),
                (731200, 0.35),
                (Double.infinity, 0.37)
            ]
            var previousLimit: Double = 0.0
            for (limit, rate) in brackets {
                if  Double(tax_inc) > previousLimit {
                    let taxableAmount = min( Double(tax_inc), limit) - previousLimit
                    tax += taxableAmount * rate
                    previousLimit = limit
                } else {
                    break
                }
            }
            fed_tax = tax
         }
        else if [2].contains(status) {
            var tax: Double = 0.0
            let brackets: [(limit: Double, rate: Double)] = [
                (11600, 0.10),
                (47150, 0.12),
                (100525, 0.22),
                (191950, 0.24),
                (243725, 0.32),
                (365600, 0.35),
                (Double.infinity, 0.37)
            ]
            var previousLimit: Double = 0.0
            for (limit, rate) in brackets {
                if  Double(tax_inc) > previousLimit {
                    let taxableAmount = min( Double(tax_inc), limit) - previousLimit
                    tax += taxableAmount * rate
                    previousLimit = limit
                } else {
                    break
                }
            }
            fed_tax = tax
        }
        else if [1].contains(status) {
            var tax: Double = 0.0
            let brackets: [(limit: Double, rate: Double)] = [
                (16550, 0.10),
                (63100, 0.12),
                (100500, 0.22),
                (191950, 0.24),
                (243700, 0.32),
                (609350, 0.35),
                (Double.infinity, 0.37)
            ]
            var previousLimit: Double = 0.0
            for (limit, rate) in brackets {
                if  Double(tax_inc) > previousLimit {
                    let taxableAmount = min( Double(tax_inc), limit) - previousLimit
                    tax += taxableAmount * rate
                    previousLimit = limit
                } else {
                    break
                }
            }
            
            fed_tax = tax
        }
        let remaining = Double(gross) - taxed - fed_tax
        print(taxed)
        print(fed_tax)
        income.text = "$" + String((remaining/12).truncate(places:2))
        UserDefaults.standard.set(remaining/12, forKey: "finalIncome")


        
        
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
