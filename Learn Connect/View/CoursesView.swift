//
//  CoursesView.swift
//  LearnConnect
//
//  Created by kadir on 23.11.2024.
//

import SwiftUI

struct CoursesView: View {
    
    @State var viewModel = CoursesViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    CoursesList(viewModel: viewModel)
                }
                
                //ActivityIndicator(isLoading: $viewModel.areCoursesLoading)
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Courses")
        }
    }
    
    struct CoursesList: View {
        @Bindable var viewModel: CoursesViewModel
        
        var body: some View {
            List(viewModel.courses, id: \.id) { course in
                NavigationLink(
                    destination: CourseDetailView(viewModel: CourseDetailViewModel(course: course))
                
                ) {
                    CourseCardView(course: course)
                }
            }
        }
    }
    
    struct CourseCardView: View {
        let course: Course
        
        var body: some View {
            HStack {
                AsyncImageView(url: course.thumbnailURL,
                               width: 120,
                               height: 60)
                
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
