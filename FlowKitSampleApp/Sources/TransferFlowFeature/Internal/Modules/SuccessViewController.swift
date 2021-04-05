import UIKit

final class SuccessViewController: UIViewController {
    private let transfer: Transfer
    private let completion: () -> Void

    init(transfer: Transfer, completion: @escaping () -> Void) {
        self.transfer = transfer
        self.completion = completion

        super.init(nibName: nil, bundle: nil)

        title = "Success"
        navigationItem.hidesBackButton = true
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

        let identifierLabel = UILabel()
        let countryLabel = UILabel()
        let amountLabel = UILabel()

        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Close", for: .normal)
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)

        view.addSubview(stackView)
        stackView.addArrangedSubview(identifierLabel)
        stackView.addArrangedSubview(countryLabel)
        stackView.addArrangedSubview(amountLabel)
        stackView.addArrangedSubview(closeButton)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
        ])

        identifierLabel.text = "Identifier: \(transfer.identifier)"

        switch transfer.country {
        case .russia: countryLabel.text = "Country: Russia"
        case .germany: countryLabel.text = "Country: Germany"
        case .france: countryLabel.text = "Country: Framce"
        }

        amountLabel.text = "Amount: \(transfer.amount)"
    }
}

private extension SuccessViewController {
    @objc
    func didTapCloseButton() {
        completion()
    }
}
