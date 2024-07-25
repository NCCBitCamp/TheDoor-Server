package com.bit.springboard.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class RozerController {



//**********************************************  1층  *********************************************************
//    공통부분 (인벤?)
//**********************************************  2층  *********************************************************

    // 2_Cd 부터 시작 : Ld<-->Rd
    @RequestMapping("/darkToLeft.do")
    public String darkToLeft(){
        return "rozerStone/floor2/Part_2_Ld";
    }

    @RequestMapping("/darkToCenter.do")
    public String darkToCenter(){
        return "rozerStone/floor2/Part_2_Cd";
    }

    @RequestMapping("/darkToRight.do")
    public String darkToRight(){
        return "rozerStone/floor2/Part_2_Rd";
    }

    @RequestMapping("/darkToScript2.do")
    public String darkToScript2(){
        return "rozerStone/floor2/Part_2_Script2";
    }

    @RequestMapping("/script2ToRight.do")
    public String script2ToRight(){
        return "rozerStone/floor2/Part_2_Script2";
    }


// Rd -> R 넘어가기 / <- 까지 매핑포스트로 바꾸기
    @RequestMapping("/lightToRight.do")
    public String lightToRight(){
        return "rozerStone/floor2/Part_2_R";
    }
    @RequestMapping("/lightToCenter.do")
    public String lightToCenter(){
        return "rozerStone/floor2/Part_2_C";
    }
    @RequestMapping("/lightToLeft.do")
    public String lightToLeft(){
        return "rozerStone/floor2/Part_2_L";
    }
}
