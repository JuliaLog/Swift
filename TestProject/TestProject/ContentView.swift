//
//  ContentView.swift
//  TestProject
//
//  Created by Юлия on 11/5/25.
//

import SwiftUI

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    
    var body: some View {
        VStack(spacing: 20) {
            if isLoggedIn {
                Text("Добро пожаловать!")
                    .font(.title)
                    .accessibilityIdentifier("welcomeText")
            } else {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .accessibilityIdentifier("emailField")
                
                SecureField("Пароль", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .accessibilityIdentifier("passwordField")
                
                Button("Войти") {
                    if email == "test@test.com" && password == "123456" {
                        isLoggedIn = true
                    }
                }
                .accessibilityIdentifier("loginButton")
                
                Text("Тестовые данные: test@test.com / 123456")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
