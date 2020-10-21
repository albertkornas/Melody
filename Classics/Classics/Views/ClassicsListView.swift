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
                NavigationLink(destination: BookDetailView(book: self.$classicModel.classics[index])) {
                    BookRowView(book: self.$classicModel.classics[index])
                }.id(index)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BookRowView : View {
    @Binding var book : Book
    var body: some View {
        Text(book.title)
    }
}

struct ClassicsListView_Previews: PreviewProvider {
    static var previews: some View {
        ClassicsListView()
    }
}
