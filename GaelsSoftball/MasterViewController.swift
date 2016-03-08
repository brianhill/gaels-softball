//
//  MasterViewController.swift
//  GaelsSoftball
//
//  Created by Brian Hill on 3/3/16.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var allGames: [Game] = softballGames()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let game = allGames[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = game
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View Data Source 
    
    // See https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITableViewDataSource_Protocol/

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGames.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let game = allGames[indexPath.row]
        
        let locationType = game.locationType
        
        let textLabelText = "\(game.summary) at \(locationType.rawValue)"
        cell.textLabel!.text = textLabelText
        
        // See https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITableViewCell_Class
        
        switch locationType {
        case LocationType.Home:
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        default:

            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    // MARK: - Table View Delegate
    
    // See https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITableViewDelegate_Protocol/
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        let game = allGames[indexPath.row]
        let locationType = game.locationType
        switch locationType {
        case LocationType.Home:
            return indexPath
        default:
            return nil
        }
    }

}

