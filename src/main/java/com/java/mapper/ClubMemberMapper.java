package com.java.mapper;

import com.java.pojo.Club;
import com.java.pojo.ClubMember;
import com.java.pojo.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

// ClubMemberMapper.java
@Mapper
public interface ClubMemberMapper {
    // 检查用户是否已加入社团
    int checkMember(@Param("clubId") Integer clubId, @Param("userId") Integer userId);

    // 加入社团
    void addMember(ClubMember member);

    // 退出社团
    void deleteMember(@Param("clubId") Integer clubId, @Param("userId") Integer userId);

    // 获取社团的所有成员ID
    List<Integer> selectUserIdsByClubId(Integer clubId);

    // 获取用户加入的所有社团ID
    List<Integer> selectClubIdsByUserId(Integer userId);

    // 获取社团成员数量
    int countMembersByClubId(Integer clubId);
}


