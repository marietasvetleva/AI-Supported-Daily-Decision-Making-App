import SwiftUI

struct PlanningView: View {
    @State private var destination: String = ""
    @State private var selectedTab = 1
    
    let recentPlaces = ["Central Station", "Fontys R10"]
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 28) {
                    
                    
                    Text("Plan a route")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.primary)
                    
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("From")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.primary)
                        
                        HStack(spacing: 14) {
                            Image(systemName: "location.circle")
                                .font(.system(size: 20))
                                .foregroundColor(.primary)
                            
                            Text("Current Location")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.primary)
                                .fontDesign(.monospaced)
                        }
                        .padding(.horizontal, 18)
                        .padding(.vertical, 18)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(hex: "#ECEAE4"))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("To")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.primary)
                        
                        HStack(spacing: 14) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.primary)
                            
                            TextField("", text: $destination, prompt:
                                        Text("Search Destinations")
                                .foregroundColor(Color(hex: "#9A9A9A"))
                                .font(.system(size: 16).monospaced())
                            )
                            .font(.system(size: 16).monospaced())
                            .foregroundColor(.primary)
                        }
                        .padding(.horizontal, 18)
                        .padding(.vertical, 18)
                        .background(Color(hex: "#ECEAE4"))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Recent")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(.primary)
                        
                        VStack(spacing: 10) {
                            ForEach(recentPlaces, id: \.self) { place in
                                Button(action: { destination = place }) {
                                    Text(place)
                                        .font(.system(size: 16).monospaced())
                                        .foregroundColor(.primary)
                                        .padding(.horizontal, 18)
                                        .padding(.vertical, 18)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color(hex: "#ECEAE4"))
                                        .clipShape(RoundedRectangle(cornerRadius: 14))
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    
                    
                    Button(action: {}) {
                        HStack(spacing: 10) {
                            Text("→")
                                .font(.system(size: 18, weight: .semibold).monospaced())
                            Text("Find Routes")
                                .font(.system(size: 17, weight: .semibold).monospaced())
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(Color(hex: "#2D7A5F"))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .buttonStyle(.plain)
                    .padding(.top, 8)
                }
                .padding(.horizontal, 20)
                .padding(.top, 28)
                .padding(.bottom, 40)
            }
            .background(Color(hex: "#F2EFE9"))
        }
        .ignoresSafeArea(edges: .bottom)
    }
}
    
    #Preview {
        PlanningView()
    }

