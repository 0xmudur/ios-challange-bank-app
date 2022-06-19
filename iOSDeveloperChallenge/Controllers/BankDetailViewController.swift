//
//  BankDetailViewController.swift
//  iOSDeveloperChallenge
//
//  Created by Muhammed Emin Aydın on 18.06.2022.
//

import UIKit
import FirebaseAnalytics

class BankDetailViewController: UIViewController {
    
    private var tableView: UITableView = UITableView()
    private var model: BankDataModel?
    
    private lazy var dcIdLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        var title = "\(BankDataModel.CodingKeys.id.stringValue):"
        var info  = "\n" + "\(model!.id)"
        var attributedString = NSMutableAttributedString()
            .appendWith(weight: .bold, title)
            .appendWith(color: .white, weight: .light, info)
        label.attributedText = attributedString
        label.textColor = .black
        return label
    }()
    
    private lazy var dcBANKASUBELabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        var title = "\(BankDataModel.CodingKeys.dcBANKASUBE.stringValue):"
        var info  = "\n" + "\(model!.dcBANKASUBE)"
        var attributedString = NSMutableAttributedString()
            .appendWith(weight: .bold, title)
            .appendWith(color: .white, weight: .light, info)
        label.attributedText = attributedString
        label.textColor = .black
        return label
    }()
    
    private lazy var dcADRESLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        var title = "\(BankDataModel.CodingKeys.dcADRES.stringValue):"
        var info  = "\n" + "\(model!.dcADRES)"
        var attributedString = NSMutableAttributedString()
            .appendWith(weight: .bold, title)
            .appendWith(color: .white, weight: .light, info)
        label.attributedText = attributedString
        label.textColor = .black
        return label
    }()
    
    private lazy var dcENYAKIMATMLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        var title = "\(BankDataModel.CodingKeys.dcENYAKIMATM.stringValue):"
        var info  = "\n" + "\(model!.dcENYAKIMATM)"
        var attributedString = NSMutableAttributedString()
            .appendWith(weight: .bold, title)
            .appendWith(color: .white, weight: .light, info)
        label.attributedText = attributedString
        label.textColor = .black
        return label
    }()
    
    private lazy var dcADRESADILabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        var title = "\(BankDataModel.CodingKeys.dcADRESADI.stringValue):"
        var info  = "\n" + "\(model!.dcADRESADI)"
        var attributedString = NSMutableAttributedString()
            .appendWith(weight: .bold, title)
            .appendWith(color: .white, weight: .light, info)
        label.attributedText = attributedString
        label.textColor = .black
        return label
    }()
    
    private lazy var dcBANKATIPILabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        var title = "\(BankDataModel.CodingKeys.dcBANKATIPI.stringValue):"
        var info  = "\n" + "\(model!.dcBANKATIPI)"
        var attributedString = NSMutableAttributedString()
            .appendWith(weight: .bold, title)
            .appendWith(color: .white, weight: .light, info)
        label.attributedText = attributedString
        label.textColor = .black
        return label
    }()
    
    private lazy var dcBANKKODULabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        var title = "\(BankDataModel.CodingKeys.dcBANKKODU.stringValue):"
        var info  = "\n" + "\(model!.dcBANKKODU)"
        var attributedString = NSMutableAttributedString()
            .appendWith(weight: .bold, title)
            .appendWith(color: .white, weight: .light, info)
        label.attributedText = attributedString
        label.textColor = .black
        return label
    }()
    
    private lazy var dcBOLGEKOORDINATORLUGULabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        var title = "\(BankDataModel.CodingKeys.dcBOLGEKOORDINATORLUGU.stringValue):"
        var info  = "\n" + "\(model!.dcBOLGEKOORDINATORLUGU)"
        var attributedString = NSMutableAttributedString()
            .appendWith(weight: .bold, title)
            .appendWith(color: .white, weight: .light, info)
        label.attributedText = attributedString
        label.textColor = .black
        return label
    }()
    
    private lazy var mapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get Direction", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(mapButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    init(model: BankDataModel) {
        
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [AnalyticsParameterItemID: "bank_detail_screen"])
        self.navigationController?.navigationBar.topItem?.title = model?.dcBANKASUBE
    }
    
    @objc func mapButtonTapped() {
        
        guard let address = model?.dcADRES else { return }
        let baseUrl: String = "http://maps.apple.com/?q="
        let encodedName = "\(address)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let finalUrl = baseUrl + encodedName
        if let url = URL(string: finalUrl) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    func setupUI() {
        
        view.backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [dcIdLabel, dcADRESLabel, dcADRESADILabel, dcBANKKODULabel, dcBANKASUBELabel, dcBANKATIPILabel, dcENYAKIMATMLabel, dcBOLGEKOORDINATORLUGULabel, mapButton])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 20
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 16, paddingRight: 16)
        
    }
    
    
}




