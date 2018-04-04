import UIKit
import CoreLocation
import MapKit
import Parse

let kFirstTimeRadius:CLLocationDistance = 10000
let kCommonRadius:CLLocationDistance = 1500
let kDefaultLocation = CLLocation(latitude: 49.246292, longitude: -123.116226)

class MapVC: UIViewController {
    
    var objLatitude:Double!
    var objLongitude:Double!
    var objLocation:CLLocation!
    var strAddress : String!
    var arrRegion:[ClsRegion]!
    var strCurrentRegionId:String!
    var objTransitionController:TransitionDelegate!
    var objCurrentRegion:ClsRegion!
    var objOverlay:MKOverlay!
    
    @IBOutlet var mapViewShowAddress: MKMapView!
    
    //    MARK:- ViewController lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapViewShowAddress.removeAnnotations(self.mapViewShowAddress.annotations)
        initializeOnce()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //    MARK:- Inititalize
    
    func initializeOnce(){
        
        if arrRegion == nil {
            arrRegion = Array()
        }
        objTransitionController = TransitionDelegate()
        modalyOpenLocationVC()
        
        //  Set default coordinate of Vancouver
        let initialLocation = kDefaultLocation
        self.centerMapOnLocation(initialLocation, regionRadius: kFirstTimeRadius)
    }
    
    //   MARK:- Location helper methods
    
    // Shows Pin on map.
    func showAnnotation(pLocation:CLLocation,pRegionName:String){
        
        if(pLocation != 0){
            
            let objLocation = CLLocationCoordinate2D(latitude: self.objLatitude,
                longitude: self.objLongitude)
            
            let objBlueAnnotation = MyAnnotation(coordinate: objLocation,
                title:pRegionName,
                subtitle: "" ,  pinColor: .Red)
            
            self.mapViewShowAddress.addAnnotation(objBlueAnnotation)
        }
        self.mapViewShowAddress.showsUserLocation = false
    }
    
    //    MARK:- Draw Bazierpath methods
    
    // Checks if a region contains the Searched location !
    func contains(objPolygon: [CGPoint], objPoints: CGPoint) -> Bool {
        
        if objPolygon.count <= 1 {
            return false
        }
        
        var objPath = UIBezierPath()
        let objFirstPoint = objPolygon[0] as CGPoint
        objPath.moveToPoint(objFirstPoint)
        
        for index in 0...objPolygon.count-1 {
            objPath.addLineToPoint(objPolygon[index] as CGPoint)
        }
        
        objPath.closePath()
        return objPath.containsPoint(objPoints)
    }
    
    // Draws region on the map.
    func addBoundry(var arrCoords:[CGPoint])
    {
        var arrCoordinate2D:[CLLocationCoordinate2D] = Array()
        
        for(var i:Int = 0; i < arrCoords.count; i++){
            
            let objPoint:CGPoint = arrCoords[i] as CGPoint
            let objCoordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(Double(objPoint.x), Double(objPoint.y))
            arrCoordinate2D.append(objCoordinate)
        }
        let objPolygon = MKPolygon(coordinates: &arrCoordinate2D, count: arrCoordinate2D.count)
        objOverlay = objPolygon
        mapViewShowAddress.addOverlay(objPolygon)
    }
    
    //    MARK:- MKMapview delegate methods
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        
        showDetailScreen()
        self.mapViewShowAddress.deselectAnnotation(view.annotation, animated: false)
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
        if overlay is MKPolygon {
            
            let objPolygonView = MKPolygonRenderer(overlay: overlay)
            objPolygonView.strokeColor = objAppColor
            return objPolygonView
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView {
        
        var objUserAnnotationView: MKAnnotationView? = nil
        objUserAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "UserLocation")
        
        objUserAnnotationView!.annotation = annotation
        objUserAnnotationView!.enabled = true
        objUserAnnotationView!.canShowCallout = true
        objUserAnnotationView?.image = UIImage(named: customPinImage)
        
        var btnShowDetail:UIButton = UIButton()
        btnShowDetail.backgroundColor = UIColor.brownColor()
        btnShowDetail.addSubview(objUserAnnotationView!)
        return objUserAnnotationView!
    }
    
    // Sets center of the map.
    func centerMapOnLocation(location: CLLocation,regionRadius:CLLocationDistance) {
        
        let objCoordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapViewShowAddress.setRegion(objCoordinateRegion, animated: true)
    }
    
    //    MARK:- IBAction method
    
    @IBAction func btnAddClicked(sender: AnyObject) {
        modalyOpenLocationVC()
    }
    
    //    MARK:- Other methods
    
    // Shows alert message
    func showMessage(text: String, withTitle title: String, withColor buttonColor: UIColor) {
        
        let objCustomAlert:CustomAlert = CustomAlert(title: APPNAME, message: text, delegate: nil, color: buttonColor, cancelButtonTitle: "OK", otherButtonTitle: nil, completion: nil)
        
        for objView:UIView in self.view.subviews as! Array {
            
            if objView.isKindOfClass(CustomAlert) {
                objView.removeFromSuperview()
            }
        }
        objCustomAlert.showInView(self.view)
    }
    
    // Shows location popup.
    func modalyOpenLocationVC(){
        
        let objStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let objLocationVc:LocationVC = objStoryboard.instantiateViewControllerWithIdentifier("LocationVC") as! LocationVC
        
        objLocationVc.transitioningDelegate = objTransitionController
        objLocationVc.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        self.presentViewController(objLocationVc, animated: true, completion: nil)
        objLocationVc.objSendLocation = { (var objData:AnyObject!,var address:AnyObject) -> () in
            
            self.mapViewShowAddress.removeAnnotations(self.mapViewShowAddress.annotations)
            self.mapViewShowAddress.removeOverlay(self.objOverlay)
            self.objLocation = objData as! CLLocation
            self.objLatitude = self.objLocation.coordinate.latitude
            self.objLongitude = self.objLocation.coordinate.longitude
            self.strAddress = address as! String
            self.getRegion()
        }
    }
    
    func showDetailScreen(){
        
        let objStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil) 
        let objDetailVC:DetailVC = objStoryboard.instantiateViewControllerWithIdentifier("DetailVC") as! DetailVC
        objDetailVC.strRegionId = self.strCurrentRegionId
        objDetailVC.objCurrentRegion = objCurrentRegion
        objDetailVC.transitioningDelegate = objTransitionController
        objDetailVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        self.presentViewController(objDetailVC, animated: true, completion: nil)
    }
    
    func getRegion(){
        
        if(arrRegion.count == 0){
            
            let objRegionQuery = PFQuery(className: "tblRegion")
            objRegionQuery.findObjectsInBackgroundWithBlock({ (objRegionData, error) -> Void in
                
                if(error == nil){
                    
                    let arrTmpRegionData:[PFObject] = objRegionData as! Array
                    
                    for index in 0...arrTmpRegionData.count-1 {
                        
                        let objParseDict:PFObject = arrTmpRegionData[index] as PFObject
                        let objclsRegion:ClsRegion = ClsRegion.initWithPFObject(objParseDict)
                        self.arrRegion.append(objclsRegion)
                    }
                    self.fetchData(self.arrRegion)
                }
                else{
                    
                    SwiftLoader.hide()
                    let objCustomAlert:CustomAlert = CustomAlert(title: APPNAME, message: INTERNETNOTAVAILABLE, delegate: nil, color: objAppColor, cancelButtonTitle: "OK", otherButtonTitle: nil, completion: nil)
                    objCustomAlert.showInView(self.view)
                }
            })
        }
        else{
            self.fetchData(arrRegion)
        }
    }
    
    
    func fetchData(parrRegionData:[ClsRegion]!){
        
        var isContainsObject:Bool = false
        
        for index in 0...parrRegionData.count-1 {
            
            let objclsRegion:ClsRegion = parrRegionData[index] as ClsRegion
            let fltXVal:CGFloat = CGFloat(self.objLatitude as Double)
            let fltYVal:CGFloat = CGFloat(self.objLongitude as Double)
            let objPinPoint = CGPointMake(fltXVal, fltYVal)
            
            if(objclsRegion.arrCoordinates != nil){
                
                let doesContains:Bool = self.contains(objclsRegion.arrCoordinates, objPoints: objPinPoint)
                SwiftLoader.hide()
                
                if(doesContains == true){
                    isContainsObject = true
                    self.objCurrentRegion = objclsRegion
                    self.showAnnotation(self.objLocation, pRegionName:objclsRegion.strRegionName)
                    self.addBoundry(objclsRegion.arrCoordinates)
                    
                    let fltDelay = 0.5 * Double(NSEC_PER_SEC)
                    let fltTime = dispatch_time(DISPATCH_TIME_NOW, Int64(fltDelay))
                    dispatch_after(fltTime, dispatch_get_main_queue(), {
                        NSThread.detachNewThreadSelector(Selector("showDetailScreen"), toTarget:self, withObject:nil)
                    })
                }
            }
            
            let objInitialLocation = CLLocation(latitude: self.objLatitude, longitude: self.objLongitude)
            
            dispatch_async(dispatch_get_main_queue()) {
                self.centerMapOnLocation(objInitialLocation, regionRadius: kCommonRadius)
            }
        }
        
        if(isContainsObject == false){
            
            SwiftLoader.hide()
            self.showAnnotation(self.objLocation, pRegionName: "")
            self.showMessage(NOTFOUNDREGION, withTitle: APPNAME, withColor: objAppColor)
        }
    }
    
    //    MARK:- Memory warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
