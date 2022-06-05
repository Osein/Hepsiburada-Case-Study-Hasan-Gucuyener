//
//  EntLocalization.swift
//  EntCore
//
//  Created by Hasolas on 5.06.2022.
//

import Foundation

public class EntLocalization {
    private static func localize(string: String) -> String {
        let bundle = Bundle(identifier: "com.osein.casestudy.entities.EntCore")
        return NSLocalizedString(string, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
    public static var networkConnectionWarningText = EntLocalization.localize(string: "global_network_connection_warning")
    
    public class EntityListScreen {
        public static var pleaseWriteSomethingToSearch = EntLocalization.localize(string: "entity_list__please_write_something_to_search")
        public static var noResultsForYourSearch = EntLocalization.localize(string: "entity_list__no_results_for_your_search")
    }
    
}
