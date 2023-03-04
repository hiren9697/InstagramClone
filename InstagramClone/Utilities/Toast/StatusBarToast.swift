import UIKit

// MARK: - Class
class StatusBarToast: UIView {
    
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var constrTop: NSLayoutConstraint!
    
    lazy var toastHeight = Geometry.statusbarHeight + 20
    private lazy var toastWondow: UIWindow = {
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: Geometry.screenWidth, height: toastHeight))
        window.windowLevel = .alert + 1
        return window
    }()
    public static let shared = Bundle.main.loadNibNamed("StatusBarToast", owner: nil, options: nil)!.first as! StatusBarToast
    private var isShown = false
}

// MARK: - UI related method(s)
extension StatusBarToast {
    
    public func show(message: String, backColor: UIColor = .red) {
        if isShown {
            animateMessage(message: message)
            return
        }
        isShown = true
        lbl.text = message
        containerView.backgroundColor = backColor
        addToastWindow()
        animateIn()
    }
    
    public func hide() {
        animateOut()
    }
    
    private func addToastWindow() {
        toastWondow.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        //self.addConstraintToSuperView(lead: 0, trail: 0, top: 0, bottom: 0)
        self.addAnchors(top: YAnchor(anchor: toastWondow.topAnchor, constant: 0),
                        bottom: YAnchor(anchor: toastWondow.bottomAnchor, constant: 0),
                        leading: XAnchor(anchor: toastWondow.leadingAnchor, constant: 0),
                        trailing: XAnchor(anchor: toastWondow.trailingAnchor, constant: 0))
        self.layoutIfNeeded()
        App.appDelegator.window?.addSubview(toastWondow)
        toastWondow.makeKeyAndVisible()
    }
    
    private func animateMessage(message: String) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.lbl.text = message
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func animateIn() {
        self.layoutIfNeeded()
        constrTop.constant = -toastHeight
        layoutIfNeeded()
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.constrTop.constant = 0
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func animateOut() {
        isShown = false
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.constrTop.constant = -self.toastHeight
            self.layoutIfNeeded()
        }, completion: { (_) in
            self.toastWondow.removeFromSuperview()
            self.toastWondow.resignKey()
        })
    }
}
