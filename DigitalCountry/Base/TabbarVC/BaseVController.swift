
import UIKit

class BaseVController: UIViewController,UINavigationControllerDelegate,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        initNavigationBarTransparent()
    }
    func initNavigationBarTransparent() {
        setStatusBarStyle(style: .default)
        setLeftBarButton(imageName: "icon_titlebar_whiteback")
        setBackgroundColor(color: ColorWhite)
        setNavigationBarBackgroundColor(color: ColorSmoke)
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    func setBackgroundColor(color: UIColor){
        self.view.backgroundColor = color
    }
    func setLeftBarButton(imageName: String){
        let leftBarButton = UIBarButtonItem.init(image: UIImage.init(named: imageName), style: .plain, target: self, action: #selector(back))
        leftBarButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    func setStatusBarHidden(hidden: Bool){
        UIApplication.shared.isStatusBarHidden = hidden
    }
    func setNavgationBarTitle(title: String){
        self.navigationItem.title = title
    }
    func setNavgationBarTitleColor(color: UIColor){
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:color]
    }
    func setNavigationBarBackgroundColor(color:UIColor) {
        self.navigationController?.navigationBar.backgroundColor = color;
    }
    func setNavigationBarBackgroundImage(image:UIImage) {
        self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
    }
    
    func setStatusBarStyle(style:UIStatusBarStyle) {
        UIApplication.shared.statusBarStyle = style
    }
    
    func setStatusBarBackgroundColor(color: UIColor) {
        UIApplication.shared.statusBarView?.backgroundColor = color
    }
    
    func setNavigationBarShadowImage(image:UIImage) {
        self.navigationController?.navigationBar.shadowImage = image;
    }
    func navagationBarHeight()->CGFloat {
        return self.navigationController?.navigationBar.frame.size.height ?? 0;
    }
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
}
