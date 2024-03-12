import Foundation

struct MovieImageDTO: Decodable {
    let documents: [DocumentDTO]
    let meta: MetaDTO
}

extension MovieImageDTO {
    struct DocumentDTO: Decodable {
        let collection: String
        let datetime: String
        let displaySitename: String
        let docURL: String
        let height: Int
        let imageURL: String
        let thumbnailURL: String
        let width: Int
        
        enum CodingKeys: String, CodingKey {
            case collection, datetime
            case displaySitename = "display_sitename"
            case docURL = "doc_url"
            case height
            case imageURL = "image_url"
            case thumbnailURL = "thumbnail_url"
            case width
        }
    }
}

extension MovieImageDTO {
    struct MetaDTO: Decodable {
        let isEnd: Bool
        let pageableCount: Int
        let totalCount: Int
        
        enum CodingKeys: String, CodingKey {
            case isEnd = "is_end"
            case pageableCount = "pageable_count"
            case totalCount = "total_count"
        }
    }
}

extension MovieImageDTO {
    func toModel() -> MovieImage {
        return .init(documents: self.documents.map { $0.toModel() }, meta: MovieImageMeta(from: self.meta))
    }
}

extension MovieImageDTO.DocumentDTO {
    func toModel() -> MovieDocument {
        return .init(from: self)
    }
}
