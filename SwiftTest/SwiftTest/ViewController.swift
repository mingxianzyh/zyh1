//
//  ViewController.swift
//  SwiftTest
//
//  Created by sunlight on 14-9-28.
//  Copyright (c) 2014年 wisdom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var list = Array<String>();
        var list2 = [String]();
        var list3 = [];
        
        var dic = Dictionary<String,String>();
        var dic2 = [:];
        
    }
    
    
    
    func max(a:Int,b:Int)->Int{
        
        var maxValue:Int;
        if a-b > 0{
            maxValue = a;
        }else{
            maxValue = b;
        }
        NSLog("%d",maxValue);
        return maxValue;
    }
    
    func  sayHello(value :String,value1:String){
        var str = value + " " +  value1
        println(str)
        println(UInt8.max);
        println(Int8.max)
        println(UInt8.min);
        println(Int8.min)

    }
    
    func test1(){
        //初始化数组
        var list = ["a","b","c","d","e","f"];
        //初始化字典
        var dic:Dictionary = ["a":"A","b":"B"]
        //三种循环方式
        for a in list {
            println(a);
        }
        println("--------------");
        for var i=0; i < list.count;i++ {
            println(list[i]);
        }
        println("--------------");
        
        for i in 0..<list.count {
            println(list[i])
        }
        println("--------------");
        
        
        max(5,b: 10);
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

