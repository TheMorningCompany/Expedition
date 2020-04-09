//
//  SettingsBundleHelper.swift
//  Expedition
//
//  Created by Julian Wright on 1/7/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import Foundation

class SettingsBundleHelper {
    struct SettingsBundleKeys {
        static let saveHistory = "save_history"
        static let BuildVersionKey = "build_preference"
        static let AppVersionKey = "version_preference"
    }
    class func checkAndExecuteSettings() {
        if UserDefaults.standard.bool(forKey: SettingsBundleKeys.saveHistory) {
            UserDefaults.standard.set(false, forKey: SettingsBundleKeys.saveHistory)
            let appDomain: String? = Bundle.main.bundleIdentifier
            UserDefaults.standard.removePersistentDomain(forName: appDomain!)
            // reset userDefaults..
            // CoreDataDataModel().deleteAllData()
            // delete all other user data here..
        }
    }
    
    class func setVersionAndBuildNumber() {
        let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        UserDefaults.standard.set(version, forKey: "version_preference")
        let build: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        UserDefaults.standard.set(build, forKey: "build_preference")
    }
}
