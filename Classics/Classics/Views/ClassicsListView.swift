//
//  ClassicsListView.swift
//  Classics
//
//  Created by Albert Kornas on 10/21/20.
//

import SwiftUI

struct ClassicsListView: View {
    @EnvironmentObject var classicModel : ClassicModel

    var body: some View {
        List {
            ForEach(classicModel.classics.indices, id:\.self) {index in
                NavigationLink(destination: BookDetailView(classicsModel: classicModel, book: self.$classicModel.classics[index], ind: index)) {
                    BookRowView(book: classicModel.classics[index])
                }.id(index)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BookRowView : View {
    let book : Book
    var body: some View {
        Text(book.title)
    }
}

struct ClassicsListView_Previews: PreviewProvider {
    static var previews: some View {
        ClassicsListView()
    }
}
