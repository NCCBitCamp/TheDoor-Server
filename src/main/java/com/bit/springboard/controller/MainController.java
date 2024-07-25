package com.bit.springboard.controller;

import com.bit.springboard.dto.RankDto;
import com.bit.springboard.service.RankService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/main")
public class MainController {
    @Autowired
    private RankService rankService;

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

    @PostMapping("/ranking")
    @ResponseBody
    public String ranking(RankDto rankDto) {
        System.out.println(rankDto);
        rankService.insertRank(rankDto);
        return "success";
    }
}
