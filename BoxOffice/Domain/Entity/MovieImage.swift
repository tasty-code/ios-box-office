import Foundation

struct MovieImage {
    let documents: [MovieDocument]
    let meta: MovieImageMeta
}

struct MovieDocument {
    let collection: Collection
    let datetime: String
    let displaySitename: String
    let docURL: String
    let height: Int
    let imageURL: String
    let thumbnailURL: String
    let width: Int
    
    init(from documentDTO: MovieImageDTO.DocumentDTO) {
        self.collection = documentDTO.collection
        self.datetime = documentDTO.datetime
        self.displaySitename = documentDTO.displaySitename
        self.docURL = documentDTO.docURL
        self.height = documentDTO.height
        self.imageURL = documentDTO.imageURL
        self.thumbnailURL = documentDTO.thumbnailURL
        self.width = documentDTO.width
    }
}

struct MovieImageMeta {
    let isEnd: Bool
    let pageableCount: Int
    let totalCount: Int
    
    init(from metaDTO: MovieImageDTO.MetaDTO) {
        self.isEnd = metaDTO.isEnd
        self.pageableCount = metaDTO.pageableCount
        self.totalCount = metaDTO.totalCount
    }
}
