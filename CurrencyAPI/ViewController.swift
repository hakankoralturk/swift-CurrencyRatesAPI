//
//  ViewController.swift
//  CurrencyAPI
//
//  Created by Hakan Koraltürk on 3.07.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblCad: UILabel!
    @IBOutlet weak var lblEur: UILabel!
    @IBOutlet weak var lblGbp: UILabel!
    @IBOutlet weak var lblJpy: UILabel!
    @IBOutlet weak var lblUsd: UILabel!
    
    var apiUrl = "http://api.frankfurter.app/latest?from=TRY"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func clickGetRates(_ sender: Any) {
        
        // 1. Request & Session
        // 2. Response & Data
        // 3. Parsing & JSON Serialization
        
        let url = URL(string: apiUrl)
        
        let session = URLSession.shared
        
        
        // 1.
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "Api Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                
                self.present(alert, animated: true, completion: nil)
            } else {
                // 2.
                if data != nil {
                    do {
                        let response = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        // ASYNC
                        DispatchQueue.main.async {
                            if let rates = response["rates"] as? [String : Any] {
                                if let cad = rates["CAD"] as? Double {
                                    self.lblCad.text = "CAD: \(cad)"
                                }
                                
                                if let eur = rates["EUR"] as? Double {
                                    self.lblEur.text = "EUR: \(eur)"
                                }
                                
                                if let gbp = rates["GBP"] as? Double {
                                    self.lblGbp.text = "GBP: \(gbp)"
                                }
                                
                                if let jpy = rates["JPY"] as? Double {
                                    self.lblJpy.text = "JPY: \(jpy)"
                                }
                                
                                if let usd = rates["USD"] as? Double {
                                    self.lblUsd.text = "USD: \(usd)"
                                }
                            }
                        }
                        
                    } catch {
                        print("error")
                    }
                }
            }
        }
        
        task.resume()
        
    }
    
}

