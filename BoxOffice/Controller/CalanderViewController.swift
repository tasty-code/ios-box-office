//
//  CalanderViewController.swift
//  BoxOffice
//
//  Created by 박재우 on 2023/05/17.
//

import UIKit

class CalanderViewController: UIViewController {

    private let datePicker = UIDatePicker()

    weak var delegate: CalanderDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }

    private func configureUI() {
        setAttributes()
        setContraints()
    }

    private func setAttributes() {
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
    }

    private func setContraints() {
        view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            datePicker.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc
    private func handleDatePicker(_ sender: UIDatePicker) {
        delegate?.selectedDate(date: sender.date)
        dismiss(animated: true)
    }
}

protocol CalanderDelegate: NSObject {
    func selectedDate(date: Date)
}
