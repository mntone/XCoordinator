//
//  StaticTransitionAnimation.swift
//  XCoordinator
//
//  Created by Stefan Kofler on 03.05.18.
//  Copyright © 2018 QuickBird Studios. All rights reserved.
//

///
/// `StaticTransitionAnimation` can be used to realize static transition animations.
///
/// - Note:
///     Consider using `InteractiveTransitionAnimation` instead, if possible, as it is as simple
///     to use. However, this class is helpful to make sure your transition animation is not mistaken to be
///     interactive, if your animation code does not fulfill the requirements of an interactive transition
///     animation.
///
open class StaticTransitionAnimation: NSObject, TransitionAnimation {

    // MARK: - Stored properties

    internal let duration: TimeInterval
    #if os(macOS)
    private let _performAnimation: (_ transitionContext: NSViewControllerContextTransitioning) -> Void
    #else
    private let _performAnimation: (_ transitionContext: UIViewControllerContextTransitioning) -> Void
    #endif

    // MARK: - Computed properties

    #if os(iOS) || os(tvOS)
    open var interactionController: PercentDrivenInteractionController? {
        return self as? PercentDrivenInteractionController
    }
    #endif

    // MARK: - Initialization

    ///
    /// Creates a StaticTransitionAnimation to be used as presentation or dismissal transition animation in
    /// an `Animation` object.
    ///
    /// - Parameters:
    ///     - duration: The total duration of the animation.
    ///     - performAnimation: A closure performing the animation.
    ///     - context:
    ///         From the context, you can access source and destination views and
    ///         viewControllers and the containerView.
    ///
    #if os(macOS)
    public init(duration: TimeInterval, performAnimation: @escaping (_ context: NSViewControllerContextTransitioning) -> Void) {
        self.duration = duration
        self._performAnimation = performAnimation
    }
    #else
    public init(duration: TimeInterval, performAnimation: @escaping (_ context: UIViewControllerContextTransitioning) -> Void) {
        self.duration = duration
        self._performAnimation = performAnimation
    }
    #endif

    #if os(macOS)

    // MARK: - Methods

    /// This method performs the animation.
    open func animate(using transitionContext: NSViewControllerContextTransitioning) {
        _performAnimation(transitionContext)
    }

    #else

    // MARK: - Methods

    ///
    /// See [UIViewControllerAnimatedTransitioning](https://developer.apple.com/documentation/uikit/UIViewControllerAnimatedTransitioning)
    /// for further information.
    ///
    /// - Parameter transitionContext:
    ///     The context of the current transition.
    ///
    /// - Returns:
    ///     The duration of the animation as specified in the initializer.
    ///
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    ///
    /// See [UIViewControllerAnimatedTransitioning](https://developer.apple.com/documentation/uikit/UIViewControllerAnimatedTransitioning)
    /// for further information.
    ///
    /// This method performs the animation as specified in the initializer.
    ///
    /// - Parameter transitionContext:
    ///     The context of the current transition.
    ///
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        _performAnimation(transitionContext)
    }

    // MARK: - TransitionAnimation

    open func start() {}
    open func cleanup() {}

    #endif
}

#if os(iOS) || os(tvOS)
extension StaticTransitionAnimation {

    ///
    /// This method performs the animation as specified in the initializer.
    ///
    /// - Parameter transitionContext:
    ///     The context of the current transition.
    ///
    @available(*, deprecated, renamed: "animateTransition(using:)")
    public func performTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        _performAnimation(transitionContext)
    }
}
#endif
