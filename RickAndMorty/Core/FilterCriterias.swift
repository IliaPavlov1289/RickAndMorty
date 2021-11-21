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
        [FilterCriteria(sectionName: "Name", sectionNamber: 0, title: "Name", isSelected: false, subtitle: "Give a name")],
        [FilterCriteria(sectionName: "Species", sectionNamber: 1, title: "Species", isSelected: false, subtitle: "Select one")],
        [FilterCriteria(sectionName: "Status", sectionNamber: 2, title: "Alive", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Status", sectionNamber: 2, title: "Dead", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Status", sectionNamber: 2, title: "Unknown", isSelected: false, subtitle: nil)],
        [FilterCriteria(sectionName: "Gender", sectionNamber: 3, title: "Female", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Gender", sectionNamber: 3, title: "Male", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Gender", sectionNamber: 3, title: "Genderless", isSelected: false, subtitle: nil),
        FilterCriteria(sectionName: "Gender", sectionNamber: 3, title: "Unknown", isSelected: false, subtitle: nil)]
    ]
    
    private init () {
        
    }
}
