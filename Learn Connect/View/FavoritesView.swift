//
//  FavoritesView.swift
//  LearnConnect
//
//  Created by kadir on 23.11.2024.
//

import SwiftUI

@MainActor
struct FavoritesView: View {
    
    @State var viewModel = FavoritesViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if viewModel.courses.isEmpty {
                        Text("No favorite courses found.")
                            .foregroundColor(.gray)
                    } else {
                        CoursesList(viewModel: viewModel)
                    }
                }
            }
            .onAppear {
                viewModel.fetchFavoriteCourses()
            }
            .refreshable {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                viewModel.fetchFavoriteCourses()
            }
        }
    }
    
    struct CoursesList: View {
        @Bindable var viewModel: FavoritesViewModel
        
        var body: some View {
            List {
                ForEach(viewModel.courses, id: \.id) { course in
                    CourseCardView(viewModel: viewModel, course: course)
                }
                .onDelete { indexSet in
                    viewModel.handleDeleteAction(offsets: indexSet)
                }
            }
        }
    }
    
    struct CourseCardView: View {
        @Bindable var viewModel: FavoritesViewModel
        
        let course: UserCourse
        
        var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    CachedAsyncImageView(url: course.thumbnailURL,
                                         width: 120,
                                         height: 60,
                                         placeholder: Image(.imageplaceholder),
                                         cornerRadius: 10)
                    
                    VStack(alignment: .leading) {
                        Text(course.name)
                            .font(.callout)
                        Text(course.instructorName)
                            .font(.caption)
                    }
                }
            }
        }
    }
}
