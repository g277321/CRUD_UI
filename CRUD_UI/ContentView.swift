//
//  ContentView.swift
//  CRUD_UI
//
//  Created by PPG on 24.08.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
    }
}

struct HomeView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var isPresentedNewPost = false
    @State var title = ""
    @State var post = ""
    var body: some View {
        NavigationView{
            List{
                ForEach(viewModel.items, id: \.id){
                    item in
                    NavigationLink(
                        destination: DetailView(item: item),
                        label: {
                        VStack(alignment: .leading){
                            Text(item.title)
                            Text(item.post).font(.caption).foregroundColor(.gray)
                        }

                    })
                
                }.onDelete(perform: deletePost)
            }.listStyle(InsetListStyle())
            .navigationBarTitle("Posts")
            .navigationBarItems(trailing: plusButton)
        }.sheet(isPresented: $isPresentedNewPost, content: {
            NewPostView(isPresented: $isPresentedNewPost, title: $title, post: $post)
        })

    }
    private func deletePost(indexSet: IndexSet){
        
        let id = indexSet.map{viewModel.items[$0].id}
        DispatchQueue.main.async{
            let parameters: [String: Any] = ["id":id[0]]
            self.viewModel.deletePost(parameters: parameters)
            self.viewModel.fetchPots()        }
        
    }
    
    
    var plusButton: some View{
        Button(action: {
            isPresentedNewPost.toggle()
        }, label: {
            Image(systemName: "plus")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
