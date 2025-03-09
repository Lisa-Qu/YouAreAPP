import SwiftUI

/// Represents one block (slide) in the animated carousel view.
struct CarouselBlock: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let slideImage: Image
    let detailImage: Image
    let color: Color
}

import SwiftUI

//// Global helper function
//func xcAssetImage(_ name: String) -> Image {
//    if let uiImage = loadXCAssetUIImage(named: name) {
//        return Image(uiImage: uiImage)
//    } else {
//        return Image(systemName: "exclamationmark.triangle")
//    }
//}
//
//private func loadXCAssetUIImage(named name: String) -> UIImage? {
//    let subdirectory = "Assets.xcassets/\(name).imageset"
//    guard let fileURL = Bundle.module.url(forResource: name, withExtension: "jpg", subdirectory: subdirectory) else {
//        return nil
//    }
//    guard let data = try? Data(contentsOf: fileURL),
//          let uiImage = UIImage(data: data) else {
//        return nil
//    }
//    return uiImage
//}

/// Data storage for all carousel blocks.
/// Use `xcAssetImage(_:)` to load images from the .xcassets folder.
struct CarouselBlockData {

    static let blocks: [CarouselBlock] = [
        CarouselBlock(
            title: "You Can Be Anyone",
            subtitle: """
                Believe that you can change. 
                Don't be discouraged by others' comments, doubts, or judgments. 
                YouAre App is here to support your growth and provide evidence whenever you feel discouraged.
                """,
            slideImage: Image("blue", bundle: .module),
            detailImage: Image("blue", bundle: .module),
            color: .blue
        ),
        
        CarouselBlock(
            title: "Loved Ones",
            subtitle: """
                If you have family, friends, and relationships—those who love you—you're lucky. 
                However, no matter how close you are, always be yourself. Don't be what others want you to be.
                """,
            slideImage: Image("purple", bundle: .module),
            detailImage: Image("purple", bundle: .module),
            color: .purple
        ),
        
        CarouselBlock(
            title: "LGBTQ+",
            subtitle: """
                Everyone has the freedom to be themselves, including who they love. 
                Don't feel ashamed just because you are different.
                """,
            slideImage: Image("yellow", bundle: .module),
            detailImage: Image("yellow", bundle: .module),
            color: .yellow
        ),
        
        CarouselBlock(
            title: "Be Yourself",
            subtitle: """
                Only you know yourself best. 
                Look in the mirror, and remember 
                you don't have to be what others think you should. 
                Be who you want to be.
                """,
            slideImage: Image("orange", bundle: .module),
            detailImage: Image("orange", bundle: .module),
            color: .orange
        ),
        
        CarouselBlock(
            title: "You are Beautiful/Handsome",
            subtitle: """
                Please don't worry about others' beauty standards. 
                Your beauty is defined by you alone. 
                Stop judging yourself by others' opinions.
                """,
            slideImage: Image("green", bundle: .module),
            detailImage: Image("green", bundle: .module),
            color: .green
        ),
        
        CarouselBlock(
            title: "My Story",
            subtitle: """
                Hi there 🙋‍♀️! You can call me Piggy 🐷!

                Pig is how I symbolize myself: it's cute but easily influenced by others. I used to define myself by what others thought I should be. I used to be an obedient daughter who would do things for my parents even when I didn't want to, always putting their wishes first.

                Everything changed when I went to college. I reflected on myself and realized my own expectations contradicted my parents' wishes. They expected me to live near them and fully care for them when they grew old. But I wanted to have my own business. I didn't want to remain the "cute pig" who did nothing but stay near my parents. I wanted to be strong and independent. So I changed...

                I know how hard it is to follow your own desires, especially if you're too influenced by others. The reason I built this app is because I realized how important it is to note down evidence that supports your goals. Being yourself requires encouragement and support. Most of the time, others can't fully be there for you.

                This app helps you keep track of each step you take toward your goal. Whenever you feel sad, discouraged, or doubtful about yourself, open this app—it will provide everything you need.
                """,
            slideImage: Image("red", bundle: .module),
            detailImage: Image("red", bundle: .module),
            color: .red
        )
    ]
}
