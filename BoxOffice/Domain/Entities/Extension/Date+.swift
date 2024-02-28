import Foundation

extension Date {
    func yesterday() -> Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? self
    }
}

extension DateFormatter {
    static var jsonDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter
    }()
    
    static var titleDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
