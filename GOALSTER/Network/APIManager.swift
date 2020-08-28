//
//  APIManager.swift
//  Samokat
//
//  Created by Daniyar on 7/14/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation

struct APIManager {
    static let shared = APIManager()
    let router = MyRouter<APIPoint>()
    
    func connect(completion:@escaping(_ error:String?,_ module: ConnectResponse?)->()) {
        router.request(.connect, returning: ConnectResponse?.self) { error, response in
            completion(error, response as? ConnectResponse)
        }
    }
    
    func auth(email: String, completion:@escaping(_ error:String?,_ module: AuthResponse?)->()) {
        router.request(.auth(email: email), returning: AuthResponse?.self) { error, response in
            completion(error, response as? AuthResponse)
        }
    }
    
    func chooseSpheres(spheres: [String: Any], completion:@escaping(_ error:String?,_ module: ChooseSpheresResponse?)->()) {
        router.request(.chooseSpheres(spheres: spheres), returning: ChooseSpheresResponse?.self) { error, response in
            completion(error, response as? ChooseSpheresResponse)
        }
    }
    
    func getGoals(date: String?, observation: Int?, completion:@escaping(_ error:String?,_ module: GoalsResponse?)->()) {
        router.request(.goals(date: date, observation: observation), returning: GoalsResponse?.self) { error, response in
            completion(error, response as? GoalsResponse)
        }
    }
    
    func getCalendar(observation: Int? = nil, completion:@escaping(_ error:String?,_ module: CalendarResponse?)->()) {
        router.request(.calendar(observation: observation), returning: CalendarResponse?.self) { error, response in
            completion(error, response as? CalendarResponse)
        }
    }
    
    func searchObserver(q: String, completion:@escaping(_ error:String?,_ module: SearchResponse?)->()) {
        router.request(.searchObserver(q: q), returning: SearchResponse?.self) { error, response in
            completion(error, response as? SearchResponse)
        }
    }
    
    func addGoal(name: String, date: String, time: TimeOfTheDay, isShared: Bool, observer: Int? = nil, sphere: Int, completion:@escaping(_ error:String?,_ module: Bool?)->()) {
        router.request(.addGoal(name: name, date: date, time: time, isShared: isShared, observer: observer, sphere: sphere), returning: Bool?.self, boolResult: true) { error, response in
            completion(error, response as? Bool)
        }
    }
    
    func todayGoals(completion:@escaping(_ error:String?,_ module: TodayGoalsResponse?)->()) {
        router.request(.todayGoals, returning: TodayGoalsResponse?.self) { error, response in
            completion(error, response as? TodayGoalsResponse)
        }
    }
    
    func doneGoal(id: Int, completion:@escaping(_ error:String?,_ module: Bool?)->()) {
        router.request(.doneGoal(id: id), returning: Bool?.self, boolResult: true) { error, response in
            completion(error, response as? Bool)
        }
    }
    
    func getEmotions(completion:@escaping(_ error:String?,_ module: EmotionsResponse?)->()) {
        router.request(.getEmotions, returning: EmotionsResponse?.self) { error, response in
            completion(error, response as? EmotionsResponse)
        }
    }
    
    func addEmotions(answers: [[String: Any]], completion:@escaping(_ error:String?,_ module: Bool?)->()) {
        router.request(.addEmtions(answers: answers), returning: Bool?.self, boolResult: true) { error, response in
            completion(error, response as? Bool)
        }
    }
    
    func getVisualizations(completion:@escaping(_ error:String?,_ module: VisualizationsResponse?)->()) {
        router.request(.getVisualizations, returning: VisualizationsResponse?.self) { error, response in
            completion(error, response as? VisualizationsResponse)
        }
    }
    
    func addVisualization(parameters: [String: Any], completion:@escaping(_ error:String?,_ module: Bool?)->()) {
        router.upload(.addVisualization(parameters: parameters), returning: Bool?.self, boolResult: true) { error, response in
            completion(error, response as? Bool)
        }
    }
    
    func getObserved(completion:@escaping(_ error:String?,_ module: ObservedResponse?)->()) {
        router.request(.getObserved, returning: ObservedResponse?.self) { error, response in
            completion(error, response as? ObservedResponse)
        }
    }
    
    func getObservers(completion:@escaping(_ error:String?,_ module: ObserversResponse?)->()) {
        router.request(.getObservers, returning: ObserversResponse?.self) { error, response in
            completion(error, response as? ObserversResponse)
        }
    }
    
    func acceptObservation(id: Int, isConfirmed: Bool, completion:@escaping(_ error:String?,_ module: Bool?)->()) {
        router.request(.acceptObservation(id: id, isConfirmed: isConfirmed), returning: Bool?.self, boolResult: true) { error, response in
            completion(error, response as? Bool)
        }
    }
    
    func deleteObservation(id: Int, completion:@escaping(_ error:String?,_ module: Bool?)->()) {
        router.request(.deleteObservation(id: id), returning: Bool?.self, boolResult: true) { error, response in
            completion(error, response as? Bool)
        }
    }
    
    func changeLanguage(language: Language, completion:@escaping(_ error:String?,_ module: Bool?)->()) {
        router.request(.changeLanguage(language: language), returning: Bool?.self, boolResult: true) { error, response in
            completion(error, response as? Bool)
        }
    }
    
    func changeNotifications(isOn: Bool, completion:@escaping(_ error:String?,_ module: Bool?)->()) {
        router.request(.changeNotifications(isOn: isOn), returning: Bool?.self, boolResult: true) { error, response in
            completion(error, response as? Bool)
        }
    }
    
    func getNotifications(completion:@escaping(_ error:String?,_ module: NotificationsResponse?)->()) {
        router.request(.getNotifications, returning: NotificationsResponse?.self) { error, response in
            completion(error, response as? NotificationsResponse)
        }
    }
    
    func help(text: String, completion:@escaping(_ error:String?,_ module: Bool?)->()) {
        router.request(.help(text: text), returning: Bool?.self, boolResult: true) { error, response in
            completion(error, response as? Bool)
        }
    }
    
    func testPremium(completion:@escaping(_ error:String?,_ module: Bool?)->()) {
        router.request(.testPremium, returning: Bool?.self, boolResult: true) { error, response in
            completion(error, response as? Bool)
        }
    }
}
