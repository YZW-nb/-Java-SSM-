package com.java.service.imp;

import com.java.mapper.ClubMapper;
import com.java.pojo.Club;
import com.java.pojo.ClubApply;
import com.java.service.ClubService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class ClubServiceImpl implements ClubService {
    //注入Mapper接口
    @Autowired
    private ClubMapper clubMapper;

    @Override
    public Club getClubById(Integer id) {
        return clubMapper.selectClubById(id);
    }

    @Override
    public List<Club> getAllClubs() {
        return clubMapper.selectAllClubs();
    }

    @Override
    public void addClub(Club club) {
        //新增社团默认状态为"1"
        club.setStatus(1);
        clubMapper.insertClub(club);
    }



    @Override
    public void editClub(Club club) {
        clubMapper.updateClub(club);
    }


    @Override
    public void removeClub(Integer id) {
        clubMapper.deleteClub(id);
    }

    @Override
    public List<Club> getMyClubs(Integer founderId) {
        return clubMapper.selectClubsByFounderId(founderId);
    }

    @Override
    public List<Club> getNormalClubs(){
        return clubMapper.selectClubsByStatus(1);
    }

    @Override
    public Club getClubByName(String name) {
        return clubMapper.selectClubByName(name);
    }

}
