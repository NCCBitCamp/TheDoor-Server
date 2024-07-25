package com.bit.springboard.dto;

import java.time.LocalDateTime;

public class RankDto {
    private String rank_id; // 기록 아이디
    private LocalDateTime playdate; // 기록 날짜
    private int playtime; // 기록 시간
    private String gametype; // 기록 게임
    private String comment; // 한마디

    public String getRank_id() {
        return rank_id;
    }

    public void setRank_id(String rank_id) {
        this.rank_id = rank_id;
    }

    public LocalDateTime getPlaydate() {
        return playdate;
    }

    public void setPlaydate(LocalDateTime playdate) {
        this.playdate = playdate;
    }

    public int getPlaytime() {
        return playtime;
    }

    public void setPlaytime(int playtime) {
        this.playtime = playtime;
    }

    public String getGametype() {
        return gametype;
    }

    public void setGametype(String gametype) {
        this.gametype = gametype;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }


    @Override
    public String toString() {
        return "RankDto{" +
                "rank_id=" + rank_id +
                ", playdate=" + playdate +
                ", playtime=" + playtime +
                ", game_type='" + gametype + '\'' +
                ", comment='" + comment + '\'' +
                '}';
    }
}
