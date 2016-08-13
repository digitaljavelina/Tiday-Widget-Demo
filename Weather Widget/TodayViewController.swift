//
//  TodayViewController.swift
//  Weather Widget
//
//  Created by Michael Henry on 12/22/15.
//  Copyright © 2015 AppCoda. All rights reserved.
//

import UIKit
import NotificationCenter
import WeatherInfoKit

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    
    var location = "Paris, France"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityLabel.text = location
        
        // invoke weather service to get the weather data
        
        WeatherService.sharedWeatherService().getCurrentWeather(location) { (data) -> () in
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                if let weatherData = data {
                    self.weatherLabel.text = weatherData.weather.capitalizedString
                    self.temperatureLabel.text = String(format: "%d", weatherData.temperature) + "\u{00B0}"
                }
            })
        }
        
    }

    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        cityLabel.text = location
        
        WeatherService.sharedWeatherService().getCurrentWeather(location) { (data) -> () in
            guard let weatherData = data else {
                completionHandler(NCUpdateResult.NoData)
                return
            }
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.weatherLabel.text = weatherData.weather.capitalizedString
                self.temperatureLabel.text = String(format: "%d", weatherData.temperature) + "\u{00B0}"
            })

        completionHandler(NCUpdateResult.NewData)
            
        }
    }
    
}
