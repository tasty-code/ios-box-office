import Foundation

extension Date {
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? self
    }
    func yesterdayString(with format: String) -> String {
        return DateFormatter.formatter(with: format).string(from: yesterday)
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
