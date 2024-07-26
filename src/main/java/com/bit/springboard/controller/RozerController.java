package com.bit.springboard.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RozerController {



//**********************************************  1층  *********************************************************

    // Nar_1 <- 이런 식으로 지정해주셔야....됩니다
    @RequestMapping("/floor1/Nar_1.do")
    public String Nar_1(){
        return "/rozerStone/floor1/Nar_1";
    }

    // Nar_1 -> Nar_2

    @RequestMapping("/Nar_1.do")
    public String nar1ToNar2(){
        return "/rozerStone/floor1/Nar_2";
    }

    // Nar_2 -> Part_1_1_2

    @RequestMapping("/nar2ToPart112.do")
    public String nar2ToPart112(){
        return "/rozerStone/floor1/Part_1_1_2";
    }

    // Part_1_1_2 -> Part_1_3

    @RequestMapping("/part112ToPart13.do")
    public String part112ToPart13(){
        return "/rozerStone/floor1/Part_1_3";
    }

    // Part_1_3 -> Part_1_4

    @RequestMapping("/part13ToPart14.do")
    public String part13ToPart14(){
        return "/rozerStone/floor1/Part_1_4";
    }

    // Part_1_4 -> Part_1_5

    @RequestMapping("/part14ToPart15.do")
    public String part14ToPart15(){
        return "/rozerStone/floor1/Part_1_5";
    }

    // Part_1_5 -> Part_1_6

    @RequestMapping("/part15ToPart16.do")
    public String part15ToPart16(){
        return "/rozerStone/floor1/Part_1_6";
    }

    // Part_1_6 -> Part_1_7

    @RequestMapping("/part16ToPart17.do")
    public String part16ToPart17(){
        return "/rozerStone/floor1/Part_1_7";
    }

    // Part_1_7 -> Part_1_C

    @RequestMapping("/part17ToPart1C.do")
    public String part17ToPart1C(){
        return "/rozerStone/floor1/Part_1_C";
    }



    // Part_1_C <-> Part_1_L <-> Part_1_R

    @RequestMapping("/part1CToPart1L.do")
    public String part1CToPart1L(){
        return "/rozerStone/floor1/Part_1_L";
    }

    @RequestMapping("/part1CToPart1R.do")
    public String part1CToPart1R(){
        return "/rozerStone/floor1/Part_1_R";
    }

    @RequestMapping("/part1LToPart1C.do")
    public String part1LToPart1C(){
        return "/rozerStone/floor1/Part_1_C";
    }

    @RequestMapping("/part1RToPart1C.do")
    public String part1RToPart1C(){
        return "/rozerStone/floor1/Part_1_C";
    }

    // Part_1_R ->  Part_2-Script1

    @RequestMapping("/part1RToPart2S1.do")
    public String part1RToPart2S(){
        return "/rozerStone/floor2/Part_2-Script1";
    }


//********************공통부분 (인벤?) / 죽는 화면으로 넘어가는 거?***************************

    //          -> DeadDark1,2

    @RequestMapping("/ToDD.do")
    public String ToDD(){
        return "/rozerStone/integ/Dead_In_Dark";
    }

    @RequestMapping("/ToDD2.do")
    public String ToDD2(){
        return "/rozerStone/integ/Dead_In_Dark2";
    }


    //          -> Dead_stampede

    @RequestMapping("/ToDS.do")
    public String ToDS(){
        return "/rozerStone/integ/Dead_stampede";
    }

    //          -> Dead_In_bones

    @RequestMapping("/ToDB.do")
    public String ToDB(){
        return "/rozerStone/integ/Dead_In_bones";
    }

    @RequestMapping("/ToDII.do")
    public String ToDII(){
        return "/rozerStone/integ/Dead_In_Insect";
    }


    // 인벤토리로 가는~

    @RequestMapping("/inventory.do")
    public String inventory(){
        return "/rozerStone/integ/Inventory_temp";
    }


//**********************************************  2층  *********************************************************

    // 2_Cd 부터 시작 : Ld<-->Rd
    @RequestMapping("/darkToLeft.do")
    public String darkToLeft(){
        return "/rozerStone/floor2/Part_2_Ld";
    }

    @RequestMapping("/darkToCenter.do")
    public String darkToCenter(){
        return "/rozerStone/floor2/Part_2_Cd";
    }

    @RequestMapping("/darkToRight.do")
    public String darkToRight(){
        return "/rozerStone/floor2/Part_2_Rd";
    }

    @RequestMapping("/darkToScript2.do")
    public String darkToScript2(){
        return "/rozerStone/floor2/Part_2-Script2";
    }

//    Rd -> R 넘어가기 / <- 까지 매핑포스트로 바꾸기
//**************************    다크 ->> 라이트    **************************

    @RequestMapping("/lightToRight.do")
    public String lightToRight2(){
        return "/rozerStone/floor2/Part_2_R";
    }
    @RequestMapping("/lightToCenter.do")
    public String lightToCenter2(){
        return "/rozerStone/floor2/Part_2_C";
    }
    @RequestMapping("/lightToLeft.do")
    public String lightToLeft2(){
        return "/rozerStone/floor2/Part_2_L";
    }

//    아이언메이든 오픈
    @RequestMapping("/lightOpenMaiden.do")
    public String lightOpenMaiden2(){
        return "/rozerStone/floor2/Part_2_R_openmaiden";
    }

//    체스화면
    @RequestMapping("/lightChess.do")
    public String lightChess(){
        return "/rozerStone/floor2/chess";
    }

//**************************   블라인드 화면    **************************
    @RequestMapping("/blindCenter.do")
    public String blindCenter2(){
        return "/rozerStone/floor2/Part_2_Cd";
    }
    @RequestMapping("/blindLeft.do")
    public String blindLeft2(){
        return "/rozerStone/floor2/Part_2_Ld";
    }
    @RequestMapping("/blindP3Pre.do")
    public String blindP3Pre(){
        return "/rozerStone/floor2/Part_3_Pre";
    }
    
//**************************    언록화면    **************************
    @RequestMapping("/toLeftUNLOCK0.do")
    public String toLeftUnlock0(){
        return "/rozerStone/floor2/Part_2_L_UNLOCK_0";
    }

    @RequestMapping("/toLeftUNLOCK.do")
    public String toLeftUnlock(){
        return "/rozerStone/floor2/Part_2_L_UNLOCK";
    }

    @RequestMapping("/toCenterUNLOCK.do")
    public String unlockCenter2(){
        return "/rozerStone/floor2/Part_2_C_UNLOCK";
    }




    @RequestMapping("/lightToBack.do")
    public String lightToBack2(){
        return "/rozerStone/floor2/Part_2_B";
    }

//    감옥엔딩
    @RequestMapping("/lightToJail.do")
    public String lightToJail2(){
        return "/rozerStone/floor2/Part_2_B_L_jail_ending";
    }
    @RequestMapping("/lightToJail2.do")
    public String lightToJail22(){
        return "/rozerStone/floor2/Part_2_B_L_jail_ending_2";
    }

}
