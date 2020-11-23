//
//  CategoryItem.swift
//  Melody
//
//  Created by Albert Kornas on 11/21/20.
//

import SwiftUI

struct CategoryItem: View {

    @ObservedObject var artworkLoader: WebImageLoader
    @State var artworkImage:UIImage = UIImage()
    var song: Song
    
    init(withArtworkURL url:String, withSong: Song) {
        artworkLoader = WebImageLoader(unformattedString: url)
        self.song = withSong
    }
    
    var body: some View {
        Image(uiImage: artworkImage)
            .renderingMode(.original)
            .resizable()
            .scaledToFill()
            .frame(width: frameSize, height: frameSize)
            .cornerRadius(5)
            .onReceive(artworkLoader.didChange) { data in
                self.artworkImage = UIImage(data: data) ?? UIImage()
            }
    }
    let frameSize : CGFloat = 155
}

