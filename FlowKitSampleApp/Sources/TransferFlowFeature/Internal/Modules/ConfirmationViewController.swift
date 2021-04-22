import UIKit

final class ConfirmationViewController: UIViewController {
    private let country: Country
    private let amount: Int
    private let completion: () -> Void

    init(country: Country, amount: Int, completion: @escaping () -> Void) {
        self.country = country
        self.amount = amount
        self.completion = completion

        super.init(nibName: nil, bundle: nil)

        title = "Confirmation"
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

        let countryLabel = UILabel()
        let amountLabel = UILabel()

        let continueButton = UIButton(type: .system)
        continueButton.setTitle("Continue", for: .normal)
        continueButton.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)

        view.addSubview(stackView)
        stackView.addArrangedSubview(countryLabel)
        stackView.addArrangedSubview(amountLabel)
        stackView.addArrangedSubview(continueButton)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
        ])

        countryLabel.text = "Country: \(country.name)"
        amountLabel.text = "Amount: \(amount)"
    }
}

private extension ConfirmationViewController {
    @objc
    func didTapContinueButton() {
        completion()
    }
}
