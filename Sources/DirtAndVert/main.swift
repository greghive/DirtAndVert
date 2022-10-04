import Foundation
import Publish
import Plot

//TODO: prelaunch tasks
// header logo as link
// create about page
// create header links
// create footer with links to insta + strava
// create images for first post
// deal with < 3 posts on home page
// tidy up source code
// buy domain
// check article copy

//TODO: medium term
// better img hosting solution
// add support for tags

// This type acts as the configuration for your website.
struct DirtAndVert: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://your-website-url.com")!
    var name = "DIRT & VERT"
    var description = "Adventures in trail and ultra running"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

// This will generate your website using the built-in Foundation theme:
try DirtAndVert().publish(withTheme: .ultra)
