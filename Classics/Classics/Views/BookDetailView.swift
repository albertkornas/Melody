//
//  BookDetailView.swift
//  Classics
//
//  Created by Albert Kornas on 10/21/20.
//

import SwiftUI

struct BookDetailView: View {
    @Binding var book: Book
    var body: some View {
        VStack {
            //Toggle whether or not they are currently reading the book
            /*Button(action: {self.book.read.toggle()}) {
                Text(book.read ? "Mark as Read" : "Mark as Unread")
                    .padding()
                    .foregroundColor(book.read ? .red : .blue)
            }*/
            Text("HI")
            //Update progress by entering # of the page they are currently on
            
            //Add, edit, delete notes for a book, which stores the metadata
            //Time the note was created (Date object)
            //Users progress in the book at the time the note was created
            
            //Each note should appear in a DisclosureGroup
            //label displays the formatted date and progress
            //Content is a View that displayhs the text content of the note
        }
    }
}
