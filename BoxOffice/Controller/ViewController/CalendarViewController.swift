//
//  CalendarViewController.swift
//  BoxOffice
//
//  Created by Blu on 2023/05/17.
//

import UIKit

class CalendarViewController: UIViewController {

    var calendarView = UICalendarView()

    var calendarCall: ((Date) -> Void)?

    override func viewDidLoad() {

        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(calendarView)
        configureCalendarView()
    }

    func configureCalendarView() {

        let gregorianCalendar = Calendar(identifier: .gregorian)
        calendarView.calendar = gregorianCalendar
        calendarView.locale = Locale(identifier: "ko-KR")
        calendarView.fontDesign = .rounded
        calendarView.visibleDateComponents = gregorianCalendar.dateComponents([.year, .month, .day], from: Date())

        calendarView.availableDateRange = DateInterval(start: Date.distantPast, end: Date.yesterday)

        calendarView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.topAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
    }
}

extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {

        guard let selectedDateComponent = dateComponents,
              let selectedDate = Calendar.current.date(from: selectedDateComponent) else { return }

        calendarCall?(selectedDate)

        self.dismiss(animated: true)
    }
}
