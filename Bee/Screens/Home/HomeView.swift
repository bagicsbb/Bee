//
//  HomeView.swift
//  Bee
//
//  Created by Macbook Pro CTO on 2021. 06. 24..
//
import CoreData
import SwiftUI

struct HomeView: View {
    static let tag: String? = "Home"
    @StateObject var viewModel: ViewModel
    
    var projectRows: [GridItem] {
        [GridItem(.fixed(100))]
    }
    
    init(dataController: DataController) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: projectRows) {
                                ForEach(viewModel.projects) { project in
                                    ProjectSummaryView(project: project)
                                }
                            }
                            .padding([.horizontal, .top])
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        VStack(alignment: .leading) {
                            ItemListView(title: "Up next", items: viewModel.upNext)
                            ItemListView(title: "More to explore", items: viewModel.moreToExplore)
                        }
                        .padding(.horizontal)
                    }
                    
                }
                .background(Color.systemGroupedBackground.ignoresSafeArea())
                .navigationTitle("Home 🐝")
                .toolbar {
                        Button("Add Data") {
                          viewModel.addSampleData()
                        }
                       
                   
                }
            }
            
        }
    }
    @ViewBuilder func list(_ title: LocalizedStringKey, for items: FetchedResults<Item>.SubSequence) -> some View {
        
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(dataController: DataController.preview)
    }
}
