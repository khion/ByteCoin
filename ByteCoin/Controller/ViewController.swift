//
//  ViewController.swift
//  ByteCoin
//
//  Created by Rodnick Gayem on 2022-10-24.
//

import UIKit

class ViewController: UIViewController {
    
    var coinManager = CoinManager()
    


    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        coinManager.delegate = self
    }
    



}

//MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate {
    func didUpdateBitcoin(_ coinManger: CoinManager, coin: CoinModel) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = coin.rateString
            self.currencyLabel.text = coin.currency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}


//MARK: - UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return coinManager.currencyArray.count
    }
}

//MARK: - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedCurrency = coinManager.currencyArray[row]
        
        coinManager.getCoinPrice(for: selectedCurrency)
    }

}
