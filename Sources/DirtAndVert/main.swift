import Foundation
import Publish
import Plot

//TODO:
// tidy up source code
// better img hosting solution
// add support for tags

struct DirtAndVert: Website {
    
    enum SectionID: String, WebsiteSectionID {
        case posts
        case about
    }

    struct ItemMetadata: WebsiteItemMetadata {
    }

    var url = URL(string: "https://dirtandvert.run")!
    var name = "DIRT & VERT"
    var description = "Adventures in trail and ultra running"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

try DirtAndVert().publish(withTheme: .ultra)
