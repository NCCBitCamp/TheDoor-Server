package com.bit.springboard.service;

import com.bit.springboard.dao.RankDao;
import com.bit.springboard.dto.RankDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RankService {
    private RankDao rankDao;

    @Autowired
    public RankService(RankDao rankDao) {
        this.rankDao = rankDao;
    }

    public void insertRank(RankDto rankDto) {
        rankDao.insertRank(rankDto);
    }
}
