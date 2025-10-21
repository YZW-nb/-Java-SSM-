package com.java.mapper;


import com.java.pojo.Club;
import com.java.pojo.ClubApply;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ClubMapper {
    // 根据id查询社团
    Club selectClubById(Integer id);

    // 查询所有状态为"正常"的社团（可申请的社团）(新增）



    // 查询所有社团
    List<Club> selectAllClubs();

    // 插入社团
    void insertClub(Club club);

    // 更新社团
    void updateClub(Club club);

    // 删除社团
    void deleteClub(Integer id);

    // 根据创始人id查询社团
    List<Club> selectClubsByFounderId(Integer founderId);

    // 根据状态查询社团
    List<Club> selectClubsByStatus(Integer status);
    // 新增：查询所有正常状态的社团（供申请页面使用）
//    @Select("SELECT id, name, category, intro, founder_id AS founderId FROM club WHERE status = 1")
    List<Club> selectAllNormalClubs();

    // 根据名称查询社团
    Club selectClubByName(String name);

}