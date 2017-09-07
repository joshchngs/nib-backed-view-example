import UIKit

/**
 Custom view backed by a .xib file

 Create a .xib file with the same name as your view class, and set
 the class name of `File's Owner` in Interface Builder to match your
 custom view's class name.

 Conform to this protocol, and call `addNibViewAsSubview()` from your
 custom view's initialiser.

 The first (usually the only) top-level View object will be assigned
 to your nibView property, and you can set up IBOutlet, IBOutletCollection,
 and IBAction references to your custom class in the usual manner.
 */
public protocol NibBackedView : class {}

extension NibBackedView where Self: UIView {
    /**
     Load your custom view's nib

     You MUST call this method from your custom UIView's initialisers.
     init(coder:) is used when instantiating your view from another nib
     or a Storyboard. init(frame:) is used when instantiating your view
     programatically. You can leave out the init() you're not going to
     use if you like.

     awakeFromNib() will be called on your view in all cases, so this is
     the best place to do your setup. The subviews and IBOutlets will be
     configured at the point that awakeFromNib() is called.

     This will load the UINib whose name matches your class name, from
     the Bundle which belongs with your class.
     */
    public func addNibViewAsSubview() throws {
        let name = String(describing: Self.self)

        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: name, bundle: bundle)

        let objects = nib.instantiate(withOwner: self, options: nil)

        guard let view = objects.first as? UIView else {
            throw NibLoadError.viewObjectMissing(className: name, bundle: bundle, objects: objects)
        }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        addSubview(view)
    }
}

public enum NibLoadError: Error {
    /**
     The first object instantiated by the UINib was not a UIView
     */
    case viewObjectMissing(className: String, bundle: Bundle, objects: [Any])
}

