import Foundation

extension Date {
    func getDateString(from date: Date) -> String {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .none
        df.locale = Locale.current
        df.dateFormat = ""
        let newDate = df.string(from: date)
        return newDate
    }
}
