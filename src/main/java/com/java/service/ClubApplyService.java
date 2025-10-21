package com.java.service;

import com.java.pojo.ClubApply;

import java.util.List;

public interface ClubApplyService {
    //提交加入社团申请
    void submitApply(Integer clubId, Integer userId, String reason);

    //审核申请 -ture - false
    void reviewApply(Integer applyId, String status, Integer adminId);

    //管理员查询待审核申请
    List<ClubApply> getPendingApplies(Integer clubId);

    //用户查询我的申请记录
    List<ClubApply> getMyApplies(Integer clubId);
    /**
     * 获取指定社团的待审核申请数量
     * @param clubId 社团ID
     * @return 待审核申请数量
     */
    int getPendingApplyCount(Integer clubId);

    // 获取社团的所有申请
    List<ClubApply> getAppliesByClubId(Integer clubId);

    /**
     * 更新申请状态
     * @param applyId 申请ID
     * @param status 目标状态（approved/rejected）
     */
    void reviewStatus(Integer applyId, String status);

}
