import Foundation

extension Date {
    func yesterdayString(with format: String) -> String {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? self
        return DateFormatter.formatter(with: format).string(from: yesterday)
    }
    
    func openingDayString(with day: Date, with format: String) -> String {
        return DateFormatter.formatter(with: format).string(from: day)
    }
}

extension DateFormatter {
    static let yyyyMMdd: String = "yyyyMMdd"
    static let yyMMddDashed: String = "yyyy-MM-dd"
    
    static func formatter(with format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter
    }
}
