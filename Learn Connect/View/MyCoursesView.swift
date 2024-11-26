//
//  MyCoursesView.swift
//  LearnConnect
//
//  Created by kadir on 23.11.2024.
//

import SwiftUI

@MainActor
struct MyCoursesView: View {
    
    @State var viewModel = MyCoursesViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if viewModel.courses.isEmpty {
                        Text("No attended courses found.")
                            .foregroundColor(.gray)
                    } else {
                        CoursesList(viewModel: viewModel)
                    }
                }
            }
            .onAppear {
                viewModel.fetchAttendedCourses()
            }
            .refreshable {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                viewModel.fetchAttendedCourses()
            }
        }
    }
    
    struct CoursesList: View {
        @Bindable var viewModel: MyCoursesViewModel
        
        var body: some View {
            List(viewModel.courses, id: \.id) { course in
                NavigationLink(destination: AttendedCourseView(viewModel: AttendedCourseViewModel(course: course))) {
                    CourseCardView(viewModel: viewModel, course: course)
                }
            }
        }
    }
    
    struct CourseCardView: View {
        @Bindable var viewModel: MyCoursesViewModel
        @State var progress: Int = 0
        
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
                
                ProgressView(value: Double(viewModel.getRateOfProgress(for: course)), total: 100, label: {
                    Text("%\(viewModel.getRateOfProgress(for: course))")
                        .font(.caption)
                })
            }
        }
    }
}
