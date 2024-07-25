package com.bit.springboard.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/bitCamp")
public class BitController {
    @RequestMapping("502Room.do")
    public String bit502roomView() {
        return "/bitCamp/502Room";
    }

    @RequestMapping("floor5.do")
    public String floor5View() {
        return "/bitCamp/floor5";
    }

    @RequestMapping("floor7.do")
    public String floor7View() {
        return "/bitCamp/floor7";
    }

    @RequestMapping("floor2.do")
    public String floor2View() {
        return "/bitCamp/floor2";
    }

    @RequestMapping("201Room.do")
    public String bit201roomView() {
        return "/bitCamp/201Room";
    }

    @RequestMapping("game.do")
    public String gameView() {
        return "/bitCamp/game";
    }

    @RequestMapping("floor1.do")
    public String floor1View() {
        return "/bitCamp/floor1";
    }

    @RequestMapping("101Room.do")
    public String bit101roomView() {
        return "/bitCamp/101Room";
    }

    @RequestMapping("cable_game.do")
    public String cablegameView() {
        return "/bitCamp/cable_game";
    }

    @RequestMapping("floor5_endT.do")
    public String floor5endTView() {
        return "/bitCamp/floor5_endT";
    }

    @RequestMapping("floor5_endN.do")
    public String floor5endNView() {
        return "/bitCamp/floor5_endN";
    }
}
