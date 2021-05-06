import UIKit
import PromiseKit

final class TariffsViewController: UIViewController {
    private let tariffPublisher: Publisher<Tariff>
    private let completion: (Tariff) -> Void

    init(tariffPublisher: Publisher<Tariff>, completion: @escaping (Tariff) -> Void) {
        self.tariffPublisher = tariffPublisher
        self.completion = completion

        super.init(nibName: nil, bundle: nil)

        title = "Tariffs"
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

        let comissionLabel = UILabel()

        let comission10Button = UIButton(type: .system)
        comission10Button.setTitle("Comission 10%", for: .normal)
        comission10Button.addTarget(self, action: #selector(didTapTariffComission10Button), for: .touchUpInside)

        let comission20Button = UIButton(type: .system)
        comission20Button.setTitle("Comission 20%", for: .normal)
        comission20Button.addTarget(self, action: #selector(didTapTariffComission20Button), for: .touchUpInside)

        let comission30Button = UIButton(type: .system)
        comission30Button.setTitle("Comission 30%", for: .normal)
        comission30Button.addTarget(self, action: #selector(didTapTariffComission30Button), for: .touchUpInside)

        view.addSubview(stackView)
        stackView.addArrangedSubview(comissionLabel)
        stackView.addArrangedSubview(comission10Button)
        stackView.addArrangedSubview(comission20Button)
        stackView.addArrangedSubview(comission30Button)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
        ])

        tariffPublisher.subscribe { comissionLabel.text = "Comission: \($0.comission)%" }
    }
}

private extension TariffsViewController {
    @objc
    func didTapTariffComission10Button() {
        completion(Tariff(comission: 10))
    }

    @objc
    func didTapTariffComission20Button() {
        completion(Tariff(comission: 20))
    }

    @objc
    func didTapTariffComission30Button() {
        completion(Tariff(comission: 30))
    }
}
