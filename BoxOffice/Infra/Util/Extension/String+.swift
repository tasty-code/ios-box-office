import Foundation

extension String {
    func toDate(with format: String) -> Date? {
        let dateFormatter = DateFormatter.formatter(with: format)
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        return dateFormatter.date(from: self)
    }
}
