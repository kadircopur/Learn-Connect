//
//  CoursesDetailView.swift
//  LearnConnect
//
//  Created by kadir on 23.11.2024.
//

import SwiftUI

struct CourseDetailView: View {
    
    @State var viewModel: CourseDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImageView(url: viewModel.course.thumbnailURL ?? "",
                               width: UIScreen.main.bounds.width - 36,
                               height: 300)
                                
                Text("\(viewModel.course.detail ?? "")")
                    .font(.title)
                
                Text("Content")
                    .font(.headline)
                
                Text("\(viewModel.course.content ?? "")")
                    .font(.caption)
            }
            .padding()
            
            Button(action: viewModel.handleAttendAction) {
                Text(viewModel.isAttended ? "Attended" : "Attend")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isAttended ? Color.gray : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(viewModel.isAttended)
            .padding()
        }
    }
}
