//
//  FilterCriterias.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 14.11.2021.
//

import Foundation

class FilterCriterias {
    
    public static let shared = FilterCriterias()
    
    var charactersFilterCriterias = [
        [FilterCriteria(sectionName: "Name", title: "Name", param: nil, isSelected: false, subtitle: "Give a name")],
        [FilterCriteria(sectionName: "Species", title: "Species", param: nil, isSelected: false, subtitle: "Select one")],
        [FilterCriteria(sectionName: "Status", title: "Alive", param: "Alive", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Status", title: "Dead", param: "Dead", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Status", title: "Unknown", param: "Unknown", isSelected: false, subtitle: nil)],
        [FilterCriteria(sectionName: "Gender", title: "Female", param: "Female", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Gender", title: "Male", param: "Male", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Gender", title: "Genderless", param: "Genderless", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Gender", title: "Unknown", param: "Unknown", isSelected: false, subtitle: nil)]
    ]
    
    private init () {
        
    }
}
