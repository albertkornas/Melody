//
//  ClassicsListView.swift
//  Classics
//
//  Created by Albert Kornas on 10/21/20.
//

import SwiftUI

struct ClassicsListView: View {
    @EnvironmentObject var classicModel : ClassicModel
    @State private var filterType: FilterType?

    var body: some View {
        List {
            if (filterType == nil || filterType!.rawValue == "All") {
            ForEach(classicModel.classics.indices, id:\.self) {index in
                NavigationLink(destination: BookDetailView(classicsModel: classicModel, book: self.$classicModel.classics[index], ind: index)) {
                    BookRowView(book: classicModel.classics[index])
                }.id(index)
            }
            } else if (filterType!.rawValue == "Completed Books") { //Completed books filter
                
                ForEach(classicModel.classics.indices, id:\.self) {index in
                    if (classicModel.classics[index].read == true) {
                    NavigationLink(destination: BookDetailView(classicsModel: classicModel, book: self.$classicModel.classics[index], ind: index)) {
                        BookRowView(book: classicModel.classics[index])
                    }.id(index)
                    }
                }
            } else if (filterType!.rawValue == "Currently Reading") { //Currently reading book filter
                
                ForEach(classicModel.classics.indices, id:\.self) {index in
                    if (classicModel.classics[index].pageNum > 0 && classicModel.classics[index].read == false) {
                    NavigationLink(destination: BookDetailView(classicsModel: classicModel, book: self.$classicModel.classics[index], ind: index)) {
                        BookRowView(book: classicModel.classics[index])
                    }.id(index)
                    }
                }
            }
        }
        .navigationBarTitle("Classics", displayMode: .inline)
        .navigationBarItems(trailing: Picker(selection: $filterType, label: Text("Filter")) {
                 ForEach(FilterType.allCases) { filter in
                     Text(filter.rawValue).tag(filter as FilterType?)
                 }
            
            }.pickerStyle(MenuPickerStyle()))
    }
    
    func sectionTitles() -> [String] {
        return FilterType.allCases.map{$0.rawValue}
    }
    
    // generate a filter (predicate function) that tests whether a Pokemon belongs in the section with title sectionTitle

    
}

struct BookRowView : View {
    let book : Book
    var body: some View {
        Text(book.title)
    }
}


