import UIKit

final class AmountViewController: UIViewController {
    private let completion: (Int) -> Void

    private lazy var amountField: UITextField = {
        let amountField = UITextField()
        amountField.translatesAutoresizingMaskIntoConstraints = false
        amountField.keyboardType = .numberPad
        amountField.borderStyle = .roundedRect
        return amountField
    }()

    init(country: Country, completion: @escaping (Int) -> Void) {
        self.completion = completion

        super.init(nibName: nil, bundle: nil)

        title = country.name
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16

        let continueButton = UIButton(type: .system)
        continueButton.setTitle("Continue", for: .normal)
        continueButton.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)

        view.addSubview(stackView)
        stackView.addArrangedSubview(amountField)
        stackView.addArrangedSubview(continueButton)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
        ])
    }
}

private extension AmountViewController {
    @objc
    private func didTapContinueButton() {
        guard let amountString = amountField.text,
              let amount = Int(amountString) else { return }

        completion(amount)
    }
}
