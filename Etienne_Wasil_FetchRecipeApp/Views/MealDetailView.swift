//
//  MealDetailView.swift
//  Etienne_Wasil_FetchRecipeApp
//
//  Created by Etienne Wasil on 9/7/23.
//

import SwiftUI

struct MealDetailView: View {
    @StateObject private var viewModel: MealDetailViewModel
    
    @State private var isIngredientsShowing: Bool = true
    @State private var isSafariShowing: Bool = false

    @Environment(\.presentationMode) var presentationMode
    
    let idMeal: String
    
    init(idMeal: String) {
        self.idMeal = idMeal
        _viewModel = StateObject(wrappedValue: MealDetailViewModel(idMeal: idMeal))
    }
    
    var body: some View {
        VStack {
            ScrollView {
                //MARK: Header - Dessert Photo, Back Button, & Links
                ZStack{
                    //Dessert Photo
                    AsyncImage(url: URL(string: viewModel.recipeInfo?.strMealThumb ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity)
                            .frame(height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 0))
                    }
                    placeholder: {
                        ProgressView()
                    }
                    //MARK: Title Image
                    VStack {
                        //MARK: Back Button
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                ZStack {
                                    Circle()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.yellow)
                                    Image(systemName: "chevron.left")
                                        .bold()
                                        .foregroundColor(.black)
                                }
                            })
                            Spacer()
                        }
                        //Seperate Buttons from top to bottom
                        Spacer()
                        
                        //MARK: Link Buttons
                        HStack {
                            Spacer()
                            VStack(spacing: 15) {
                                //Website Link Button
                                if let link = viewModel.recipeInfo?.strSource, !link.isEmpty {
                                        Button(action: {
                                            viewModel.website = link
                                            isSafariShowing = true

                                        }, label: {
                                            ZStack {
                                                Circle()
                                                    .frame(width: 50, height: 50)
                                                    .foregroundColor(.gray.opacity(0.8))
                                                Image(systemName: "link")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(height: 18)
                                            }
                                        })
                                        .foregroundColor(.black)
                                }
                                
                                //Video Link Button
                                if let youtube = viewModel.recipeInfo?.strSource, !youtube.isEmpty {
                                    Button(action: {
                                        viewModel.website = youtube
                                        isSafariShowing = true
                                    }, label: {
                                        ZStack {
                                            Circle()
                                                .frame(width: 50, height: 50)
                                                .foregroundColor(.gray.opacity(0.8))
                                            
                                            Image(systemName: "play.rectangle.fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(height: 14)
                                        }
                                    })
                                    .foregroundColor(.black)
                                }
                            }
                            .padding(.bottom)
                        }
                    }
                    .padding()
                }
                .frame(height: 250)
                
                //MARK: Cuisine Information
                HStack {
                    VStack(alignment: .leading, spacing: 30) {
                        
                        //MARK: Cuisine Information (Title, Subheading)
                        VStack(alignment: .leading, spacing: 0) {
                            Text(viewModel.recipeInfo?.strMeal ?? "")
                                .font(.title)
                                .fontWeight(.heavy)
                                .fontDesign(.rounded)
                            HStack {
                                Text(viewModel.recipeInfo?.strCategory ?? "")
                                    .foregroundColor(.gray)
                                    .bold()
                                Circle()
                                    .frame(width: 5, height: 5)
                                    .foregroundColor(.gray)
                                Text(viewModel.recipeInfo?.strArea ?? "")
                                    .foregroundColor(.gray)
                                    .bold()
                            }
                        }
                        
                        //MARK: Ingredients
                        if let ingredients = viewModel.recipeInfo?.ingredients, let measurements = viewModel.recipeInfo?.measurements {
                            VStack(alignment: .leading, spacing: 5) {
                                Button(action: {
                                    withAnimation(.easeInOut) {
                                        isIngredientsShowing.toggle()
                                    }
                                }, label: {
                                    HStack {
                                        Text("Ingredients")
                                            .font(.title3)
                                            .fontWeight(.bold)
                                            .padding(.bottom)
                                        Spacer()
                                        ZStack {
                                            Circle()
                                                .stroke(.gray, lineWidth: 1)
                                                .frame(width: 23, height: 23)
                                            Image(systemName: "chevron.down")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 10)
                                                .foregroundColor(.black)
                                                .bold()
                                                .rotationEffect(.degrees(isIngredientsShowing ? 180 : 0))
                                        }
                                    }
                                })
                                .foregroundColor(.black)
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    ForEach(Array(zip(ingredients, measurements)).indices, id: \.self) { index in
                                        let ingredient = ingredients[index].capitalized
                                        let measurement = measurements[index]
                                        
                                        //Ingredients HStack
                                        if isIngredientsShowing {
                                            HStack {
                                                Circle()
                                                    .frame(width: 13, height: 13)
                                                    .foregroundColor(.yellow)
                                                Text("\(ingredient):")
                                                Text(measurement)
                                            }
                                        }
                                    }
                                }
                                
                            }
                        }
                        
                        if let instructions = viewModel.recipeInfo?.strInstructions,
                           !instructions.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Directions")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 1)
                                let sentenceComponents = instructions.components(separatedBy: CharacterSet(charactersIn: ".\r\n")).filter {!$0.isEmpty}
                                ForEach(0..<sentenceComponents.count, id: \.self) { index in
                                    let sentence = sentenceComponents[index]
                                    if !sentence.isEmpty {
                                        let steps = sentence.components(separatedBy: "\r\n")
                                        ForEach(steps, id: \.self) { step in
                                            if !step.isEmpty {
                                                HStack {
                                                    ZStack {
                                                        Circle()
                                                            .frame(width: 15, height: 15)
                                                            .foregroundColor(.yellow)
                                                        Text("\(index + 1)")
                                                            .font(.caption2)
                                                    }
                                                    Text("\(step.trimmingCharacters(in: .whitespaces))")
                                                        .font(.body)
                                                        .multilineTextAlignment(.leading)
                                                        .listRowSeparator(.hidden) // Hide separator line
                                                        .padding(.bottom, 0)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                }
                .padding()
                .padding(.bottom)
            }
        }
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $isSafariShowing) {
            SafariView(url: URL(string: viewModel.website)!)
        }
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        //Preview mealID
        MealDetailView(idMeal: "53049")
    }
}
