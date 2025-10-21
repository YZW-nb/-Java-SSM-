package com.java.service;

import com.java.pojo.ActivitySignup;
import java.util.List;

// 活动报名服务接口
public interface ActivitySignupService {

    // 用户报名活动
    boolean signup(int userId, int activityId);

    // 取消报名
    boolean deleteSignup(Integer id);

    // 修改报名备注
    boolean updateRemark(ActivitySignup signup);

    // 获取单个报名记录
    ActivitySignup getSignup(Integer id);

    // 获取用户的所有报名
    List<ActivitySignup> getByUserId(Integer userId);

    // 获取活动的所有报名
    List<ActivitySignup> getByActivityId(Integer activityId);

    // 检查是否已报名
    boolean isSignedUp(Integer userId, Integer activityId);

    // 添加报名记录
    boolean addSignup(ActivitySignup signup);

    // 获取全部报名记录（管理员用）
    List<ActivitySignup> getAllSignups();

    // 更新报名信息（管理员用）
    boolean updateSignup(ActivitySignup signup);
}