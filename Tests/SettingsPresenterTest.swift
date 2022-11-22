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
    var selectedTheme: Int = 0
    
    func updateSignInCell() {
        isUpdate = true
    }
    
    func setApp(theme: Int) {
        selectedTheme = theme
    }
}

final class SettingsPresenterTest: XCTestCase {
    
    private var view: MockView!
    var presenter: SettingsPresenter!
    var network: MockNetworkAuthorizationManager!
    var settings: MockSettingsService!

    override func setUpWithError() throws {
        view = MockView()
        network = MockNetworkAuthorizationManager()
        settings = MockSettingsService()
        presenter = SettingsPresenter(view: view, networkService: network, settingsService: settings, router: SettingsRouter(modulesBuilder: ModuleBuilder()))
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
