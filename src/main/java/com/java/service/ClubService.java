package com.java.service;

import com.java.pojo.Club;

import java.util.List;

public interface ClubService {
    //查询单个社团
    Club getClubById(Integer id);
    //查询所有社团
    List<Club> getAllClubs();
    //添加社团
    void addClub(Club club);



    //编辑社团
    void editClub(Club club);
    //删除社团
    void removeClub(Integer id);
    //创始人社团id查询
    List<Club> getMyClubs(Integer founderId);
    //查询正常状态的社团
    List<Club> getNormalClubs();

    Club getClubByName(String name); // 新增方法


}
