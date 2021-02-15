# Notion Link

[TouchDown](https://www.notion.so/TouchDown-1a818066f90747ebb78fca326ff1d828)

[xCode create your own code snippet](https://www.notion.so/xCode-create-your-own-code-snippet-8da63b3a08c040e5a51b0fc35e4c0368)

[Create custom shape](https://www.notion.so/Create-custom-shape-c68ac1ba7c6e4fa5b11921021f9f7e58)

[TouchDown UILibrary](https://www.notion.so/TouchDown-UILibrary-b4d900f46ab24455b0834aeea5387859)

# What to look for this project

- Custom NavigationBar
- top navigation view aligned well with safe area
- EnvironmentObject

# Project Tips

- Constants.swift

```swift
//
//  Constants.swift
//  touchdown
//
//  Created by paigeshin on 2021/02/14.
//

import SwiftUI

// DATA

let players: [Player] = Bundle.main.decode("player.json")
let categories: [Category] = Bundle.main.decode("category.json")
let products: [Product] = Bundle.main.decode("product.json")
let brands: [Brand] = Bundle.main.decode("brand.json")
let sampleProduct: Product = products[0]

// COLOR

let colorBackground = Color("ColorBackground")
let colorGray = Color(UIColor.systemGray4)

// LAYOUT

let columnSpacing: CGFloat = 10
let rowSpacing: CGFloat = 10
var gridLayout: [GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 2)
}

// UX

let feedback = UIImpactFeedbackGenerator(style: .medium)

// API

// IMAGE

// FONT

// STRING

// MISC
```

# Initial Setup

- In project settings, change some `info.plist` values.

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f3e1eeec-79c7-449b-b438-2e5306542445/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f3e1eeec-79c7-449b-b438-2e5306542445/Untitled.png)

- Launch Screen
    - Image Name: logo-lineal
    - Background color: ColorBackground
- Appearance: Light (don't support Dark)

# Code Snippet

1. Select code and right click, choose option `Create Code Snippet`

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/dc4addd6-a839-4be4-b1b6-abdbab2c0a7e/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/dc4addd6-a839-4be4-b1b6-abdbab2c0a7e/Untitled.png)

2. shortcut - type something on `completion` 

⇒ if you type `cmd` , when you type cmd, the code snippet will appear.

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/35b1f030-b1c7-4892-80fa-ae14866a1a4b/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/35b1f030-b1c7-4892-80fa-ae14866a1a4b/Untitled.png)

3. placeholder (not necessary) - `<#anything#>`

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/110924ef-1575-4363-84ff-2dc29701cf63/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/110924ef-1575-4363-84ff-2dc29701cf63/Untitled.png)

# Bundle extension for decoding local json data

```swift
import Foundation

extension Bundle {
    
    func decode<T: Codable>(_ file: String) -> T {
        
        //1. Locate the JSON file
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle")
        }
        
        //2. Create a property for the data
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) in bundle")
        }
        
        //3. Create a decoder
        let decoder = JSONDecoder()
        
        //4. Create a property for the decoded data
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        //5. Return the ready-to-use data
        return decodedData
    }
    
}
```

# Create Custom Shape (rounded rectangles)

- code

```swift
//
//  CustomShape.swift
//  touchdown
//
//  Created by paigeshin on 2021/02/15.
//

import SwiftUI

struct CustomShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 35, height: 35))
        return Path(path.cgPath)
    }
    
}

struct CustomShape_Previews: PreviewProvider {
    static var previews: some View {
        CustomShape()
            .previewLayout(.fixed(width: 428, height: 120))
            .padding()
    }
}
```

- how to use it

```swift
.background(
          Color.white
              .clipShape(CustomShape())
      )
```

```swift
VStack(alignment: .center, spacing: 0, content: {
                // RATINGS + SIZES
                
                // DESCRIPTION
                ScrollView(.vertical, showsIndicators: false, content: {
                    Text(sampleProduct.description)
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                    
                    // QUANTITY + FAVOURITE
                    
                    
                    // ADD TO CART
                    Spacer()
                })
            }) //: VSTACK
            .padding(.horizontal)
            .background(
                Color.white
                    .clipShape(CustomShape())
            )
```

# Observable Object

### Create object that conforms to `OberservableObject`

- If important changes are made, views will reload
- Any property marked with `@Publisehd` will trigger swiftUI to reload

```swift
//
//  Shop.swift
//  touchdown
//
//  Created by paigeshin on 2021/02/15.
//

import Foundation

class Shop: ObservableObject {
    @Published var showingProduct: Bool = false
    @Published var selectedProduct: Product? = nil
}
```

### Attach it to View

⇒ Attach Environment Object where it's needed.

⇒ Kind of `Global Object` 

- app Entry

```swift
//
//  TouchdownApp.swift
//  touchdown
//
//  Created by paigeshin on 2021/02/14.
//

import SwiftUI

struct TouchdownApp: View {
    var body: some View {
        ContentView()
            .environmentObject(Shop())
    }
}

struct TouchdownApp_Previews: PreviewProvider {
    static var previews: some View {
        TouchdownApp()
    }
}
```

- ContentView

⇒ Transition Screen with `Environment Object`

```swift
//
//  ContentView.swift
//  touchdown
//
//  Created by paigeshin on 2021/02/14.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    
    @EnvironmentObject var shop: Shop
    
    // MARK: - BODY
    
    var body: some View {
        ZStack {
            // ConditaionView with `EnvironmentObject`
            if shop.showingProduct == false && shop.selectedProduct == nil {
                VStack(spacing: 0) {
                    NavigationBarView()
                        .padding()
                        .padding(.bottom)
                        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                        .background(Color.white)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
                    
                    ScrollView(.vertical, showsIndicators: false, content:  {
                        VStack(spacing: 0) {
                            FeaturedTapView()
                                .padding(.vertical, 20)
                            
                            CategoryGridview()
                            
                            TitleView(title: "Helmets")
                            
                            // LazyVGrid, LazyHGrid, 보이지 않는 화면은 rendering하지 않는다. Better Performance
                            // gridLayout: row 2를 가지고 있는 super global variable
                            LazyVGrid(columns: gridLayout, spacing: 15, content: {
                                ForEach(products) { product in
                                    ProductItemView(product: product)
                                        /* Change Screen with `EnvironmentObject` instead of NavigationLink */
                                        .onTapGesture {
                                            withAnimation(.easeOut) {
                                                shop.selectedProduct = product
                                                shop.showingProduct = true
                                            }
                                        }
                                } //: LOOP
                            }) //: GRID
                            .padding(15)
                            
                            TitleView(title: "Brands")
                            
                            BrandgridView()
                            
                            FooterView()
                                .padding(.horizontal)
                        } //: VSTACK
                    }) //: SCROLL
                    
                
                } //: VSTACK
                .background(colorBackground.ignoresSafeArea(.all, edges: .all))
            } else {
                ProductDetailView()
            }
        } //: ZSTACK
        .ignoresSafeArea(.all, edges: .top)
    }
}

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Shop())
    }
}
```

- NavigationBar

```swift
//
//  NavigationBarDetailView.swift
//  touchdown
//
//  Created by paigeshin on 2021/02/15.
//

import SwiftUI

struct NavigationBarDetailView: View {
    // MARK: - PROPERTY
    
    @EnvironmentObject var shop: Shop
    
    // MARK: - BODY
    
    var body: some View {
        HStack {
            Button(action: {
                withAnimation(.easeIn) {
                    shop.selectedProduct = nil
                    shop.showingProduct = false 
                }
            }, label: {
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundColor(.white)
            })
            
            Spacer()
            
            Button(action: {
                
            }, label: {
                Image(systemName: "cart")
                    .font(.title)
                    .foregroundColor(.white)
            })
        }
    }
}

struct NavigationBarDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarDetailView()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.gray)
    }
}
```

- ProductDetailView

```swift
//
//  ProductDetailView.swift
//  touchdown
//
//  Created by paigeshin on 2021/02/15.
//

import SwiftUI

struct ProductDetailView: View {
    // MARK: - PROPERTY
    
    @EnvironmentObject var shop: Shop
    
    // MARK: - BODY
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5, content: {
            
            // NAVBAR
            NavigationBarDetailView()
                .padding(.horizontal)
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            
            // HEADER
            HeaderDetailView()
                .padding(.horizontal)
            
            // DETAIL TOP PART
            TopPartDetailView()
                .padding(.horizontal)
                .zIndex(1)
            
            
            // DETAIL BOTTOM PART
            VStack(alignment: .center, spacing: 0, content: {
                
                // RATINGS + SIZES
                RatingsSizesDetailView()
                    .padding(.top, -20)
                    .padding(.bottom, 10)
                
                // DESCRIPTION
                ScrollView(.vertical, showsIndicators: false, content: {
                    Text(shop.selectedProduct?.description ?? sampleProduct.description)
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                    
                    // QUANTITY + FAVOURITE
                    QuantityFavouriteDetailView()
                        .padding(.vertical, 10)
                    
                    // ADD TO CART
                    AddToCartDetailView()
                        .padding(.bottom, 20)
                    
                })
            }) //: VSTACK
            .padding(.horizontal)
            .background(
                Color.white
                    .clipShape(CustomShape())
                    .padding(.top, -105)
            )
            
        }) //: VSTACK
        .zIndex(0)
        .ignoresSafeArea(.all, edges: .all)
        .background(
            Color(
                red: sampleProduct.red,
                green: sampleProduct.green,
                blue: sampleProduct.blue)
        ).ignoresSafeArea(.all, edges: .all)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView()
            .environmentObject(Shop())
            .previewLayout(.fixed(width: 375, height: 812))
    }
}
```

- HeaderDetailView

```swift
//
//  HeaderDetailView.swift
//  touchdown
//
//  Created by paigeshin on 2021/02/15.
//

import SwiftUI

struct HeaderDetailView: View {
    // MARK: - PROPERTIES
    
    @EnvironmentObject var shop: Shop
    
    // MARK: - BODY
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6, content: {
            Text("Protective Gear")
            
            Text(shop.selectedProduct?.name ?? sampleProduct.name)
                .font(.largeTitle)
                .fontWeight(.black)
        }) //: VSTACK
        .foregroundColor(.white)
    }
}

struct HeaderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderDetailView()
            .environmentObject(Shop())
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.gray)
    }
}
```

- TopDetailView

```swift
//
//  TopPartDetailView.swift
//  touchdown
//
//  Created by paigeshin on 2021/02/15.
//

import SwiftUI

struct TopPartDetailView: View {
    // MARK: - PROPERTY
    
    @EnvironmentObject var shop: Shop
    @State private var isAnimating: Bool = false
    
    // MARK: - BODY
    
    var body: some View {
        HStack(alignment: .center, spacing: 6, content: {
            //PRICE
            VStack(alignment: .leading, spacing: 6, content: {
                Text("Price")
                    .fontWeight(.semibold)
                
                Text(shop.selectedProduct?.formattedPrice ?? sampleProduct.formattedPrice)
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .scaleEffect(1.35, anchor: .leading)
            })
            .offset(y: isAnimating ? -50 : -75)
            
            Spacer()
            
            //PHOTO
            Image(shop.selectedProduct?.image ?? sampleProduct.image)
                .resizable()
                .scaledToFit()
                .offset(y: isAnimating ? 0 : -75)
            
        }) //: HSTACK
        .onAppear(perform: {
            withAnimation(.easeOut(duration: 0.75)) {
                isAnimating.toggle()
            }
        })
    }
}

struct TopPartDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TopPartDetailView()
            .environmentObject(Shop())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
```

- AddToCartDetailView

```swift
//
//  Created by Robert Petras
//  SwiftUI Masterclass ♥ Better Apps. Less Code.
//  https://swiftuimasterclass.com
//

import SwiftUI

struct AddToCartDetailView: View {
  // MARK: - PROPERTY
  
  @EnvironmentObject var shop: Shop
  
  // MARK: - BODY
  
  var body: some View {
    Button(action: {
//      feedback.impactOccurred()
    }, label: {
      Spacer()
      Text("Add to cart".uppercased())
        .font(.system(.title2, design: .rounded))
        .fontWeight(.bold)
        .foregroundColor(.white)
      Spacer()
    }) //: BUTTON
    .padding(15)
    .background(
      Color(
        red: shop.selectedProduct?.red ?? sampleProduct.red,
        green: shop.selectedProduct?.green ?? sampleProduct.green,
        blue: shop.selectedProduct?.blue ?? sampleProduct.blue
      )
    )
    .clipShape(Capsule())
  }
}

// MARK: - PREVIEW

struct AddToCartDetailView_Previews: PreviewProvider {
  static var previews: some View {
    AddToCartDetailView()
      .environmentObject(Shop())
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
```