//
//  NotificationView.swift
//  Accord
//
//  Created by Dayô Araújo on 29/07/25.
//

import SwiftUI

struct NotificationView: View {
    @ObservedObject var viewModel = CoreDataViewModel()
    @Environment(\.dismiss) var dismiss
    @State var didSendNotification: Bool = false
    @State var reminders = false
    @State var reminderTime = Date.now
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                VStack (alignment: .leading, spacing: 30){
                    Text("Crie notificações para não se esquecer de registrar novos perfumes!")
                    
                    Toggle("Notificações semanais", isOn: $reminders)
                        .padding(.trailing, 37)
                    
                    if reminders{
                        DatePicker("Time", selection: $reminderTime, displayedComponents: .hourAndMinute)
                            .padding(.trailing, 37)
                            .padding(.leading, 10)
                    }
                    
                    HStack {
                        Button {
                            for scheduledNotification in viewModel.scheduledNotifications {
                                NotificationManagerModel.cancelScheduledNotification(scheduledNotification: scheduledNotification)
                                viewModel.deleteScheduledNotification(scheduledNotification: scheduledNotification)
                            }
                            
                            viewModel.scheduledNotifications.removeAll()
                            
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
                        
                        Spacer()
                        
                        Button {
                            print(reminders)
                            if reminders {
                                let notification: NotificationModel = NotificationModel(title: "Algum perfume novo?", subtitle: "Não se esqueça de registrar os perfumes da semana", body: "")
                                let calendar = Calendar.current
                                let hour = calendar.component(.hour, from: reminderTime)
                                let minute = calendar.component(.minute, from: reminderTime)
                                
                                NotificationManagerModel
                                    .scheduleRepeatingNotification(notification: notification, hour: hour, minute: minute, interval: 604800)
                                
                                didSendNotification = true
                                dismiss()
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
                    }
                    .padding(.trailing, 30)
                    Spacer()
                }
                .ignoresSafeArea()
                .padding(.top, 10)
                .onAppear {
                    viewModel.getNotifications()
                }
                .padding(.leading, 25)
                .background(
                    Image("back.notification")
                        .resizable()
                        .ignoresSafeArea()
                )
            }
        }
    }
}


#Preview {
    NotificationView()
}
