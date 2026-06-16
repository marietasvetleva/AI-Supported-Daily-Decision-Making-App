import SwiftUI

struct PermissionsView: View {
    @StateObject private var viewModel = PermissionsViewModel()
    @State private var locationEnabled = false
    @State private var notificationsEnabled = false
    @State private var calendarEnabled = false
    
    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.95, blue: 0.92)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 24) {
                
                Text("Allow access")
                    .font(.system(size: 34, weight: .bold))
                
                Text("For real-time context we need a few permissions.")
                    .font(.system(size: 17))
                    .foregroundColor(.gray)
                
                permissionCard(
                    icon: "location.fill",
                    title: "Location",
                    subtitle: "Live routes & nearby spots",
                    isOn: $locationEnabled
                )
                
                permissionCard(
                    icon: "bell.fill",
                    title: "Notifications",
                    subtitle: "Timely reminders",
                    isOn: $notificationsEnabled
                )
                
                permissionCard(
                    icon: "calendar",
                    title: "Calendar",
                    subtitle: "Smarter scheduling",
                    isOn: $calendarEnabled
                )
                
                Spacer()
                
                NavigationLink {
                    HomeView()
                } label: {
                    Text("Next")
                        .font(.system(size: 17,
                                      weight: .semibold,
                                      design: .monospaced))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 58)
                        .background(
                            Color(
                                red: 0.10,
                                green: 0.65,
                                blue: 0.50
                            )
                        )
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 28)
            .padding(.top, 70)
            .padding(.bottom, 34)
        }
    }
    
    private func permissionCard(
        icon: String,
        title: String,
        subtitle: String,
        isOn: Binding<Bool>
    ) -> some View {
        
        HStack(spacing: 16) {
            
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.15))
                .frame(width: 56, height: 56)
                .overlay(
                    Image(systemName: icon)
                        .font(.system(size: 22))
                        .foregroundColor(.gray)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(title)
                    .font(.headline)
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Toggle("", isOn: isOn)
                .labelsHidden()
                .tint(Color(red: 0.10, green: 0.65, blue: 0.50))
                .onChange(of: isOn.wrappedValue) { _, value in
                    if value {
                        requestPermission(for: title)
                    }
                }
        }
        .padding()
        .background(.white)
        .cornerRadius(18)
    }
    
    private func requestPermission(for title: String) {
        if title == "Location" {
            viewModel.requestLocation()
        }
    }
}
    
#Preview {
    NavigationStack {
        PermissionsView()
            .environmentObject(UserPreferencesViewModel())
    }
}
