//
//  BookDetailView.swift
//  Classics
//
//  Created by Albert Kornas on 10/21/20.
//

import SwiftUI

struct BookDetailView: View {
    var classicsModel : ClassicModel
    
    @Binding var book: Book
    @State private var pageNumber: String = ""
    @State private var notes: String = ""
    @State private var topExpanded: Bool = true
    @State private var toggleOne: Bool = false
    @State private var editingNoteContent: String = ""
    @Environment(\.editMode) var editMode
    
    let ind: Int
    var body: some View {
        
        VStack {
            //Toggle whether or not they are currently reading the book
            
            Form{
                Image(book.image)
                
                Button(action: {self.book.read.toggle()}) {
                    Text(book.read ? "Mark as Not Reading" : "Mark as Reading")
                        .padding()
                        .foregroundColor(book.read ? .green : .red)
                }
                
                Section(header: Text("Progress")) {
                    Text("On page \(book.pageNum)/\(book.pages)")
                    TextField("Edit Page Number", text: $pageNumber, onEditingChanged: { _ in
                                let newPageNumber = Int(pageNumber)
                                print("Hey")
                                if (book.pageNum < newPageNumber ?? book.pageNum) {
                                    book.pageNum = newPageNumber!
                                } })
                        .disabled(self.editMode?.wrappedValue == .inactive)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("Add a Note")) {
                    TextEditor(text: $notes)
                    Button("Add") {
                        if (notes != "") {
                            let currentTime = Date()
                            let note = Note(progress: book.pageNum, content: notes, date: currentTime)
                            classicsModel.addNote(index: ind, newNote: note, date: Date())
                        }
                    }
                }
                
                Section(header: Text("Notes")) {
                    ForEach (book.notes.indices.reversed(), id: \.self) {index in
                    DisclosureGroup("Page \(book.notes[index].progress) on \(classicsModel.dateFormatter.string(from: book.notes[index].date ?? Date()+50000))", isExpanded: $topExpanded) {
                        Button("Delete") {
                            classicsModel.deleteNote(bookIndex: ind, noteIndex: index)
                        }
                            TextEditor(text: $book.notes[index].content)
                                .padding()
                                    .disabled(self.editMode?.wrappedValue == .inactive)
                        }
                    }
                }
            }.navigationTitle(Text(book.title))
            .navigationBarBackButtonHidden(editMode?.wrappedValue.isEditing ?? false)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            //Add, edit, delete notes for a book, which stores the metadata
            //Time the note was created (Date object)
            //Users progress in the book at the time the note was created
            
            //Each note should appear in a DisclosureGroup
            //label displays the formatted date and progress
            //Content is a View that displayhs the text content of the note
        }
    }
}
