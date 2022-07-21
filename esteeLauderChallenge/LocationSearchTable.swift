//
//  LocationSearchTable.swift
//  esteeLauderChallenge
//
//  Created by Alex Markova on 7/20/22.
//

import UIKit
import MapKit

class LocationSearchTable : UITableViewController {
    var handleMapSearchDelegate:HandleMapSearch? = nil
    var matchingItems:[MKMapItem] = [] // use later on to stash search results for easy access.
    var mapView: MKMapView? = nil // Search queries rely on a map region to prioritize local results. The is a handle to the map from the previous screen.
    
    func parseAddress(selectedItem:MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine // in the previous example it would return: 4 Melrose Place, Washington DC”.
    }
}

extension LocationSearchTable : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView, // unwraps mapView text
              let searchBarText = searchController.searchBar.text else { return }
//                searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request() // search request comprised of search string (searchBarText) and a map region (mapView) that provides location context
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request) // performs actual search
        search.start{ response, _ in
            // executes the search query and returns a MKLocalSearchResponse object which contains an array of mapItems.
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems // stash these mapItems inside matchingItems
            self.tableView.reloadData() // reload the table
        }
    }
}

extension LocationSearchTable {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    // removed override keyword because I got error "method does not override any method from its superclass"
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let selectedItem = matchingItems[indexPath.row].placemark // determines the number of rows
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = parseAddress(selectedItem:selectedItem)

        return cell
    }
}
extension LocationSearchTable { // groups UITableViewDelegate methods together
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        handleMapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
        dismiss(animated: true, completion: nil)
    }
}
