package com.bit.springboard.dao;

import com.bit.springboard.dto.MemberDto;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDao {
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    public MemberDto login(MemberDto memberDto) {
        MemberDto result = sqlSessionTemplate.selectOne("MemberDao.login", memberDto);

        return result;
    }

    // 사용자 이름 존재 여부 확인 메서드
    public boolean usernameCheck(String username) {
        Integer count = sqlSessionTemplate.selectOne("MemberDao.usernameCheck", username);
        return count != null && count > 0;
    }
}
