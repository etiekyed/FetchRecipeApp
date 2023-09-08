//
//  ContentView.swift
//  Etienne_Wasil_FetchRecipeApp
//
//  Created by Etienne Wasil on 9/7/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model = RecipeViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    //MARK: Heading (Title)
                    HStack {
                        Spacer()
                        Text("Recipes")
                            .font(.title)
                            .fontDesign(.rounded)
                            .fontWeight(.heavy)
                        Spacer()
                    }
                    
                    //MARK: Recipies
                    ForEach(model.recipes) { r in
                        NavigationLink(destination: {
                            MealDetailView(idMeal: r.idMeal)
                        }, label: {
                            VStack {
                                AsyncImage(url: URL(string: r.strMealThumb)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 225)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                                //progressView to show image is loading
                            placeholder: {
                                ProgressView()
                            }
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(r.strMeal)
                                            .font(.title3)
                                            .fontWeight(.heavy)
                                        Text("Dessert")
                                            .foregroundColor(.gray)
                                            .bold()
                                    }
                                    Spacer()
                                }
                            }
                        })
                        .foregroundColor(.black)
                    }
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//Extensions to allow swiping to exit NavigationController (this is needed if .navigationBarBackButton is hidden
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
    
    // to make it works also with ScrollView
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}
