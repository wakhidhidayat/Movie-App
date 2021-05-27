//
//  MoviesViewController.swift
//  MovieApp
//
//  Created by Wahid Hidayat on 17/05/21.
//  Copyright © 2021 Wakhid Saiful Hidayat. All rights reserved.
//

import UIKit
import UserNotifications

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var movieTable: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let moviesController = MoviesController()
    private let headerTitle = ["Now Playing", "Upcoming", "Top Rated"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNotification()
        movieTable.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
        movieTable.dataSource = self
        movieTable.delegate = self
        
        getMovies()
    }
    
    private func getMovies() {
        activityIndicator.startAnimating()
        
        moviesController.getNowPlayingMovies {
            self.movieTable.reloadData()
            
            self.moviesController.getUpcomingMovies {
                self.movieTable.reloadData()
                
                self.moviesController.getPopularMovies {
                    self.movieTable.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    private func setupNotification() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            if granted {
                print("notification granted")
            } else {
                print("notification rejected")
            }
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Checkout all new movies here!"
        content.body = "These are some new movies just released. Don't miss out!"
        content.sound = .default
        
        var dateComponent = DateComponents()
        dateComponent.calendar = Calendar.current
        dateComponent.weekday = 6
        dateComponent.hour = 19
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesController.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as? MovieTableViewCell
        cell?.configure(with: moviesController.movies[indexPath.row], header: headerTitle[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280.0
    }
}

extension MoviesViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound])
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
