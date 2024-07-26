package com.bit.springboard.service;

import com.bit.springboard.dto.MemberDto;

public interface MemberService {
    MemberDto login(MemberDto memberDto);
    String usernameCheck(String username);
}
