//
//  DetailView.swift
//  CRUD_UI
//
//  Created by PPG on 25.08.22.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
    let item: PostModel
    @State var title = ""
    @State var post = ""
    var body: some View {
            ZStack {
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    Text("Create new Post")
                        .font(Font.system(size: 16, weight: .bold))
                    
                    TextField("Title", text: $title)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(6)
                        .padding(.bottom)
                    
                    TextField("Write something...", text: $post)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(6)
                        .padding(.bottom)
                    
                    Spacer()
                }.padding()
                    .onAppear(perform: {
                        self.title = item.title
                        self.post = item.post
                    })
            }
            .navigationBarTitle("Edit post", displayMode: .inline)
            .navigationBarItems(trailing: trailing)
    }

        var trailing: some View{
            Button(action: {
                
                //update post
                if title != "" && post != "" {
                    
                    let parameters:[String: Any] = ["id": item.id, "title":title,"post":post]
                    viewModel.updatePost(parameters: parameters)
                    viewModel.fetchPots()
                    presentationMode.wrappedValue.dismiss()
                }

            }, label: {
                Text("Save")
            })
        }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
