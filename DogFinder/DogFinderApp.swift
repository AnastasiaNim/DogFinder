//
//  DogFinderApp.swift
//  DogFinder
//
//  Created by Anastasia N.  on 19.03.2025.
//
import SwiftUI

@main
struct DogFinderApp: App {
    //тут модель не нужна зачем она так глобально? тут обычно что-то глобальное например роутер(сервис для навигации если надо ей как-то из вне управлять программно, открыть экран по переход из сафари к примеру или уведомления)
//    @StateObject private var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
