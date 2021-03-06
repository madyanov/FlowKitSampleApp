import UIKit
import PromiseKit

enum ConfirmationResult {
    case editAmount
    case editTariff
    case `continue`
}

final class ConfirmationViewController: UIViewController {
    private let loadingPublisher: Publisher<Bool>
    private let country: Country
    private let amount: Int
    private let tariff: Tariff
    private let completion: (ConfirmationResult) -> Void

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    init(loadingPublisher: Publisher<Bool>,
         country: Country,
         amount: Int,
         tariff: Tariff,
         completion: @escaping (ConfirmationResult) -> Void) {

        self.loadingPublisher = loadingPublisher
        self.country = country
        self.amount = amount
        self.tariff = tariff
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
        let comissionLabel = UILabel()

        let editAmountButton = UIButton(type: .system)
        editAmountButton.setTitle("Edit Amount", for: .normal)
        editAmountButton.addTarget(self, action: #selector(didTapEditAmountButton), for: .touchUpInside)

        let editTariffButton = UIButton(type: .system)
        editTariffButton.setTitle("Edit Tariff", for: .normal)
        editTariffButton.addTarget(self, action: #selector(didTapEditTariffButton), for: .touchUpInside)

        let continueButton = UIButton(type: .system)
        continueButton.setTitle("Continue", for: .normal)
        continueButton.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)

        view.addSubview(stackView)
        view.addSubview(activityIndicator)
        stackView.addArrangedSubview(countryLabel)
        stackView.addArrangedSubview(amountLabel)
        stackView.addArrangedSubview(comissionLabel)
        stackView.addArrangedSubview(editAmountButton)
        stackView.addArrangedSubview(editTariffButton)
        stackView.addArrangedSubview(continueButton)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        countryLabel.text = "Country: \(country.name)"
        amountLabel.text = "Amount: \(amount)"
        comissionLabel.text = "Comission: \(tariff.comission)%"

        loadingPublisher.subscribe { [weak self] loading in
            if loading {
                self?.activityIndicator.startAnimating()
            } else {
                self?.activityIndicator.stopAnimating()
            }
        }
    }
}

private extension ConfirmationViewController {
    @objc
    private func didTapEditAmountButton() {
        completion(.editAmount)
    }

    @objc
    private func didTapEditTariffButton() {
        completion(.editTariff)
    }

    @objc
    private func didTapContinueButton() {
        completion(.continue)
    }
}
