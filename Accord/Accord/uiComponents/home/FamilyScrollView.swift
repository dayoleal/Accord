//
//  FamilyScrollView.swift
//  Accord
//
//  Created by Dayô Araújo on 14/07/25.
// https://stackoverflow.com/questions/75049237/slide-carousel-cards-on-cards-tap-in-swiftui

import SwiftUI

//struct FamilyScrollView: View {
//    var families: [Family]
//    
//    var body: some View {
//        VStack (alignment: .leading, spacing: 25) {
//            Text("Explorar Famílias Olfativas")
//                .font(.title2)
//                .fontWeight(.bold)
//                .padding(.leading, 30)
//            
//            ScrollView (.horizontal) {
//                HStack (spacing: 15) {
//                    ForEach(families, id: \.id ) { family in
//                        FamilyView(family: family)
//                    }
//                }
//                .padding(.leading, 30)
//                .padding(.trailing, 30)
//            }
//            .scrollIndicators(.hidden)
//        }
//    }
//}

import SwiftUI

struct FamilyScrollView: View {
    let families: [Family]
    
    @State private var snappedItem: Double = 0
    @State private var draggingItem: Double = 0
    @State private var activeIndex: Int = 0
    
    private func distance(_ index: Int) -> Double {
        return (draggingItem - Double(index)).remainder(dividingBy: Double(families.count))
    }
    

    private func xOffset(_ index: Int) -> Double {
        let angle = Double.pi * 2 / Double(families.count) * distance(index)
        return sin(angle) * 360
    }
    
    private func dragGesture() -> some Gesture {
        DragGesture()
            .onChanged { value in
                draggingItem = snappedItem + value.translation.width / 100
            }
            .onEnded { value in
                withAnimation {
                    draggingItem = snappedItem + value.predictedEndTranslation.width / 100
                    draggingItem = round(draggingItem).remainder(dividingBy: Double(families.count))
                    snappedItem = draggingItem
                    
                    activeIndex = families.count + Int(draggingItem)
                    if activeIndex > families.count || Int(draggingItem) >= 0 {
                        activeIndex = Int(draggingItem)
                    }
                }
            }
    }
    
    var body: some View {
        ZStack {
            ForEach(0..<families.count, id: \.self) { index in
                let family = families[index]
                
                FamilyView(family: family)
                    .scaleEffect(1.0 - abs(distance(index)) * 0.2)
                    .opacity(1 - abs(distance(index)) * 0.3)
                    .offset(x: xOffset(index), y: 0)
                    .zIndex(1.0 - abs(distance(index)) * 0.1)
                    .animation(.easeOut(duration: 0.3), value: draggingItem)
            }
        }
        .gesture(dragGesture())
        .frame(height: 250)
    }
}

#Preview {
    FamilyScrollView(families: families)
}

