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
    let title: String
    var param: String?
    var isSelected: Bool
    var subtitle: String?
    
    init(sectionName:String, title:String, param:String?, isSelected:Bool ,subtitle: String?){
        self.sectionName = sectionName
        self.title = title
        self.param = param
        self.isSelected = isSelected
        self.subtitle = subtitle
    }
}
