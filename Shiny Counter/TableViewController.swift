//
//  TableViewController.swift
//  UISearchBar Demo
//
//  Created by William Donnelly on 1/17/19.
//  Copyright © 2019 William Donnelly. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchResultsUpdating {
    
    //=========================================================================//
    //Part 1: Creating Variables.
    
    var array = ["Full Odds", "DexNav", "S.O.S.", "Masuda", "Chain Fishing", "Horde Hunting", "PokeRader"]
    var filteredArray = [String]()
    var searchController = UISearchController()
    
    //=========================================================================//
    
    var resultsController = UITableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //=========================================================================//
        //Part 2: Initializing Variables.
        
        searchController = UISearchController(searchResultsController: resultsController)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        
        //=========================================================================//
        
        resultsController.tableView.delegate = self
        resultsController.tableView.dataSource = self
    }
    
    //=========================================================================//
    //Part 3: Searching
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredArray = []
        for element in array{
            if(element.contains(searchController.searchBar.text!)){
                filteredArray.append(element)
            }
        }
        resultsController.tableView.reloadData()
    }
    
    //=========================================================================//
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == resultsController.tableView{
            
            //=========================================================================//
            //Part 4: Updating the results.
            
            return filteredArray.count
            
            //=========================================================================//
            
        }
        else{
            
            //=========================================================================//
            //Part 4 Continued.
            
            return array.count
            
            //=========================================================================//
            
        }
        //remove this return 0 statement after finishing part 4
        //return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if tableView == resultsController.tableView{
            
            //=========================================================================//
            //Part 4 Continued.
            
            cell.textLabel?.text = filteredArray[indexPath.row]
            //=========================================================================//
            
        }
        else{
            
            //=========================================================================//
            //Part 4 Continued.
            
            cell.textLabel?.text = array[indexPath.row]
            
            //=========================================================================//
            
        }
        return cell
    }
}
