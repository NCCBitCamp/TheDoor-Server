package com.bit.springboard.dto;

import java.time.LocalDateTime;

public class RankDto {
    private int rank_id; // 기록 아이디
    private int WRITER_ID; // 회원 아이디
    private LocalDateTime playdate; // 기록 날짜
    private int playtime; // 기록 시간
    private String game_type; // 기록 게임
    private String comment; // 한마디

//****************************************************** + 인게임 랭크
    private String username; // 닉네임
}
