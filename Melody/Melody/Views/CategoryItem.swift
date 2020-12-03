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
    let frameSize : CGFloat
    
    init(withArtworkURL url:String, withSize frameSize: CGFloat) {
        self.frameSize = frameSize
        artworkLoader = WebImageLoader(unformattedString: url)
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
    
}

