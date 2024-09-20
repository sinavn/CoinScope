//
//  NoHoldingsView.swift
//  CoinScope
//
//  Created by Sina Vosough Nia on 6/30/1403 AP.
//
import SwiftUI

struct NoHoldingsView: View {
    @State var animate : Bool = false
    var onButtonTap: ()->Void
    let secondAccentColor = Color("secondAccentColor")
   
    //MARK: - body
    
    var body: some View {
        ScrollView{
            VStack(spacing:20){
                
                Text("there are no assests in your portfolio")
                    .font(.title)
                    .fontWeight(.semibold)
               
                Text("add some assets to control your gains and loses!💸 ")
                    .padding(.bottom , 20  )
               Button(action: {onButtonTap()}, label: {
                   Text("add new asset 🤑")
                       .foregroundColor(.white)
                       .font(.headline)
                       .frame(maxWidth: .infinity)
                       .frame(height: 50)
                       .background(animate ? Color.theme.SecondAccentColor : Color.theme.accentColor )
                       .cornerRadius(10)

               })

                .padding(.horizontal, animate ? 30:50)
                .shadow(color: animate ? Color.theme.SecondAccentColor.opacity(0.5) : Color.theme.accentColor.opacity(0.5),
                        radius: animate ? 30 : 10,
                        x: 0,
                        y: animate ? 50 : 30)
                .scaleEffect(animate ? 1.1 : 1.0)
                .offset(y: animate ? -7 : 0)
                    
            }
            .frame(maxWidth: 400)
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: addAnimation)
            
        }
        .frame(maxWidth: .infinity ,maxHeight: .infinity )
    }
    //MARK: - add animation func
    
    func addAnimation (){
        guard !animate else {return}
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ){
                animate.toggle()
            }
        })
    }
}
//MARK: - preview


struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            NoHoldingsView( onButtonTap: {})
        }
    }
}
