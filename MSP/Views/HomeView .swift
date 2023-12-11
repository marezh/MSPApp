//
//  HomeView .swift
//  MSP
//
//  Created by Marko Lazovic on 03.12.23.
//

import SwiftUI

struct HomeView: View {
    
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        @State private var timeNow = ""
        private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            return formatter
        }()
        
    
    var body: some View {
        
            ZStack{
                Image(GetTheTimeOfDayForBackground())
                    .resizable()
                    .ignoresSafeArea()
                  
                VStack{
                    Text(GetTheTimeOfDay())
                        .foregroundColor(.gray)
                        .font(.system(size: 23))
                    
                    Text(timeNow)
                        .foregroundColor(.white)
                        .font(.system(size: 65))
                        .padding(10)
                        .onReceive(timer) { _ in
                                    self.updateTime()
                                }
                                .onAppear {
                                    self.updateTime()
                                }
                        
                }
                .frame(width: 370, height: 200)
                .background(Color.black.opacity(0.3))
                .cornerRadius(40)
                .offset(x: 0, y: -250)
               
                
                //statistiken
                VStack{
                    HStack{
                        VStack{
                            HStack{
                                
                            }
                            .frame(width: 20, height: 125)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(60)
                            Text("Mo").font(.system(size: 18)).foregroundColor(.gray)

                        }
                        VStack{
                            HStack{
                                
                            }
                            .frame(width: 20, height: 125)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(60)
                            Text("Di").font(.system(size: 18)).foregroundColor(.gray)

                        }
                        VStack{
                            HStack{
                                
                            }
                            .frame(width: 20, height: 125)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(60)
                            
                            Text("Mi").font(.system(size: 18)).foregroundColor(.gray)

                        }
                        VStack{
                            HStack{
                                
                            }
                            .frame(width: 20, height: 125)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(60)
                            
                            Text("Do").font(.system(size: 18)).foregroundColor(.gray)
                        }
                        VStack{
                            
                            HStack{
                                
                            }
                            .frame(width: 20, height: 125)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(60)
                            Text("Fr").font(.system(size: 18)).foregroundColor(.gray)

                        }
                    }
                    .offset(x: 0, y: 0)
                    
                }
                .frame(width: 180, height: 190)
                .background(Color.black.opacity(0.3))
                .cornerRadius(40)
                .offset(x: 95, y: -30)
                
                
                
                VStack{
                    ZStack{
                        Circle()
                            .stroke(.gray.opacity(0.3), style: StrokeStyle(lineWidth: 5))
                        
                        Circle()
                            .trim(from: 0, to: 0.9)
                            .stroke(.green, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                            .rotationEffect(.degrees(-90))
                    }
                    .frame(width: 130)
                }
                .frame(width: 180, height: 190)
                .background(Color.black.opacity(0.3))
                .cornerRadius(40)
                .offset(x: -95, y: -30)
                
                
                //Buttons
                VStack{
                    
                }
                .frame(width: 180, height: 60)
                .background(Color.black.opacity(0.3))
                .cornerRadius(20)
                .offset(x: -95, y: 120)
                
                
                VStack{
                    
                }
                .frame(width: 180, height: 60)
                .background(Color.black.opacity(0.3))
                .cornerRadius(20)
                .offset(x: 95, y: 120)
                
                
                    }
            
      
        
        }
    private func updateTime() {
            self.timeNow = dateFormatter.string(from: Date())
        }
}

    
    


#Preview {
    HomeView()
}
