//
//  CustomEnvironmentProperties.swift
//  Segue3
//
//  Created by Lily Tran on 8/14/22.
//

import SwiftUI

struct RootPresentationKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)

}

extension EnvironmentValues {
    var rootPresentation: Binding<Bool> {
        get {
            self[RootPresentationKey.self]
        } set {
            self[RootPresentationKey.self] = newValue
        }
    }
}
