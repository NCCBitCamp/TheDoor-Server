package com.bit.springboard.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/theHostel")
public class TheHostelController {

    @RequestMapping("/the-hostel.do")
    public String theHostelView() {
        return "theHostel/01_the_hostel";
    }

    @RequestMapping("/the-bar.do")
    public String theBarView() {
        return "theHostel/02_the_bar";
    }

    @RequestMapping("/right-wall.do")
    public String rightWallView() {
        return "theHostel/03_right_wall";
    }

    @RequestMapping("/stage.do")
    public String stageView() {
        return "theHostel/04_stage";
    }

    @RequestMapping("/left-wall.do")
    public String leftWallView() {
        return "theHostel/05_left_wall";
    }

    @RequestMapping("/inventory.do")
    public String inventoryView() {
        return "theHostel/inventory";
    }

    @RequestMapping("/ending.do")
    public String endingView() {
        return "theHostel/Ending";
    }



}
