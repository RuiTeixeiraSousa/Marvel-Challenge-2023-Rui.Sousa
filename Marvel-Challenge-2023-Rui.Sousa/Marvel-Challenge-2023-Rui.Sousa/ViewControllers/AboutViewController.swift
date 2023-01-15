//
//  AboutViewController.swift
//  Marvel-Challenge-2023-Rui.Sousa
//
//  Created by Rui Sousa on 13/01/2023.
//

import UIKit

class AboutViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTable()
    }
    
    // MARK: - Table view data source
    func registerTable() {
        tableView.register(UINib(nibName: "AboutOverviewTableViewCell", bundle: nil), forCellReuseIdentifier: "AboutOverviewTableViewCell")
        tableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionTableViewCell")
        tableView.register(UINib(nibName: "TopSellingItemsTableViewCell", bundle: nil), forCellReuseIdentifier: "TopSellingItemsTableViewCell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "About This APP"
        } else if section == 1 {
            return "We can be heroes"
        }else if section == 2 {
            return "Overview"
        } else {
            return "Top Selling Items"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 50
        default:
            return 30
        }
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        if section == 0 {
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 30)
            header.textLabel?.textColor = .black
        } else {
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 25)
            header.textLabel?.textColor = .black
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            // Return a cell for the first section
            return UITableViewCell()
        case 1:
            if indexPath.row == 0 {
                guard let cell2 = tableView.dequeueReusableCell(withIdentifier: "AboutOverviewTableViewCell",for: indexPath) as? AboutOverviewTableViewCell else { return UITableViewCell() }
                return cell2
            } else {
                print("Error")
            }
        case 2:
            if indexPath.row == 0 {
                guard let cell2 = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell",for: indexPath) as? DescriptionTableViewCell else { return UITableViewCell() }
                return cell2
            } else {
                print("Error")
            }
        case 3:
            if indexPath.row == 0 {
                guard let cell3 = tableView.dequeueReusableCell(withIdentifier: "TopSellingItemsTableViewCell",for: indexPath) as? TopSellingItemsTableViewCell else { return UITableViewCell() }
                return cell3
            } else {
                print("Error")
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
}
