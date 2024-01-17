//
//  ContentView.swift
//  RunewarsSoloApp
//
//  Created by Peter Szots on 15/05/2023.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.dismiss) var dismiss
    @Namespace private var animation
    
    @State private var imagesArray: [String] = ["01-card","02-card","03-card","04-card","05-card","06-card","07-card","08-card","09-card","10-card","11-card","12-card","13-card","14-card","15-card","16-card","17-card","18-card"]
    @State private var fullImagesArray: [String] = ["01-card","02-card","03-card","04-card","05-card","06-card","07-card","08-card","09-card","10-card","11-card","12-card","13-card","14-card","15-card","16-card","17-card","18-card"]
//    @State private var copiedImagesArray: [String] = []
    @State private var imagesAddedArray: [String] = []
    @State private var imagesAddedArray2: [String] = []
    @State private var letter: String = ""
    @State private var letter2: String = ""
    @State private var isShowCardList = false
    @State private var showCard = false
    @State private var isShowDeleteAlert = false
    @State private var isShowDeleteAlert2 = false
    @State private var showList2 = false
    @State private var selectedCard = "01-card"
    
    private var season: String {
        var seasonName = ""
        switch imagesAddedArray.count {
        case 1:
            seasonName = "Spring"
        case 2:
            seasonName = "Summer"
        case 3:
            seasonName = "Autumn"
        case 4:
            seasonName = "Winter"
        default:
            seasonName = "SEASON"
        }
        return seasonName
    }
    
    func tapTheCard(item: String) {
        showCard.toggle()
        if showCard {
            selectedCard = item
        } else {
            selectedCard = ""
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center){
                Image("background")
                    .resizable()
//                    .scaledToFill()
                    .opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView(showsIndicators: false) {
                    Image("runewars-logo")
                        .resizable()
                        .scaledToFit()
                    ZStack{
                        Text("Solo Variant Compagnon App")
                            .font(.system(size: 19).weight(.light))
                        HStack {
                            Spacer()
                            Button {
                                isShowCardList = true
                            }label: {
                                Image(systemName: "menucard")
                                    .font(.title2)
                                    .foregroundColor(Color(red: 0.8, green: 0.2, blue: 0.1))
                            }
                        }
                    }
                    
                    Divider()
                    
                    if imagesAddedArray.count == 0 {
                        VStack{
                            Text("Tap on the + symbol to draw a card")
                                .font(.system(size: 14).weight(.light).italic())
                        }
                        .padding()
                    }
                    
                    ScrollView(.horizontal) {
                        HStack{
                            ForEach(imagesAddedArray, id: \.self) { item in
                                VStack(alignment: .leading, spacing: 0){
                                    HStack{
                                        Image(item)
                                            .resizable()
                                            .scaledToFit()
                                            .id(item)
                                            .onTapGesture {
                                                withAnimation(.spring(response: 0.3).speed(0.7)){
                                                    tapTheCard(item: item)
                                                }
                                            }
                                    }
                                    .padding(.trailing, (selectedCard == item) ? -20 : -110)
                                }
                                .frame(height: (selectedCard == item) ? geometry.size.height * 0.7 : geometry.size.height * 0.35)
                            }
                        }
                    }
                    
                    VStack{
                        if imagesAddedArray.count != 0 {
                            Text(season)
                                .font(.system(size: 20).weight(.bold).smallCaps())
                        }
                    }
                    
                    HStack(alignment: .center){
                        Button {
                            withAnimation(.spring(response: 0.3).speed(0.7)){
                                if imagesAddedArray.count < 4 {
                                    letter = imagesArray.randomElement() ?? "N/A"
                                    imagesArray = imagesArray.filter() {$0 != letter}
                                    imagesAddedArray.append(letter)
                                    selectedCard = ""
                                }
                            }
                        }label: {
                            Image(systemName: "plus")
                                .font(.system(size: 20).weight(.black))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, maxHeight: 70)
                                .padding(12)
                                .background(Color(red: 0.8, green: 0.2, blue: 0.1).opacity((imagesAddedArray.count == 4) ? 0.2 : 1))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                        }
                        .disabled(imagesAddedArray.count == 4)
                        
                        if !imagesAddedArray.isEmpty {
                            Button {
                                withAnimation(.spring(response: 0.3).speed(0.7)){
                                    if !imagesAddedArray.isEmpty {
                                        isShowDeleteAlert = true
                                    }
                                }
                            } label: {
                                Image(systemName: "arrow.counterclockwise")
                                    .font(.system(size: 20).weight(.black))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, maxHeight: 70)
                                    .padding(12)
                                    .background(Color(red: 0.8, green: 0.2, blue: 0.1))
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                        }
                    }
                    
                    // NEW list
                    
                    if imagesAddedArray2.count == 0 {
                        VStack(alignment: .center, spacing: 0){
                            Text("Tap on the button 'NEW LIST' to start drawing random cards from the remaining deck.")
                                .font(.system(size: 14).weight(.light).italic())
                        }
                        .padding()
                    }
                    
                    if showList2 == false {
                        Spacer()
                        Button{
                            withAnimation(.spring(response: 0.3).speed(0.7)){
                                showList2 = true
                                //                            copiedImagesArray = imagesArray
                                letter2 = imagesArray.randomElement() ?? "N/A"
                                imagesArray = imagesArray.filter() {$0 != letter2}
                                imagesAddedArray2.append(letter2)
                                selectedCard = ""
                            }
                        }label: {
                            Text("NEW LIST")
                                .font(.system(size: 20).weight(.bold))
                                .foregroundColor(.white)
                                .frame(height: 30)
                                .padding(10)
                                .background(Color(red: 0.5, green: 0.5, blue: 0.5))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        
                        Spacer()
                    } else {
                        ScrollView(.horizontal) {
                            HStack{
                                ForEach(imagesAddedArray2, id: \.self) { item in
                                    VStack(alignment: .leading, spacing: 0){
                                        HStack{
                                            Image(item)
                                                .resizable()
                                                .scaledToFit()
                                                .id(item)
                                                .onTapGesture {
                                                    withAnimation(.spring(response: 0.3).speed(0.7)){
                                                        tapTheCard(item: item)
                                                    }
                                                }
                                        }
                                        .padding(.trailing, (selectedCard == item) ? -20 : -110)
                                    }
                                    .frame(height: (selectedCard == item) ? geometry.size.height * 0.7 : geometry.size.height * 0.35)
                                }
                                Spacer()
                            }
                        }
                        
                        HStack{
                            Button {
                                withAnimation(.spring(response: 0.3).speed(0.7)){
                                    letter2 = imagesArray.randomElement() ?? "N/A"
                                    imagesArray = imagesArray.filter() {$0 != letter2}
                                    imagesAddedArray2.append(letter2)
                                    selectedCard = ""
                                }
                            }label: {
                                Image(systemName: "plus")
                                    .font(.system(size: 20).weight(.black))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, maxHeight: 70)
                                    .padding(12)
                                    .background(Color(red: 0.5, green: 0.5, blue: 0.5).opacity((imagesArray.isEmpty) ? 0.2 : 1))
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                            .disabled(imagesArray.isEmpty)
                            
                            if !imagesAddedArray2.isEmpty {
                                Button {
                                    withAnimation(.spring(response: 0.3).speed(0.7)){
                                        if !imagesAddedArray2.isEmpty {
                                            isShowDeleteAlert2 = true
                                        }
                                    }
                                } label: {
                                    Image(systemName: "arrow.counterclockwise")
                                        .font(.system(size: 20).weight(.black))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity, maxHeight: 70)
                                        .padding(12)
                                        .background(Color(red: 0.5, green: 0.5, blue: 0.5))
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                }
                            }
                        }
                    }
                    
                }
                .padding()
                .padding(.top)
                .ignoresSafeArea(.all)
                .sheet(isPresented: $isShowCardList) {
                    ZStack {
                        ScrollView(.vertical) {
                            ForEach(imagesArray, id: \.self) { item in
                                VStack(spacing: 0){
                                    Image(item)
                                        .resizable().scaledToFit()
                                }
                            }
                        }
                        .padding(.top, 75)
                        VStack{
                            HStack {
                                Text("Actual card list")
                                    .font(.system(size: 20).weight(.black))
                                    .padding()
                                Spacer()
                                Button {
                                    isShowCardList = false
                                } label: {
                                    Image(systemName: "xmark.app")
                                        .foregroundColor(.primary)
                                        .font(.system(size: 30).weight(.medium))
                                        .padding()
                                }
                            }
                            .background(.thinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .padding()
                            
                            Spacer()
                        }
                    }
                }
                .preferredColorScheme(.dark)
            }
        }
        .preferredColorScheme(.dark)
        .alert("Restart?", isPresented: $isShowDeleteAlert) {
            Button("YES") {
                withAnimation(.spring(response: 0.3).speed(0.7)){
                    imagesArray = fullImagesArray
                    imagesAddedArray.removeAll()
                    imagesAddedArray2.removeAll()
                    showList2 = false
                }
            }
            Button("NO", role: .cancel) { }
        }
        .alert("Restart?", isPresented: $isShowDeleteAlert2) {
            Button("YES") {
                imagesAddedArray2.removeAll()
//                imagesArray = copiedImagesArray
                showList2 = false
            }
            Button("NO", role: .cancel) { }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
