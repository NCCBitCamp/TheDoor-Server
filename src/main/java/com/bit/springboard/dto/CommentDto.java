package com.bit.springboard.dto;

import java.time.LocalDateTime;

public class CommentDto {
    private int comment_id; // 댓글 아이디
    private int board_id; // 게시판 아이디
    private int WRITER_ID; // 회원 아이디
    private LocalDateTime date; // 작성 시간
    private String comment; // 댓글 내용

    public int getComment_id() {
        return comment_id;
    }

    public void setComment_id(int comment_id) {
        this.comment_id = comment_id;
    }

    public int getBoard_id() {
        return board_id;
    }

    public void setBoard_id(int board_id) {
        this.board_id = board_id;
    }

    public int getWRITER_ID() {
        return WRITER_ID;
    }

    public void setWRITER_ID(int WRITER_ID) {
        this.WRITER_ID = WRITER_ID;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
}
