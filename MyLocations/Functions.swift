//
//  Functions.swift
//  MyLocations
//
//  Created by Aleksandr Ataev on 07.06.2021.
//

import Foundation

func afterDelay(_ seconds: Double, run: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: run)
}

let applicationDocumentsDirectory: URL = {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    print(paths)
    return paths[0]
}()

let dataSaveFailedNotification = Notification.Name(rawValue: "dataSaveFailedNotification")

func fatalCoreDataError(_ error: Error) {
    print("*** Fatal Error: \(error)")
    NotificationCenter.default.post(name: dataSaveFailedNotification, object: nil)
}
