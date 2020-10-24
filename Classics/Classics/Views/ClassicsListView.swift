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
    @State private var viewType: Bool = false

    let columns = [GridItem(.adaptive(minimum: 80))]

    var body: some View {
        if (viewType == false) {
            List {
                collectionView(classicModel: _classicModel, filterType: filterType, viewType: viewType)
            }
            .navigationBarTitle("Classics", displayMode: .inline)
            .navigationBarItems(leading:
                                    Button(action: {self.viewType.toggle()}) {Text("Toggle Grid")}
                ,trailing:
                     Picker(selection: $filterType, label: Text("Filter")) {
                         ForEach(FilterType.allCases) { filter in
                             Text(filter.rawValue).tag(filter as FilterType?)
                         }
                    }.pickerStyle(MenuPickerStyle()))
        } else {
            ScrollView {
                LazyVGrid(columns: columns) {
                    collectionView(classicModel: _classicModel, filterType: filterType, viewType: viewType)
                }
            }
            .navigationBarTitle("Classics", displayMode: .inline)
            .navigationBarItems(leading:
                                    Button(action: {self.viewType.toggle()}) {Text("Toggle Grid")}
                ,trailing:
                     Picker(selection: $filterType, label: Text("Filter")) {
                         ForEach(FilterType.allCases) { filter in
                             Text(filter.rawValue).tag(filter as FilterType?)
                         }
                    }.pickerStyle(MenuPickerStyle()))
        }
    }
 
            
    
    
    
    func sectionTitles() -> [String] {
        return FilterType.allCases.map{$0.rawValue}
    }
    
    // generate a filter (predicate function) that tests whether a Pokemon belongs in the section with title sectionTitle

}

struct collectionView: View {
    @EnvironmentObject var classicModel : ClassicModel
    let filterType: FilterType?
    let viewType: Bool
    var body: some View {
        if (filterType == nil || filterType!.rawValue == "All") {
        ForEach(classicModel.classics.indices, id:\.self) {index in
            NavigationLink(destination: BookDetailView(classicsModel: classicModel, book: self.$classicModel.classics[index], ind: index)) {
                BookRowView(book: classicModel.classics[index], showingGrid: viewType)
            }.id(index)
        }
        } else if (filterType!.rawValue == "Completed Books") { //Completed books filter
            
            ForEach(classicModel.classics.indices, id:\.self) {index in
                if (classicModel.classics[index].read == true) {
                NavigationLink(destination: BookDetailView(classicsModel: classicModel, book: self.$classicModel.classics[index], ind: index)) {
                    BookRowView(book: classicModel.classics[index], showingGrid: viewType)
                }.id(index)
                }
            }
        } else if (filterType!.rawValue == "Currently Reading") { //Currently reading book filter
            
            ForEach(classicModel.classics.indices, id:\.self) {index in
                if (classicModel.classics[index].pageNum > 0 && classicModel.classics[index].read == false) {
                NavigationLink(destination: BookDetailView(classicsModel: classicModel, book: self.$classicModel.classics[index], ind: index)) {
                    BookRowView(book: classicModel.classics[index], showingGrid: viewType)
                }.id(index)
                }
            }
        }
    }
}


struct BookRowView : View {
    let book : Book
    let showingGrid: Bool
    var body: some View {
        if (showingGrid == false) {
            Text(book.title)
        } else {
            VStack {
                Image(String(book.image))
                .resizable()
                .frame(width: frameSize, height: frameSize)
                .cornerRadius(5)
                Text(book.title)
                    .multilineTextAlignment(.center)
            }
                
        }
    }
    let frameSize: CGFloat = 60
}


