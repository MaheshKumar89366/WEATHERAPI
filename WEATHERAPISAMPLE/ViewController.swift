//
//  ViewController.swift
//  WEATHERAPISAMPLE
//
//  Created by Mahesh Kumar Narre on 26/07/24.
//

import UIKit

class ViewController: UIViewController {
    private let viewModel = WeatherViewModel()
    
    private let cityNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter city name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 70, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let fetchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Fetch Weather", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(cityNameTextField)
        view.addSubview(cityNameLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(fetchButton)
        
        cityNameTextField.addTarget(self, action: #selector(fetchWeather), for: .editingDidEndOnExit)
        fetchButton.addTarget(self, action: #selector(fetchWeather), for: .touchUpInside)
        
        setupConstraints()
    }
    
    @objc private func fetchWeather() {
        guard let cityName = cityNameTextField.text else { return }
        viewModel.fetchWeather(for: cityName) { [weak self] weatherResponse in
            guard let self = self else { return }
            if let weatherResponse = weatherResponse {
                DispatchQueue.main.async{
                    self.cityNameLabel.text = cityName
                    self.temperatureLabel.text = "\(weatherResponse.main.temp)°C"
                    self.descriptionLabel.text = weatherResponse.weather.first?.description ?? "No description"
                }
            } else {
                DispatchQueue.main.async{
                    self.cityNameLabel.text = "No Data"
                    self.temperatureLabel.text = ""
                    self.descriptionLabel.text = ""
                }
                
            }
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cityNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            cityNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cityNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            fetchButton.topAnchor.constraint(equalTo: cityNameTextField.bottomAnchor, constant: 20),
            fetchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            cityNameLabel.topAnchor.constraint(equalTo: fetchButton.bottomAnchor, constant: 40),
            cityNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 20),
            temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 20),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

