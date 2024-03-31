//
//  ContentView.swift
//  biometrics
//
//  Created by Philippe MICHEL on 31/03/2024.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @State private var  isPresentedPicture = false
    var body: some View {
        VStack {
            Text("Déverrouilez votre Iphone")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .opacity(isPresentedPicture ? 0 : 1)
            Spacer()
            ViewPicture(showPicture: $isPresentedPicture)
            Spacer()
        }
        .onAppear() {
            authenticationBiometrics()
        }
        
    }
    // fonction qui gere la biométrie
    func authenticationBiometrics() {
        let context = LAContext()
        let policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics
        let reason: String = "Pour acceder à votre photo"
        var error: NSError?
        
        if context.canEvaluatePolicy(policy, error: &error) {
            context.evaluatePolicy(policy, localizedReason: reason) {
                (success, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                if success {
                    self.isPresentedPicture.toggle()
                }
            }
            
        }
        
    }
}

#Preview {
    ContentView()
}
