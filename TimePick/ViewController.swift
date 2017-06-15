//
//  ViewController.swift
//  TimePick
//
//  Created by leekexi on 2017/6/14.
//  Copyright © 2017年 kiepo. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    var last_select_time_value:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        view.backgroundColor = .white
        
        let select_btn:UILabel = UILabel(frame: CGRect(x: (self.view.frame.width-100)/2,y: 200,width: 100,height: 50))
        select_btn.text = "Time Select"
        select_btn.textAlignment = .center
        select_btn.textColor = UIColor.white
        select_btn.layer.masksToBounds = true
        select_btn.layer.cornerRadius = 5
        select_btn.backgroundColor = UIColor(red: 251/255, green: 68/255, blue: 129/255, alpha: 1)
        self.view.addSubview(select_btn)
        
        let selectAction:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(open_time_select))
        select_btn.isUserInteractionEnabled = true
        select_btn.addGestureRecognizer(selectAction)
        
        
        
        
        last_select_time_value = UILabel(frame: CGRect(x: 20,y: 260,width: self.view.frame.width - 40,height: 70))
        last_select_time_value.text = "00:00-00:00"
        last_select_time_value.textAlignment = .center
        last_select_time_value.font = UIFont(name: "STHeitiTC-Light", size: 20)
        last_select_time_value.textColor = UIColor(red: 251/255, green: 68/255, blue: 129/255, alpha: 1)
        self.view.addSubview(last_select_time_value)
        
        
        
        make_time_pick()
        
    }
    
    
    func open_time_select()
    {
        if !is_show
        {
            is_show = true
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.5)
            self.time_content_view.frame = CGRect(x:0, y: self.view.frame.height-300, width:self.self.view.frame.width, height:300)
            UIView.commitAnimations()
        }
        else
        {
            is_show = false
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.5)
            self.time_content_view.frame = CGRect(x:0, y: self.view.frame.height, width:self.self.view.frame.width, height:300)
            UIView.commitAnimations()
        }
        
    }
    
    
    //------------------------make time view start-----------------------//
    var is_show:Bool = false
    var time_content_view:UIView!
    var time_pick_start:UIPickerView!
    var time_pick_end:UIPickerView!
    var pick_view_width:CGFloat = 0
    var hours:NSArray = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"]
    var mins:NSArray = ["00","10","20","30","40","50"]
    var select_time_value:UILabel!
    func make_time_pick()
    {
        
        time_content_view = UIView(frame: CGRect(x: -1,y: self.view.frame.height,width: self.view.frame.width+2,height: 300))
        time_content_view.layer.borderWidth = 0.5
        time_content_view.layer.borderColor = UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 0.5).cgColor
        self.view.addSubview(time_content_view)
        
        pick_view_width = (self.view.frame.width - 60)/2
        
        select_time_value = UILabel(frame: CGRect(x: 20,y: 0,width: self.view.frame.width - 40,height: 70))
        select_time_value.text = "00:00-00:00"
        select_time_value.textAlignment = .center
        select_time_value.font = UIFont(name: "STHeitiTC-Light", size: 20)
        select_time_value.textColor = UIColor(red: 251/255, green: 68/255, blue: 129/255, alpha: 1)
        time_content_view.addSubview(select_time_value)
        
        let start_lab:UILabel = UILabel(frame: CGRect(x: 20,y: 70,width: pick_view_width,height: 30))
        start_lab.text = "Start Time"
        start_lab.textAlignment = .center
        start_lab.font = UIFont(name: "STHeitiTC-Light", size: 16)
        start_lab.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        time_content_view.addSubview(start_lab)
        
        let end_lab:UILabel = UILabel(frame: CGRect(x: 40+pick_view_width,y: 70,width: pick_view_width,height: 30))
        end_lab.text = "End Time"
        end_lab.textAlignment = .center
        end_lab.font = UIFont(name: "STHeitiTC-Light", size: 16)
        end_lab.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        time_content_view.addSubview(end_lab)
        
        //start pick
        time_pick_start = UIPickerView(frame: CGRect(x: 20,y: 100,width: pick_view_width,height: 160))
        time_pick_start.showsSelectionIndicator = true
        time_pick_start.dataSource = self
        time_pick_start.delegate = self
        time_pick_start.tag = 2000
        self.time_content_view.addSubview(time_pick_start)
        
        //end pick
        time_pick_end = UIPickerView(frame: CGRect(x: 40+pick_view_width,y: 100,width: pick_view_width,height: 160))
        time_pick_end.showsSelectionIndicator = true
        time_pick_end.dataSource = self
        time_pick_end.delegate = self
        time_pick_end.tag = 3000
        self.time_content_view.addSubview(time_pick_end)
        
        //button lab
        let cancel_lab:UILabel = UILabel(frame: CGRect(x: 0,y: 260,width: self.view.frame.width/2,height: 40))
        cancel_lab.text = "Cancel"
        cancel_lab.textAlignment = .center
        cancel_lab.tag = 200
        cancel_lab.font = UIFont(name: "STHeitiTC-Light", size: 16)
        cancel_lab.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        time_content_view.addSubview(cancel_lab)
        
        //cancel action
        let cancelAction:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(action_func(_:)))
        cancel_lab.isUserInteractionEnabled = true
        cancel_lab.addGestureRecognizer(cancelAction)
        
        //button lab
        let ok_lab:UILabel = UILabel(frame: CGRect(x: self.view.frame.width/2,y: 260,width: self.view.frame.width/2,height: 40))
        ok_lab.text = "OK"
        ok_lab.textAlignment = .center
        ok_lab.tag = 300
        ok_lab.font = UIFont(name: "STHeitiTC-Light", size: 16)
        ok_lab.textColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        time_content_view.addSubview(ok_lab)
        
        //ok action
        let okAction:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(action_func(_:)))
        ok_lab.isUserInteractionEnabled = true
        ok_lab.addGestureRecognizer(okAction)
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0
        {
            return hours.count
        }
        
        return mins.count
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == 0
        {
            return pick_view_width/2
        }
        
        return pick_view_width/2
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 50
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let value_array = select_time_value.text!.components(separatedBy: "-")
        
        var start_hour = value_array[0].components(separatedBy: ":")[0]
        var start_min = value_array[0].components(separatedBy: ":")[1]
        
        var end_hour = value_array[1].components(separatedBy: ":")[0]
        var end_min = value_array[1].components(separatedBy: ":")[1]
        
        if component == 0
        {
            if pickerView.tag == 2000
            {
                start_hour = hours[row] as! String
            }
            else
            {
                end_hour = hours[row] as! String
            }
            //set value
            select_time_value.text = "\(start_hour):\(start_min)-\(end_hour):\(end_min)"
            return
        }
        
        if pickerView.tag == 2000
        {
            start_min = mins[row] as! String
        }
        else
        {
            end_min = mins[row] as! String
        }

        //set value
        select_time_value.text = "\(start_hour):\(start_min)-\(end_hour):\(end_min)"
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0
        {
            return hours[row] as? String
        }
        
        return mins[row] as? String
    }
    
    func action_func(_ tapView:UITapGestureRecognizer )
    {
        //hiden pick view
        is_show = false
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        self.time_content_view.frame = CGRect(x:0, y: self.view.frame.height, width:self.self.view.frame.width, height:300)
        UIView.commitAnimations()
        
        
        let fgView:UIView = UIView(frame: CGRect(x: 0,y: 0,width: tapView.view!.frame.width,height: tapView.view!.frame.height))
        fgView.backgroundColor = UIColor(red: 207/255, green: 207/255, blue: 207/255, alpha: 0.6)
        tapView.view!.addSubview(fgView)
        let userInfo = NSMutableArray()
        userInfo.add(fgView)
        userInfo.add(tapView.view!.tag)
        
        Thread.detachNewThreadSelector(#selector(Picker_thread(_:)), toTarget: self, with: userInfo)
    }
    
    func Picker_thread(_ userInfo:NSMutableArray)
    {
        let delayTime = DispatchTime.now() + Double(Int64(0.15 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) { () -> Void in
            
            (userInfo.object(at: 0) as! UIView).removeFromSuperview()
            let tag = userInfo.object(at: 1) as! Int
            if tag == 300
            {
                self.last_select_time_value.text = self.select_time_value.text!
            }
            
        }
    }
    
    //------------------------make time view end-----------------------//
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

