
import Foundation
import Publish
import Plot

public extension Theme {
    static var ultra: Self {
        Theme(
            htmlFactory: UltraHTMLFactory(),
            resourcePaths: ["/Resources/ultra/styles.css"]
        )
    }
}

private struct UltraHTMLFactory<Site: Website>: HTMLFactory {
    func makeIndexHTML(for index: Index,
                       context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site),
            .body {
                SiteHeader(context: context, selectedSelectionID: nil)
                Wrapper {
                    ItemList(
                        items: context.allItems(
                            sortedBy: \.date,
                            order: .descending
                        ),
                        site: context.site
                    )
                }
                SiteFooter()
            }
        )
    }

    func makeSectionHTML(for section: Section<Site>,
                         context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .body {
                SiteHeader(context: context, selectedSelectionID: section.id)
                Wrapper {
                    H1(section.title)
                    ItemList(items: section.items, site: context.site)
                }
                SiteFooter()
            }
        )
    }

    func makeItemHTML(for item: Item<Site>,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site),
            .body(
                .class("item-page"),
                .components {
                    SiteHeader(context: context, selectedSelectionID: item.sectionID)
                    Wrapper {
                        Article {
                            Div(item.content.body).class("content")
                        }
                    }
                    SiteFooter()
                }
            )
        )
    }

    func makePageHTML(for page: Page,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body {
                SiteHeader(context: context, selectedSelectionID: nil)
                Wrapper(page.body)
                SiteFooter()
            }
        )
    }

    func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<Site>) throws -> HTML? {
        nil
    }

    func makeTagDetailsHTML(for page: TagDetailsPage,
                            context: PublishingContext<Site>) throws -> HTML? {
       nil
    }
}

private struct Wrapper: ComponentContainer {
    @ComponentBuilder var content: ContentProvider

    var body: Component {
        Div(content: content).class("wrapper")
    }
}

private struct SiteHeader<Site: Website>: Component {
    var context: PublishingContext<Site>
    var selectedSelectionID: Site.SectionID?

    var body: Component {
        Header {
            Wrapper {
                Link(url: "/") {
                    Image(url: URL(string: "/images/logo.png")!, description: "Dirt and Vert")
                }
                if Site.SectionID.allCases.count > 1 {
                    navigation
                }
            }
        }
    }

    private var navigation: Component {
        Navigation {
            List(Site.SectionID.allCases) { sectionID in
                let section = context.sections[sectionID]
                var url = section.path.absoluteString
                if url == "/posts" {
                    url = "/"
                }
                return Link(section.title, url: url)
                .class(sectionID == selectedSelectionID ? "selected" : "")
            }
        }
    }
}

private struct ItemList<Site: Website>: Component {
    var items: [Item<Site>]
    var site: Site

    var body: Component {
        let group = ComponentGroup {
            for item in items {
                let itemUrl = item.path.absoluteString
                let imageUrl = URL(string: item.imagePath!.string)!
                let imageDecription = item.description
                Link(url: itemUrl) {
                    Div {
                        Image(url: imageUrl, description: imageDecription)
                        H1(item.title)
                        H2(item.date.asText)
                    }
                    .class("grid-item")
                }
            }
        }
        
        return Div(group)
            .class("grid-container")
    }
}

private struct SiteFooter: Component {
    var body: Component {
        Footer {
            Paragraph {
                Text("Follow on ")
                Link("Instagram", url: "https://www.instagram.com/run.greg.run/")
                    .attribute(named: "target", value: "_blank")
                Text(" and ")
                Link("Strava", url: "https://www.strava.com/athletes/2722084")
                    .attribute(named: "target", value: "_blank")
            }
            Paragraph {
                Link("RSS feed", url: "/feed.rss")
            }
        }
    }
}

extension Date {
    var asText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM, yyyy"
        let dateString = formatter.string(from: self)
        return dateString
    }
}
