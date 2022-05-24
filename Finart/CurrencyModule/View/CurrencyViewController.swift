//
//  CurrencyViewController.swift
//  Finart
//
//  Created by Suren Kazaryan on 16.05.2022.
//

import UIKit

class CurrencyViewController: UIViewController {
    let currencyView = CurrencyView()
    var presenter: CurrencyPresenterProtocol?
    let currencyArr: [CurrencyViewModel] = [
        CurrencyViewModel(shortName: "RUB", name: "Российский рубль", symbol: "₽"),
        CurrencyViewModel(shortName: "USD", name: "Американский доллар", symbol: "$"),
        CurrencyViewModel(shortName: "EUR", name: "Евро", symbol: "€"),
        CurrencyViewModel(shortName: "AMD", name: "Армянский драм", symbol: "֏"),
    ]
    
    override func loadView() {
        super.loadView()
        view = currencyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

//MARK: - Private methods
extension CurrencyViewController {
    private func setup() {
        currencyView.currencyTableView.register(CurrencyCell.self, forCellReuseIdentifier: "CurrencyCell")
        currencyView.currencyTableView.dataSource = self
        currencyView.currencyTableView.delegate = self
    }
}

//MARK: - UITableViewDataSource
extension CurrencyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencyArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as? CurrencyCell else { return UITableViewCell() }
        //let name = currencyArr[indexPath.row].name
        cell.updateCell(name: currencyArr[indexPath.row].name,
                        shortName: currencyArr[indexPath.row].shortName,
                        currencySymbol: currencyArr[indexPath.row].symbol,
                        isCurrent: false)
        return cell
    }
    
}

//MARK: - UITableViewDelegate
extension CurrencyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = view.frame.width / 9
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.delegate?.didChooseCurrency(currencyName: currencyArr[indexPath.row].shortName)
        presenter?.router?.dismissCurrency(from: self, completion: nil)
    }
    
}

//MARK: - CurrencyViewProtocol
extension CurrencyViewController: CurrencyViewProtocol {
}
