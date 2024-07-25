package com.bit.springboard.dao;

import com.bit.springboard.dto.RankDto;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public class RankDao {
    private SqlSessionTemplate mybatis;

    @Autowired
    public RankDao(SqlSessionTemplate sqlSessionTemplate) {
        this.mybatis = sqlSessionTemplate;
    }

    public void insertRank(RankDto rankDto) {
        mybatis.insert("RankDao.insertRanking", rankDto);
    }
}