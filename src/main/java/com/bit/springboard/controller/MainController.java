package com.bit.springboard.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/main")
public class MainController {
    @RequestMapping("502Door.do")
    public String bitView() {
        return "/main/502Door";
    }

    @RequestMapping("hostelDoor.do")
    public String hostelView() {
        return "/main/hostelDoor";
    }

    @RequestMapping("rogerDoor.do")
    public String rozerView() {
        return "/main/rogerDoor";
    }
}
