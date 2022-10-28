import SwiftUI

struct NewNavigationTest: View {
	
	@State private var stackedNumbers: [Int] = []
	
	
    var body: some View {
		
		if #available(iOS 16, *) {
			NavigationStack(path: $stackedNumbers) {
				List {
					ForEach(1..<10, id: \.self) { i in
						NavigationLink("Item \(i)", value: i)
					}
				}
				.navigationDestination(for: Int.self) { i in
					Text("Item detail of \(i)")
				}
				//			.navigationDestination(for: String.self) { text in
				//				Text(text)
				//			}
			}
			.onAppear {
				//			stackedNumbers.append(7)
			}
		} else {
			NavigationView {
				Text("iOS 15")
			}
		}
		

    }
}

struct NewNavigationTest_Previews: PreviewProvider {
    static var previews: some View {
        NewNavigationTest()
    }
}
