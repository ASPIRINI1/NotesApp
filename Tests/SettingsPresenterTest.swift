//
//  SettingsPresenterTest.swift
//  NotesAppTests
//
//  Created by Станислав Зверьков on 03.11.2022.
//

import XCTest
@testable import NotesApp
import FirebaseAuth

private class MockView: UITableViewController ,SettingsViewProtocol {

    var isUpdate = false
    var pushVC: UIViewController?
    var selectedTheme: Int = 0
    
    func updateSignInCell() {
        isUpdate = true
    }
    
    func pushToView(_ vc: UIViewController) {
        pushVC = vc
    }
    
    func setApp(theme: Int) {
        selectedTheme = theme
    }
}

final class SettingsPresenterTest: XCTestCase {
    
    private var view: MockView!
    var presenter: SettingsPresenter!
    var network: MockNetworkService!
    var settings: MockSettingsService!

    override func setUpWithError() throws {
        view = MockView()
        network = MockNetworkService()
        settings = MockSettingsService()
        presenter = SettingsPresenter(view: view, networkService: network, settingsService: settings)
    }

    override func tearDownWithError() throws {
        view = nil
        network = nil
        settings = nil
        presenter = nil
    }
    
    func testIsAllItemNotNill() {
        XCTAssertNotNil(view)
        XCTAssertNotNil(network)
        XCTAssertNotNil(settings)
        XCTAssertNotNil(presenter)
    }
    
    func testIsPresenterCallViewFuncs() {
//        presenter.logInButtonPressed()
//        XCTAssertTrue(view.isUpdate)
        
        presenter.openProductWEB()
        XCTAssertNotNil(view.pushVC)
        
        view.pushVC = nil
        presenter.openDevInfo()
        XCTAssertNotNil(view.pushVC)
    }
    
    func testPresenterGetNotification() {
        NotificationCenter.default.post(name: .UserDidAuth, object: nil)
        XCTAssertTrue(view.isUpdate)
    }
    
    func isAppThemeSelected() {
        presenter.selectApp(theme: 1)
        XCTAssertEqual(view.selectedTheme, 1)
    }
}
