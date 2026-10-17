//
//  NotificationView.swift
//  Accord
//
//  Created by Dayô Araújo on 29/07/25.
//

import SwiftUI

/// The screen where the user turns the weekly reminder on, picks its time, or turns every reminder off.
struct NotificationView: View {

    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: NotificationSettingsViewModel

    /// Creates the notification settings screen.
    ///
    /// - Parameter viewModel: Holds the settings and schedules the reminders.
    init(viewModel: NotificationSettingsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        GeometryReader { _ in
            NavigationStack {
                VStack(alignment: .leading, spacing: 30) {
                    Text("Crie notificações para não se esquecer de registrar novos perfumes!")

                    Toggle("Notificações semanais", isOn: $viewModel.remindersEnabled)
                        .padding(.trailing, 37)
                        .accessibilityIdentifier(AccessibilityID.remindersToggle)

                    if viewModel.remindersEnabled {
                        DatePicker("Time", selection: $viewModel.reminderTime, displayedComponents: .hourAndMinute)
                            .padding(.trailing, 37)
                            .padding(.leading, 10)
                            .accessibilityIdentifier(AccessibilityID.reminderTimePicker)
                    }

                    HStack {
                        Button {
                            viewModel.disableAll()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 40)
                                    .frame(width: 210, height: 45)
                                    .foregroundStyle(.gray)
                                Text("Desativar Notificações")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                            }
                        }
                        .accessibilityIdentifier(AccessibilityID.notificationDisableButton)

                        Spacer()

                        Button {
                            Task {
                                await viewModel.save()
                                if viewModel.didSchedule {
                                    dismiss()
                                }
                            }
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 40)
                                    .frame(width: 80, height: 45)
                                    .foregroundStyle(.neonYellow)
                                    .shadow(
                                        color: Color.primary.opacity(0.3),
                                        radius: 3,
                                        x: -1,
                                        y: 2
                                    )
                                Text("Salvar")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black)
                            }
                        }
                        .accessibilityIdentifier(AccessibilityID.notificationSaveButton)
                    }
                    .padding(.trailing, 30)
                    Spacer()
                }
                .ignoresSafeArea()
                .padding(.top, 10)
                .onAppear {
                    viewModel.load()
                }
                .padding(.leading, 25)
                .background(
                    Image("back.notification")
                        .resizable()
                        .ignoresSafeArea()
                )
                .errorAlert(message: $viewModel.errorMessage)
            }
        }
    }
}

#Preview {
    NotificationView(viewModel: AppDependencies.preview.makeNotificationSettingsViewModel())
}
