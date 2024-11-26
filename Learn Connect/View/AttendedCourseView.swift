//
//  AttendedCourseView.swift
//  Learn Connect
//
//  Created by kadir on 24.11.2024.
//

import SwiftUI
import AVKit


struct AttendedCourseView: View {
    @State var viewModel: AttendedCourseViewModel
    @State var watchedDuration: CMTime?
    @State var isCancelCourseAlertVisible: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack {
                Text("\(viewModel.course.name )")
                    .font(.headline)
                
                VideoPlayerWithOverlayControls(videoURL: viewModel.getVideoURL(),
                                               viewModel: viewModel,
                                               lastDuration: viewModel.getWatchedDuration(),
                                               height: 200)
                    .border(Color.gray, width: 1)
                
                Spacer()
                    .frame(height: 80)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Course Content")
                        .font(.headline)
                    
                    Text("\(viewModel.course.content )")
                        .font(.caption)
                }
                
                Spacer()
                    .frame(height: 100)
                
                Button(action: {
                    isCancelCourseAlertVisible = true
                }) {
                    Text("Cancel Course")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .alert("Cancel Course", isPresented: $isCancelCourseAlertVisible) {
                Button("Yes", role: .destructive) {
                    viewModel.cancelCourse()
                    dismiss()
                }
                Button("No", role: .cancel) { isCancelCourseAlertVisible = false }
            } message: {
                Text("Do you want to cancel course?")
            }
            .padding()
        }
    }
}
