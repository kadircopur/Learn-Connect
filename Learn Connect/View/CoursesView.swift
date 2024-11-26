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
            VStack {
                CoursesList(viewModel: viewModel)
            }
            .refreshable {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                viewModel.fetchCourses()
                print(viewModel.courses.count)
            }
        }
    }
    
    struct CoursesList: View {
        @Bindable var viewModel: CoursesViewModel
        
        var body: some View {
            List {
                ForEach(viewModel.courses, id: \.id) { course in
                    NavigationLink(destination: CourseDetailView(viewModel: CourseDetailViewModel(course: course))) {
                        CourseCardView(course: course)
                    }
                }
            }
        }
    }
    
    struct CourseCardView: View {
        let course: Course
        
        var body: some View {
            HStack {
                CachedAsyncImageView(url: course.thumbnailURL,
                                     width: 120,
                                     height: 60,
                                     placeholder: Image(.imageplaceholder),
                                     cornerRadius: 10)
                
                VStack(alignment: .leading) {
                    Text(course.name ?? "Unknown name")
                        .font(.callout)
                    Text(course.instructorName ?? "Unknown instructor")
                        .font(.caption)
                }
            }
        }
    }
}
