
import UIKit

class SlideTabbarController:  UITabBarController, TSSlidingUpPanelStateDelegate  {
    
    @IBOutlet var tarbBar: UITabBar!
    var slidingUpVC: TeamInfoViewController!
    let slideUpPanelManager: TSSlidingUpPanelManager = TSSlidingUpPanelManager.with
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slidingUpVC = (storyboard?.instantiateViewController(withIdentifier: "teaminfo"))! as! TeamInfoViewController
        // Do any additional setup after loading the view.
        slideUpPanelManager.slidingUpPanelStateDelegate = self
        
        slideUpPanelManager.initPanelWithTabBar(inView: view, tabBar: tabBar, slidingUpPanelView: slidingUpVC.view, slidingUpPanelHeaderSize: 49)
        
        
        slideUpPanelManager.changeSlideUpPanelStateTo(toState: SLIDE_UP_PANEL_STATE.DOCKED)
    }
    
    func slidingUpPanelStateChanged(slidingUpPanelNewState: SLIDE_UP_PANEL_STATE, yPos: CGFloat) {
        
    }
}
