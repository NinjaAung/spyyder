//
//  StocksVC.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 1/29/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class StocksVC: UIViewController {
//MARK: Properties
    var stocks: [Stock] = []
    
//MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categorieSegmentedControl: UISegmentedControl!
    
//MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
//        segmentedControl.backgroundColor = .red
//        if categorieSegmentedControl.selectedSegmentIndex
        if categorieSegmentedControl.selectedSegmentIndex == 0 {
            categorieSegmentedControl.backgroundColor = .black //set unselected segments's background color
    //        categorieSegmentedControl.ref
            print(categorieSegmentedControl.isSelected)
    //        print(categorieSegmentedControl.isEnabled) //true
            print(categorieSegmentedControl.isHighlighted)
            print(categorieSegmentedControl.isMomentary) //f
            print(categorieSegmentedControl.isTouchInside) //f
            
            categorieSegmentedControl.selectedSegmentTintColor = .red //how you change the selected view's background color
    //        if categorieSegmentedControl.isSelected {
    //            categorieSegmentedControl.backgroundColor = .green
    //        } else { //MARK: For some reason isSelected is always FALSE, why?
    //            categorieSegmentedControl.backgroundColor = .yellow
    //        }
            let attributes = [NSAttributedString.Key.foregroundColor : UIColor.white, ]
//            let attributes = [NSAttributedString.Key.font : UIColor.green,] //MARK: This key.font CRASHES when passed to setTitleAttributes
//            attributes[NSAttributedString.Key.font] = UIColor.green
            categorieSegmentedControl.setTitleTextAttributes(attributes, for: .normal)
//            categorieSegmentedControl.setTitleTextAttributes(attributes + attributes2, for: .normal)
//            categorieSegmentedControl?.setTitleTextAttributes(attributes, [attributes, attributes2], for: .normal)
//            [NSAttributedString.Key.font : .green, NSAttributedString.Key.foregroundColor : UIColor.blue,]
        } else if categorieSegmentedControl.selectedSegmentIndex == 1 {
            categorieSegmentedControl.backgroundColor = .white //should be clear or white
            categorieSegmentedControl.selectedSegmentTintColor = .red
            let attributes = [NSAttributedString.Key.foregroundColor : UIColor.white,] //[NSAttributedString.Key.backgroundColor : .green, NSAttributedString.Key.foregroundColor : UIColor.white,]
            categorieSegmentedControl?.setTitleTextAttributes(attributes, for: .normal)
        } else {
            categorieSegmentedControl.backgroundColor = .green //should be clear or white
            categorieSegmentedControl.selectedSegmentTintColor = .systemPink
            let attributes = [NSAttributedString.Key.foregroundColor : UIColor.white,] //[NSAttributedString.Key.backgroundColor : .green, NSAttributedString.Key.foregroundColor : UIColor.white,]
            categorieSegmentedControl?.setTitleTextAttributes(attributes, for: .normal)
        }
    }
    
//MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case kSEGUETOSTOCKDETAILSVC:
            guard let stock = sender as? Stock else { return }
            let vc: StockDetailsVC = (segue.destination as? StockDetailsVC)!
            vc.stock = stock
        default:
            break
        }
    }
    
//MARK: Private Methods
    fileprivate func setupViews() {
        setupTableView()
        createTestStocks()
    }
    
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView() //removes extra unpopulated cells
    }
    
    fileprivate func createTestStocks() {
        let stock1 = Stock(_name: "Bitcoin", _shortName: "BTC", _price: "8,900", _imageUrl: "")
        let stock2 = Stock(_name: "Etherium", _shortName: "ETH", _price: "80", _imageUrl: "")
        let stock3 = Stock(_name: "Tesla", _shortName: "TSL", _price: "600", _imageUrl: "")
        let stock4 = Stock(_name: "Apple", _shortName: "APL", _price: "8,900", _imageUrl: "")
        let stock5 = Stock(_name: "Bitcoin", _shortName: "BTC", _price: "8,900", _imageUrl: "")
        let stock6 = Stock(_name: "Etherium", _shortName: "ETH", _price: "80", _imageUrl: "")
        let stock7 = Stock(_name: "Tesla", _shortName: "TSL", _price: "600", _imageUrl: "")
        let stock8 = Stock(_name: "Apple", _shortName: "APL", _price: "8,900", _imageUrl: "")
        let stock9 = Stock(_name: "Bitcoin", _shortName: "BTC", _price: "8,900", _imageUrl: "")
        let stock10 = Stock(_name: "Etherium", _shortName: "ETH", _price: "80", _imageUrl: "")
        let stock11 = Stock(_name: "Tesla", _shortName: "TSL", _price: "600", _imageUrl: "")
        let stock12 = Stock(_name: "Apple", _shortName: "APL", _price: "8,900", _imageUrl: "")
        stocks.append(contentsOf: [stock1, stock2, stock3, stock4, stock5, stock6, stock7, stock8, stock9, stock10, stock11, stock12])
    }
    
//MARK: IBActions
    
//MARK: Helpers
    
}

//MARK: Extensions
extension StocksVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let stock = stocks[indexPath.row]
//        self.performSegue(withIdentifier: kSEGUETOSTOCKDETAILSVC, sender: stock)
        self.tableView.beginUpdates()
        let view = UIView(frame: CGRect(x: 10, y: 70, width: self.view.frame.width - 20, height: 200))
        view.backgroundColor = .red
        let cell: StockCell = tableView.cellForRow(at: indexPath) as! StockCell
        cell.addSubview(view)
        self.tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.tableView.indexPathForSelectedRow?.row == indexPath.row {
            return 200 //make cell's height 200 if is selected
        } else {
            return 70
        }
    }
}

extension StocksVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: StockCell = tableView.dequeueReusableCell(withIdentifier: "stockCell") as! StockCell
        cell.selectionStyle = .none //remove the selection indicator
        cell.stock = stocks[indexPath.row]
        cell.populateViews()
        return cell
    }
}
