//
//  Home.swift
//  UI-520
//
//  Created by nyannyan0328 on 2022/03/25.
//

import SwiftUI

struct Home: View {
    @State var currentSize : PizzaSize = .Medium
    
    @State var pizzas : [Pizza] = [
    
      

            Pizza(breadName: "Bread_1"),
            Pizza(breadName: "Bread_2"),
            Pizza(breadName: "Bread_3"),
            Pizza(breadName: "Bread_4"),
            Pizza(breadName: "Bread_5"),


        ]
    
    @State var curretPizza : String = "Bread_1"
    @Namespace var animation
    
    let toppings : [String] = ["Basil","Onion","Broccoli","Mushroom","Sausage"]
    var body: some View {
        VStack{
            
            HStack{
                
                Button {
                    
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "suit.heart.fill")
                        .font(.title)
                        .foregroundColor(.green)
                        
                }
                
                
                

            }
            .overlay(content: {
                
                Text("Pizza")
                    .font(.title.weight(.semibold))
            })
            .foregroundColor(.black)
            .padding([.horizontal,.bottom])
            
            
            GeometryReader{proxy in
                
                let size = proxy.size
                
                
                ZStack{
                    
                    Image("Plate")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.vertical)
                        .padding(.horizontal,30)
                       
                    
                    
                    TabView(selection: $curretPizza) {
                        
                        ForEach(pizzas){piza in
                            
                            
                            ZStack {
                                Image(piza.breadName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(50)
                                
                                
                                ToopingView(toppings: piza.toppings, pizza: piza, width: (size.width / 2) - 45)
                                
                                
                                
                                
                            }
                            .scaleEffect(currentSize == .Large ? 1 : (currentSize == .Medium ? 0.95 : 0.9))
                            .tag(piza.breadName)
                                
                            
                        }
                  
                        
                        
                        
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                }
                .frame(maxWidth:.infinity)
                
                
              
                
                
                
            }
            .frame(height:300)
            
            
            Text("$18")
                .font(.largeTitle.weight(.black))
                .blur(radius:0.4)
            
            
            HStack(spacing:20){
                
                
                ForEach(PizzaSize.allCases,id:\.rawValue){size in
                    
                    
                    Button {
                        
                        withAnimation {
                            currentSize = size
                        }
                        
                    } label: {
                        
                        Text(size.rawValue)
                            .font(.title)
                            .foregroundColor(.black)
                            .padding(20)
                            .background(
                            
                            
                            
                                ZStack{
                                    
                                    if currentSize == size{
                                        
                                        Circle()
                                        .fill(.white)
                                        .matchedGeometryEffect(id: "TAB", in: animation)
                                        .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                                        .shadow(color: .green.opacity(0.1), radius: 5, x: -5, y: -5)
                                    }
                                }
                            
                            
                            
                            
                            
                            )
                           
                          
                           
                    }

                    
                    
                    
                }
               
                
            }
            .padding(.top,10)
           
            
        CustomTopping()
            
            
            Button {
                
            } label: {
                
                Label {
                    
                    Text("Add to Cart")
                    
                } icon: {
                    
                    Image(systemName: "cart.fill")
                        
                }

            }
            .padding(.vertical,15)
            .padding(.horizontal,25)
            .foregroundColor(.white)
            .background(
            
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color("Brown"))
            
            )
            .frame(maxHeight:.infinity)

            
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .top)
    }
    
    @ViewBuilder
    func ToopingView(toppings : [Topping],pizza : Pizza,width : CGFloat)->some View{
        
        
        
        Group{
            
            
            ForEach(toppings.indices,id:\.self){index in
                
                let topping = toppings[index]
                
                ZStack{
                    
                    
                    ForEach(1...20,id:\.self){subIndex in
                        
                        
                        
                        let rotation : Double = Double(subIndex) * 36
                        let cartIndex = (subIndex > 10 ? (subIndex - 10) : subIndex)
                        
                        
                        Image("\(topping.toppingName)_\(cartIndex)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35, height: 35)
                            .offset(x: (width / 4) - topping.randomTopicPosticion[subIndex - 1].width, y:topping.randomTopicPosticion[subIndex - 1].height )
                            .rotationEffect(.init(degrees: rotation))
                        
                        
                        
                        
                        
                    }
                    
                }
                .scaleEffect(topping.isAdded ? 1 : 10,anchor: .center)
                .onAppear {
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
                        
                        withAnimation{
                            
                            pizzas[getIndex(breadName: pizza.breadName)].toppings[index].isAdded = true
                            
                        }
                        
                    }
                }
                
            }
            
        }
        
        
    }
    
    
    @ViewBuilder
    func CustomTopping()->some View{
        
        Group{
            
            Text("CUSTOMIZE YOUR PIZZA")
                .font(.callout.weight(.light))
                .frame(maxWidth:.infinity,alignment: .leading)
                .padding(.leading,10)
                .padding(.top,20)
            
            
            ScrollViewReader{proxy in
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    
                    HStack(spacing:-10){
                        
                        
                        ForEach(toppings,id:\.self){topping in
                            
                            
                            Image("\(topping)_3")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .padding()
                                .background(
                                
                                
                                    Color.green
                                        .clipShape(Circle())
                                        .opacity(isAdded(topping: topping) ? 0.15 : 0)
                                        .animation(.easeInOut, value: curretPizza)
                                
                                )
                                .padding()
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    
                                    if isAdded(topping: topping){
                                        
                                        if let index = pizzas[getIndex(breadName: curretPizza)].toppings.firstIndex(where: { currentTopping in
                                            
                                            return topping == currentTopping.toppingName
                                        }){
                                            
                                            
                                            
                                            pizzas[getIndex(breadName: curretPizza)].toppings.remove(at: index)
                                            
                                        }
                                        
                                        return
                                        
                                        
                                    }
                                    
                                   
                                    
                                    
                                    var potisons : [CGSize] = []
                                    
                                    
                                    
                                    for _ in 1...20{
                                        
                                        potisons.append(.init(width: .random(in: -20...20), height: .random(in: -45...45)))
                                    }
                                    
                                    let toppingObject = Topping(toppingName: topping,randomTopicPosticion: potisons)
                                    
                                    withAnimation{
                                        
                                        
                                        pizzas[getIndex(breadName: curretPizza)].toppings.append(toppingObject)
                                        
                                    }
                                    
                                    
                                }
                                .tag(topping)
                            
                            
                            
                            
                        }
                    }
                    
                    
                }
                .onChange(of: curretPizza) { newValue in
                    
                    withAnimation {
                        proxy.scrollTo(toppings.first ??  "", anchor: .leading)
                    }
            
                    
                }
            }
          
            
        }
        
        
        
    }
    
    func isAdded(topping : String)->Bool{
        
        
        let status = pizzas[getIndex(breadName: curretPizza)].toppings.contains { currentTopping in
            
            
            return currentTopping.toppingName == topping
        }
        
        return status
        
        
        
    }
    func getIndex(breadName : String)->Int{
        
        
        let index = pizzas.firstIndex { pizza in
            
            
            return pizza.breadName == breadName
        } ?? 0
        
        return index
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum PizzaSize : String,CaseIterable{
    
    case small = "S"
    case Medium = "M"
    case Large = "L"
    
}
