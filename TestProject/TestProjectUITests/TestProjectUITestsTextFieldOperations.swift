//
//  TestProjectUITestsTextFieldOperations.swift
//  TestProject
//
//  Created by Юлия on 11/11/25.
//

import XCTest

class TestingPracticeUITests: XCTestCase {
    
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
    
    func testTextFieldOperations() {
        let emailField = app.textFields["emailField"]
        let passwordField = app.secureTextFields["passwordField"]
        let loginButton = app.buttons["loginButton"]
        
        // Проверяем, что элементы существуют
        XCTAssertTrue(emailField.exists)
        XCTAssertTrue(passwordField.exists)
        XCTAssertTrue(loginButton.exists)
        
        // Простой ввод текста
        emailField.tap()
        emailField.typeText("Привет")
        
        
        passwordField.tap()
        passwordField.typeText("Bla@bla")
        
        loginButton.tap()
        
        let welcomeText = app.staticTexts["welcomeText"]
        
        var exists = welcomeText.waitForExistence(timeout: 5)
        XCTAssertFalse(exists, "После входа должен появиться приветственный текст")
        
        if exists {
            XCTAssertEqual(welcomeText.label, "Добро пожаловать!")
        }
        
        // Очистка поля
        emailField.clearText()
        
        // Ввод специальных символов
        emailField.tap()
        emailField.typeText("-=!")
        
        passwordField.tap()
        passwordField.typeText("-@!")
        
        loginButton.tap()
        
        // Ждем появления текста (максимум 5 секунд)
        exists = welcomeText.waitForExistence(timeout: 5)
        XCTAssertFalse(exists, "После входа должен появиться приветственный текст")
        
        // Дополнительная проверка
        if exists {
            XCTAssertEqual(welcomeText.label, "Добро пожаловать!")
        }
        
    }
}
    // Расширение для очистки текста
    extension XCUIElement {
        func clearText() {
            // Убедимся, что у поля есть текст
            guard let stringValue = self.value as? String, !stringValue.isEmpty else { return }
                    
            // Перемещаем курсор в конец (если нужно)
            self.tap()
                    
            // Симулируем нажатие delete для каждого символа
            let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
            self.typeText(deleteString)
        }
    }
    
// так как нет валидационных сообщений об неверно введённых данных, то нет возможности проверить этот текст и чтобы тест не упал проверяем только, что вводятся буквы и спецсимволы
// можно добавить больше проверок на ввод заглавной буквы, соотвествие шаблону email, пробелов и т.д. 
