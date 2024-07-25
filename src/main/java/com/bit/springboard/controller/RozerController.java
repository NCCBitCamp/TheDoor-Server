package com.bit.springboard.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RozerController {



//**********************************************  1층  *********************************************************
//    공통부분 (인벤?)
    @RequestMapping("/inventory.do")
    public String inventory(){
        return "rozerStone/integ/Inventory_temp";
    }
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
        return "rozerStone/floor2/Part_2-Script2";
    }

//    Rd -> R 넘어가기 / <- 까지 매핑포스트로 바꾸기
//**************************    다크 ->> 라이트    **************************

    @RequestMapping("/lightToRight.do")
    public String lightToRight2(){
        return "rozerStone/floor2/Part_2_R";
    }
    @RequestMapping("/lightToCenter.do")
    public String lightToCenter2(){
        return "rozerStone/floor2/Part_2_C";
    }
    @RequestMapping("/lightToLeft.do")
    public String lightToLeft2(){
        return "rozerStone/floor2/Part_2_L";
    }

//    아이언메이든 오픈
    @RequestMapping("/lightOpenMaiden.do")
    public String lightOpenMaiden2(){
        return "rozerStone/floor2/Part_2_R_openmaiden";
    }

//    체스화면
    @RequestMapping("/lightChess.do")
    public String lightChess(){
        return "rozerStone/floor2/Part_2_chess";
    }

//**************************   블라인드 화면    **************************
    @RequestMapping("/blindCenter.do")
    public String blindCenter2(){
        return "rozerStone/floor2/Part_2_Cd";
    }
    @RequestMapping("/blindLeft.do")
    public String blindLeft2(){
        return "rozerStone/floor2/Part_2_Ld";
    }
    
//**************************    언록화면    **************************
    @RequestMapping("/toLeftUNLOCK0.do")
    public String toLeftUnlock0(){
        return "rozerStone/floor2/Part_2_L_UNLOCK_0";
    }

    @RequestMapping("/toLeftUNLOCK.do")
    public String toLeftUnlock(){
        return "rozerStone/floor2/Part_2_L_UNLOCK";
    }

    @RequestMapping("/toCenterUNLOCK.do")
    public String unlockCenter2(){
        return "rozerStone/floor2/Part_2_C_UNLOCK";
    }




    @RequestMapping("/lightToBack.do")
    public String lightToBack2(){
        return "rozerStone/floor2/Part_2_B";
    }

//    감옥엔딩
    @RequestMapping("/lightToJail.do")
    public String lightToJail2(){
        return "rozerStone/floor2/Part_2_B_L_jail_ending";
    }
    @RequestMapping("/lightToJail2.do")
    public String lightToJail22(){
        return "rozerStone/floor2/Part_2_B_L_jail_ending_2";
    }

}
