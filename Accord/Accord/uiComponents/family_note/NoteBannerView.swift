//
//  NoteBannerView.swift
//  Accord
//
//  Created by Dayô Araújo on 16/07/25.
//

import SwiftUI

struct NoteBannerView: View {
    var note: NoteCard
    
    var body: some View {
        ZStack {
            Rectangle()
                .clipShape(
                    .rect(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: 80,
                        topTrailingRadius: 0
                    )
                )
                .foregroundStyle(.deepPurple)
                .ignoresSafeArea()
                .frame(height: 230)
            
            VStack (spacing: 1){
                Image(note.image)
                    .resizable()
                    .frame(width: 120, height: 120)
                
                Text(note.name)
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding(.top, 25)
        }
    }
}

#Preview {
    NoteBannerView(note: NoteCard(image: "rose", name: "Rosa", width: 85, height: 85))
}
