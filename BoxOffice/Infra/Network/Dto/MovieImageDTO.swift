import Foundation

// MARK: - MovieImage
struct MovieImageDTO: Codable {
    let documents: [Document]
    let meta: Meta
}

// MARK: - Document
struct Document: Codable {
    let collection: Collection
    /// 문서 작성 시간
    let datetime: String
    /// 출처
    let displaySitename: String
    /// 문서 url
    let docURL: String
    /// 이미지 세로길이
    let height: Int
    /// 이미지 url
    let imageURL: String
    /// 미리보기 이미지 url
    let thumbnailURL: String
    /// 이미지 가로길이
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

enum Collection: String, Codable {
    case news = "news"
}

// MARK: - Meta
struct Meta: Codable {
    /// 현재 페이지가 마지막 페이지인지 여부
    /// false 면 페이지 증가
    let isEnd: Bool
    /// 노출 가능 문서 수
    let pageableCount: Int
    /// 검색된 문서 수
    let totalCount: Int
    
    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}
