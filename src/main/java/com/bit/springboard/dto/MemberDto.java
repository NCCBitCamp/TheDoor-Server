package com.bit.springboard.dto;

public class MemberDto {
    private int id;
    private String user_id;
    private String password;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "MemberDto{" +
                "id=" + id +
                ", user_id='" + user_id + '\'' +
                ", password='" + password + '\'' +
                '}';
    }
}
