package com.java.service;

import java.util.List;

// ClubMemberService.java
public interface ClubMemberService {
    // 用户加入社团
    void joinClub(Integer clubId, Integer userId);

    // 用户退出社团
    void exitClub(Integer clubId, Integer userId);

    // 获取社团的所有成员ID
    List<Integer> getClubMembers(Integer clubId);

    // 获取用户加入的所有社团ID
    List<Integer> getUserClubs(Integer userId);

    // 检查用户是否是社团成员
    boolean isMember(Integer clubId, Integer userId);

    // 获取社团成员数量
    int getMemberCount(Integer clubId);
}