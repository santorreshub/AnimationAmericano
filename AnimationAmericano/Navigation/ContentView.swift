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
    @State var show = false
    
    var body: some View {
        ZStack {
            Color("Background 2").ignoresSafeArea()
            
            SideMenu()
                .opacity(isOpen ? 1: 0)
                .offset(x: isOpen ? 0:-300)
                .rotation3DEffect(
                    .degrees(isOpen ? 0:30),
                    axis: (x: 0, y: 1, z: 0)
                )
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
            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .rotation3DEffect(
                .degrees(isOpen ? 30 : 0),
                axis: (x:0, y:-1, z:0)
                
            )
            .offset(x:isOpen ? 265: 0)
            .scaleEffect(isOpen ? 0.9 : 0)
            .scaleEffect(show ? 0.92 : 1)
            .ignoresSafeArea()
            
            Image(systemName: "person")
                .frame(width: 36, height: 36)
                .background(.white)
                .mask(Circle())
                .shadow(color: Color("Shadow").opacity(0.2), radius: 5, x: 0, y: 5)
                .onTapGesture {
                    withAnimation(.spring()){
                        show = true
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding()
                .offset(y: 4)
                .offset(x: isOpen ? 100 : 0)
                
            button.view()
                .frame(width:44, height: 44)
                .mask(Circle())
                .shadow(color:Color("Shadow").opacity(0.2), radius: 5, x: 0, y: 5)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
                .offset(x: isOpen ? 216 : 0)
                .onTapGesture{
                    button.setInput("isOpen", value: isOpen)
                    withAnimation(.spring(response: 0.5 ,dampingFraction: 0.7 )){
                        isOpen.toggle()
                    }
                    
                }
                .onChange(of: isOpen){
                    newValue in
                    if newValue{
                        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
                    }else{
                        UIApplication.shared.setStatusBarStyle(.darkContent, animated: true)
                    }
                }
            
            TabBar()
                .offset(y: isOpen ? 300 : 0)
                .offset(y: show ? 200 : 0)
                .offset(y: -24)
                .background(
                    LinearGradient(colors: [Color("Bacbkground").opacity(0), Color("Background")], startPoint: .top, endPoint: .bottom)
                        .frame(height: 150)
                        .frame(maxWidth: .infinity, alignment: .bottom)
                        .allowsHitTesting(false)
                )
                .ignoresSafeArea()
            
            if show {
                OnBoardingView(show: $show)
                    .background(.white)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .shadow(color: .black.opacity(0.5), radius: 40, x: 0, y: 40)
                    .ignoresSafeArea(.all, edges: .top)
                    .transition(.move(edge: .top))
                    .offset(y: show ? -10 : 0)
                    .zIndex(1)
            }
        }
    }
}

//#Preview {
//    ContentView()
//}
