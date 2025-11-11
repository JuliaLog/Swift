//
//  TestProjectUITestsTextLengthWalidation.swift
//  TestProject
//
//  Created by Юлия on 11/11/25.
//
import XCTest

class PracticeUITests: XCTestCase {
    
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
    
    
    func testTextFieldLengthValidation() {
        let passwordField = app.secureTextFields["passwordField"]
        
        let emailField = app.textFields["emailField"]
       
        
        XCTAssertTrue(emailField
            .waitForExistence(timeout: 3))
        
        emailField.tap()
        emailField.typeText("test@example.com")
        
        passwordField.tap()
        passwordField.typeText("123456789111213")
        
        //Проверка количества символов
        let textValue = emailField.value as? String ?? ""
        XCTAssertEqual(textValue.count, 16, "Длина текста должна быть 16 символов")
        
        // Пример: проверка, что длина не превышает лимит
        /* let maxLength = 17
         XCTAssertLessThanOrEqual(textValue.count, maxLength, "Введённый текст превышает лимит символов") */ //можно было бы добавить, если было бы валидационное сообщение об ошибке (тогда бы вводили не 16 символов, а больше)
        
        // чтобы тест не упал проверяем позитивный сценарий
         }
    }

