//
//  ContentView.swift
//  biometrics
//
//  Created by Philippe MICHEL on 31/03/2024.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
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
            // demande l'autentification la photo est caché
            if isPresentedPicture == false {
                authenticationBiometrics()
            }
        }
        // application active // arriere plan // inactive
        .onChange(of: scenePhase) { oldPhase, newPhase in
            if newPhase == .active{
                if isPresentedPicture == false {
                    authenticationBiometrics()
                }
                
            } else if newPhase == .background {
                isPresentedPicture = false
                
            } else if newPhase == .inactive {
                isPresentedPicture = false
            }
        }
    }
    
    // doc apple qui explique la mise en oeuvre
    // https://developer.apple.com/documentation/localauthentication/
    // fonction qui gere la biométrie
    func authenticationBiometrics() {
        // Un mécanisme d'évaluation des politiques d'authentification et des contrôles d'accès.
        let context = LAContext()
        let policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics
        // creation d'une raison
        let reason: String = "Pour acceder à votre photo"
        // erreur est un optionnel car on n'a pas forcement d'erreur.
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
