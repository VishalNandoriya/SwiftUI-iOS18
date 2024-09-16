//
//  ContentView.swift
//  SwiftUI-iOS18
//
//  Created by Vishal Nandoriya on 16/09/24.
//

import SwiftUI

struct ZoomTransitions: View {
    @Namespace private var animation
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 6), count: 2), spacing: 10) {
                    ForEach(imageList) { item in
                        NavigationLink(value: item) {
                            GeometryReader {
                                let size = $0.size
                                
                                if let image = item.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: size.width, height: size.height)
                                        .clipShape(.rect(cornerRadius: 5))
                                        .matchedTransitionSource(id: item, in: animation)
                                }
                            }.frame(height: 100)
                        }
                        .contentShape(.rect(cornerRadius: 20))
                        .buttonStyle(.plain)
                    }
                }
            }.padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .navigationTitle("List")
                .navigationDestination(for: ImageItem.self) { item in
                    GeometryReader {
                        let size = $0.size
                        
                        if let image = item.image {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
                                .clipShape(.rect(cornerRadius: 5))
                        }
                    }.padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .navigationTitle(item.title)
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationTransition(.zoom(sourceID: item, in: animation))
                    
                }
        }
    }
}

struct ImageItem: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var title: String
    var image: UIImage?
}

var imageList: [ImageItem] {
    return (1..<7).map { index in
        ImageItem(title: "Image-\(index)", image: UIImage(named: "image-\(index)"))
    }
}


#Preview {
    ZoomTransitions()
}
