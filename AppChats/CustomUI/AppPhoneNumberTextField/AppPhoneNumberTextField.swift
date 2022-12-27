//
//  AppPhoneNumberTextField.swift
//  AppChats
//
//  Created by Евгений Таракин on 23.12.2022.
//

import UIKit
import PhoneNumberKit

class AppPhoneNumberTextField: PhoneNumberTextField {
    override var defaultRegion: String {
        get {
            return "RU"
        }
        set {}
    }
}
