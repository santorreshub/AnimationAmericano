//
//  ContentView.swift
//  AnimationAmericano
//
//  Created by Santiago Torres Alvarez on 21/11/23.
//

import SwiftUI
import RiveRuntime

struct ContentView: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .chat
    let button  = RiveViewModel(fileName: "menu_button", stateMachineName: "State Machine", autoPlay: false) //animationName: "open"
    @State var isOpen = false
    
    var body: some View {
        ZStack {
            Group{
                switch selectedTab {
                    case .chat:
                        HomeView()
                    //safe area inset
                    case .search:
                        Text("hi")
                        //SigninView()
                    case .timer:
                        Text("Timer")
                    case .bell:
                        Text("Bell")
                    case .user:
                        Text("User")
                    
                }

                
            }
            //para que todas las views sean scrollable sin overlapping feo
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height:80)
            }
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: 44)
            }
            .ignoresSafeArea()
            
                        button.view()
                .frame(width:44, height: 44)
                .mask(Circle())
                .shadow(color:Color("Shadow").opacity(0.2), radius: 5, x: 0, y: 5)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
                .onTapGesture{
                    button.setInput("isOpen", value: isOpen)
                    isOpen.toggle()
                }
            
            TabBar()
        }
    }
}

//#Preview {
//    ContentView()
//}
