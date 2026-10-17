//
//  ReviewList.swift
//  Accord
//
//  Created by Dayô Araújo on 21/07/25.
//

import SwiftUI

/// The reviews tab: every saved review, with swipe-to-delete and buttons to add a review or manage notifications.
struct ReviewList: View {

    @Environment(\.dependencies) private var dependencies
    @StateObject private var viewModel: ReviewListViewModel

    /// Creates the reviews tab.
    ///
    /// - Parameter viewModel: Provides the saved reviews and deletes them.
    init(viewModel: ReviewListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: -2) {
                Text("Meus Registros")
                    .font(.title)
                    .bold()
                    .padding(EdgeInsets(top: 30, leading: 25, bottom: 0, trailing: 0))

                List(viewModel.reviews) { review in
                    HStack(alignment: .center) {
                        NavigationLink {
                            ReviewView(viewModel: dependencies.makeReviewFormViewModel(editing: review))
                        } label: {
                            VStack(alignment: .leading) {
                                Text(review.displayTitle)
                                    .bold()
                            }
                            .padding(.leading, 5)
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            viewModel.delete(review)
                        } label: {
                            Image(systemName: "trash")
                        }
                        .accessibilityLabel("Apagar registro")
                        .accessibilityIdentifier(AccessibilityID.deleteReviewButton)
                    }
                }
                .accessibilityIdentifier(AccessibilityID.reviewList)
                .scrollContentBackground(.hidden)
                .listStyle(.insetGrouped)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    AddButton()
                }

                ToolbarItem(placement: .cancellationAction) {
                    NotificationButton()
                }
            }
            .onAppear {
                viewModel.load()
            }
            .background(
                Image("back.list")
                    .resizable()
                    .ignoresSafeArea()
            )
            .errorAlert(message: $viewModel.errorMessage)
        }
    }
}

#Preview {
    ReviewList(viewModel: AppDependencies.preview.makeReviewListViewModel())
}
