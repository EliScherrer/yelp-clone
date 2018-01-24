//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
     
    var businesses: [Business]!
    var filteredBusinesses: [Business]!
    
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //adjust height of rows to respect autoLayout
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        //add a search bar to the navigation controller
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        
        Business.searchWithTerm(term: "Restaurants", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.filteredBusinesses = businesses
            self.tableView.reloadData()
            
            if let businesses = businesses {
                for business in businesses {
//                    print(business.name!)
//                    print(business.address!)
//                    print(business.latitude!)
//                    print(business.longitude!)
                }
            }
            
            }
        )
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: Error!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return filteredBusinesses.count
        }
        else {
            return 0
        }
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BuisinessCell
        
        cell.business = filteredBusinesses[indexPath.row]
        
        return cell
    }
    
    // This method updates filteredBusinesses based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredBusinesses = searchText.isEmpty ? businesses : businesses.filter { (item: Business) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.name?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }

        tableView.reloadData()
    }
    
    
    
    //show cancel button when the user starts typing in the search bar
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    //handle the cancel button onClick
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    //when cell is clicked
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        
        if let indexPath = tableView.indexPath(for: cell ) {
            let business = filteredBusinesses[indexPath.row]
            let detailViewController = segue.destination as! DetailsViewController
            detailViewController.business = business
        }
        
    }
    

    
}
