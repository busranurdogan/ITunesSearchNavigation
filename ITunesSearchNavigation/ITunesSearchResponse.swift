
import Foundation

struct ITunesSearchResponse: Codable {
    let resultCount: Int
    let results : [Results]
}

struct Results : Codable {
    let artistName : String?
    let collectionName : String?
    let trackPrice: Double?
    let artworkUrl100 : String?
}
