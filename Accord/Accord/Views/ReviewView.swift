//
//  ReviewView.swift
//  Accord
//
//  Created by Dayô Araújo on 16/07/25.
//

import SwiftUI

/// The review form. It creates a new review, or edits an existing one when its view model was built with one.
struct ReviewView: View {

    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: ReviewFormViewModel

    /// Creates the review form.
    ///
    /// - Parameter viewModel: Holds the values typed in the form and saves them.
    init(viewModel: ReviewFormViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 35) {

                    NoteTitle(title: $viewModel.draft.title, name: $viewModel.draft.name)

                    SliderView(data: $viewModel.draft.projection, size: 17, spacing: 30, name: "Projeção", image1: "wave.3.up", image2: "wave.3.up")

                    SliderView(data: $viewModel.draft.sillage, size: 20, spacing: 47, name: "Fixação", image1: "hourglass.tophalf.fill", image2: "hourglass.bottomhalf.filled")

                    SeasonButtonView(selected: $viewModel.draft.season)

                    DescriptionView(desc: $viewModel.draft.desc)

                    Spacer()
                }
                .padding(.leading, 25)
                .padding(.top, 40)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Salvar") {
                            if viewModel.save() {
                                dismiss()
                            }
                        }
                        .padding(.trailing, 8)
                        .foregroundStyle(.color)
                        .fontWeight(.heavy)
                        .font(.title3)
                        .accessibilityIdentifier(AccessibilityID.reviewSaveButton)
                    }

                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancelar") {
                            dismiss()
                        }
                        .padding(.leading, 8)
                        .foregroundStyle(.color)
                        .accessibilityIdentifier(AccessibilityID.reviewCancelButton)
                    }
                }
            }
            .background(
                Image("back.note")
                    .resizable()
                    .ignoresSafeArea()
            )
            .errorAlert(message: $viewModel.errorMessage)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ReviewView(viewModel: AppDependencies.preview.makeReviewFormViewModel())
}
