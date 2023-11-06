//
//  ContentView.swift
//  Sample
//
//  Created by Irine on 04/11/2023.
//

import SwiftUI

struct URLImage : View {
    let urlString: String
    @State var data : Data?
    var body: some View {
        if let data = data , let uiimage = UIImage(data: data){
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:130,height: 70)
                .background(Color.green)
            
        } else {
            Image(systemName: "video")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:130,height: 70)
                .background(Color.green).onAppear {
                    fetchData()
                }
        }
    }
    private func fetchData() {
        guard let url = URL (string:urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _,_ in
            self.data = data
        }
        task.resume()
    }
}
struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    //        @State var searchCollection = collections
    @State
    private var searchText =
    ""
    var body: some View {
    
    
        
//                    NavigationView {
//                        List {
//                        
//                        }
//                        .searchable(text: $searchText, placement:
//                                .navigationBarDrawer(displayMode: .always))
//                        
//                    }
        VStack(alignment: .leading, spacing:0) {
            
            //Navigation bar
            
            
            
            //Search Bar
            TextField("Search", text: $searchText)
                .padding()
                .frame(height: 45)
            
                .background(.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 0))
                .padding()
                .overlay {
                    HStack {
//                        Spacer()
                        
                        Button {
                            searchText = ""
                        } label: {
                            Label("clear", systemImage: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .opacity(searchText.isEmpty ? 0 : 1)
                                .padding(30)
                            
                        }
                        
                        .labelStyle(.iconOnly)
                        
                    }
                }
        }
                VStack {
                    
                Divider ()
                ScrollView(.horizontal) {
                    HStack(alignment: .center,spacing:10){
                        ForEach(0..<10) { index in
                            CircleView(label: "\(index)")
                        }
                    }.padding()
                   
                }.frame(height:100)
                Divider()
//                Spacer()
            }
        
//            NavigationView {
//                List {
        VStack {
            
//        Divider ()
            ScrollView(.horizontal) {
                HStack(spacing:10){
                    ForEach (viewModel.courses, id: \.self) { course in
                        HStack {
                            URLImage(urlString: course.image)
                            Text(course.name).bold()
                        }
                        .padding(3)
                    }.frame(height: 200)
                }
//                                .navigationTitle("Irine")
                .onAppear{
                    viewModel.fetch()
                }
            }
        }
        
        VStack {
            
        Divider ()
        ScrollView(.horizontal) {
            HStack(alignment: .center,spacing:10){
                ForEach(0..<10) { index in
                    RectangleView(label: "\(index)")
                }
            }.padding()
           
        }.frame(height:100)
    }
        
        TabView {
            
            Text("Favourites Screen")
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favourites")
            }
            Text("Friends Screen")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Friends")
            }
            Text("Nearby Screen")
                .tabItem {
                    Image(systemName: "mappin.circle.fill")
                    Text("Nearby")
            }
        }.padding(.top,90)
    }
}

    #Preview {
        ContentView()
    }

struct CircleView: View {
    @State var label:String
    var body: some View {
        VStack{
            Circle()
                .fill(Color.red)
                .frame(width:70,height: 70)
            Text(label)
        }
    }
}

struct RectangleView: View {
    @State var label:String
    var body: some View {
        ZStack(){
            Rectangle()
                .fill(Color.white)
                .border(.black)
                .frame(width:158,height: 184)
            Text(label)
            
//            Button("ADD") {}
////            
//                .buttonStyle(.borderedProminent).frame(width:120,height: 20)
//                .padding(EdgeInsets(top: 90, leading: 20, bottom: 2, trailing: 20))
//                .background(.green)

           
            Button(action: {}) {
                    Text("ADD")
                .buttonStyle(.borderedProminent)
//                    .padding(EdgeInsets(top: -5, leading: 5, bottom: 100, trailing: 5))
                      .foregroundColor(.white)
                      .background(.green)
                      .frame(width:180,height: 30)
                  }
//                  .shadow(color: .red, radius: 15, y: 5)
        }
    }
}
struct ContentViewTab: View {
    var body: some View {
        
        TabView {
            NavigationView{
                Color.red
                    .navigationBarTitle("Home", displayMode: .inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Image(systemName: "star.fill")
                        }
                    }
                    .navigationBarItems(leading: Button("Left") {}, trailing: Button("Right") {})
            }
            .tabItem {
                VStack{
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            }
            
            NavigationView{
                Color.green
                    //                    .item
                    .navigationBarTitle("Second", displayMode: .inline)
            }
            .tabItem {
                VStack{
                    Image("second")
                    Text("Second")
                }
            }
        }
        
    }
}
var body: some View {
    TabView {
        Text("Favourites Screen")
            .tabItem {
                Image(systemName: "heart.fill")
                Text("Favourites")
        }
        Text("Friends Screen")
            .tabItem {
                Image(systemName: "person.fill")
                Text("Friends")
        }
        Text("Nearby Screen")
            .tabItem {
                Image(systemName: "mappin.circle.fill")
                Text("Nearby")
        }
    }
}

