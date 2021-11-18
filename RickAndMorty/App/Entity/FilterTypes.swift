//
//  FilterTypes.swift
//  RickAndMorty
//
//  Created by Илья Павлов on 08.11.2021.
//

import Foundation

struct FilterType {
    let title: String
    let subtitle: String
    var isSelected: Bool
}

struct RadioButtonType {
    let title: String
    var params: [RadioButtonParamType]
}

struct RadioButtonParamType {
    let label: String
    var isSelected: Bool
}

class FilterCriteria {
    let sectionName: String
    let sectionNamber: Int
    let title: String
    var isSelected: Bool
    let subtitle: String?
    
    init(sectionName:String, sectionNamber: Int, title:String, isSelected:Bool ,subtitle: String?){
        self.sectionName = sectionName
        self.sectionNamber = sectionNamber
        self.title = title
        self.isSelected = isSelected
        self.subtitle = subtitle
    }
}
