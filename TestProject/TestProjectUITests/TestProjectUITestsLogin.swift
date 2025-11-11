//
//  TestProjectUITests.swift
//  TestProjectUITests
//
//  Created by Юлия on 11/5/25.
//

import XCTest

class UITestingPracticeUITests: XCTestCase {
    
    // Эта переменная будет доступна во всех тестах
    var app: XCUIApplication!
    
    // Этот метод запускается ПЕРЕД КАЖДЫМ тестом
    override func setUp() {
        super.setUp()
        
        // Не продолжать после неудачи - если тест упал, останавливаемся
        continueAfterFailure = false
        
        // Создаем экземпляр приложения
        app = XCUIApplication()
        
        // Дополнительные настройки запуска
        app.launchArguments = ["UITesting"]
        app.launchEnvironment = ["ENV": "TEST"]
        
        // Запускаем приложение
        app.launch()
    }
    
    // Этот метод запускается ПОСЛЕ КАЖДОГО теста
    override func tearDown() {
        
        
        // "Убираем за собой" - закрываем приложение
        app.terminate()
        super.tearDown()
    }
    
    // Это ПЕРВЫЙ тестовый метод
    func testSuccessfulLogin() {
        // 1. НАХОДИМ ЭЛЕМЕНТЫ
        let emailField = app.textFields["emailField"]
        let passwordField = app.secureTextFields["passwordField"]
        let loginButton = app.buttons["loginButton"]
        
        // 2. ПРОВЕРЯЕМ, что элементы есть на экране
        XCTAssertTrue(emailField.exists, "Поле email должно быть на экране")
        XCTAssertTrue(passwordField.exists, "Поле пароля должно быть на экране")
        XCTAssertTrue(loginButton.exists, "Кнопка входа должна быть на экране")
        
        // 3. ВВОДИМ ДАННЫЕ
        emailField.tap() // Нажимаем на поле email
        emailField.typeText("test@test.com") // Вводим текст
        
        passwordField.tap() // Нажимаем на поле пароля
        passwordField.typeText("123456") // Вводим пароль
        
        // 4. НАЖИМАЕМ КНОПКУ
        loginButton.tap()
        
        // 5. ПРОВЕРЯЕМ РЕЗУЛЬТАТ
        let welcomeText = app.staticTexts["welcomeText"]
        
        // Ждем появления текста (максимум 5 секунд)
        let exists = welcomeText.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "После входа должен появиться приветственный текст")
        
        // Дополнительная проверка
        if exists {
            XCTAssertEqual(welcomeText.label, "Добро пожаловать!")
        }
    }
}
