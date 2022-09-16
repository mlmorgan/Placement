import Foundation
import SwiftUI

struct ExplicitAlignmentModifier<L: PlacementLayout>: ViewModifier {
    @EnvironmentObject var coordinator: Coordinator<L>
    var children: _VariadicView_Children
    var layout: L
    
    func alignment(in dimensions: ViewDimensions, for guide: VerticalAlignment) -> CGFloat {
        coordinator.layoutContext(children: children) { subviews, cache -> CGFloat in
            if let explicitAlignment = layout.explicitAlignment(
                of: guide,
                in: CGRect(origin: .zero, size: coordinator.sizeCoordinator.size ?? .zero),
                proposal: PlacementProposedViewSize(coordinator.sizeCoordinator.size ?? .zero),
                subviews: subviews,
                cache: &cache
            ) {
                return explicitAlignment
            }
            
            return dimensions[guide]
        }
    }
    
    func alignment(in dimensions: ViewDimensions, for guide: HorizontalAlignment) -> CGFloat {
        coordinator.layoutContext(children: children) { subviews, cache -> CGFloat in
            if let explicitAlignment = layout.explicitAlignment(
                of: guide,
                in: CGRect(origin: .zero, size: coordinator.sizeCoordinator.size ?? .zero),
                proposal: PlacementProposedViewSize(coordinator.sizeCoordinator.size ?? .zero),
                subviews: subviews,
                cache: &cache
            ) {
                return explicitAlignment
            }
            
            return dimensions[guide]
        }
    }
    
    func body(content: Content) -> some View {
        content
            .alignmentGuide(VerticalAlignment.top) { d in
                alignment(in: d, for: VerticalAlignment.top)
            }
            .alignmentGuide(VerticalAlignment.center) { d in
                alignment(in: d, for: VerticalAlignment.center)
            }
            .alignmentGuide(VerticalAlignment.bottom) { d in
                alignment(in: d, for: VerticalAlignment.bottom)
            }
            .alignmentGuide(VerticalAlignment.firstTextBaseline) { d in
                alignment(in: d, for: VerticalAlignment.firstTextBaseline)
            }
            .alignmentGuide(VerticalAlignment.lastTextBaseline) { d in
                alignment(in: d, for: VerticalAlignment.lastTextBaseline)
            }
            .alignmentGuide(HorizontalAlignment.leading) { d in
                alignment(in: d, for: HorizontalAlignment.leading)
            }
            .alignmentGuide(HorizontalAlignment.center) { d in
                alignment(in: d, for: HorizontalAlignment.center)
            }
            .alignmentGuide(HorizontalAlignment.trailing) { d in
                alignment(in: d, for: HorizontalAlignment.trailing)
            }
    }
}