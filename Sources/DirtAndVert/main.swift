import Foundation
import Publish
import Plot

//TODO: prelaunch tasks
// copy and image(s) for about
// tidy up source code
// buy domain
// check article copy

//TODO: medium term
// better img hosting solution
// add support for tags

struct DirtAndVert: Website {
    
    enum SectionID: String, WebsiteSectionID {
        case posts
        case about
    }

    struct ItemMetadata: WebsiteItemMetadata {
    }

    var url = URL(string: "https://your-website-url.com")!
    var name = "DIRT & VERT"
    var description = "Adventures in trail and ultra running"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

try DirtAndVert().publish(withTheme: .ultra)
