package com.java.service;

import com.java.pojo.Activity;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 活动业务接口
 */
public interface ActivityService {
    //创建活动
    Integer createActivity(Activity activity);

    //申请活动
    boolean signup(Integer activityId, Integer userId);
    //调整活动日期
    boolean adjustTimeAndLocation(Integer activityId, LocalDateTime newTime, String newLocation);
    //取消1活动
    boolean cancelActivity(Integer activityId, String reason);
    // 获取活动列表
    List<Activity> getActivities(Integer clubId, int timeType);
    //申请数量
    int countSignup(Integer activityId);
    //获取活动id
    Activity getActivityById(Integer id);
    // 新增：检查用户是否为活动管理员
    boolean checkAdmin(Integer userId, Integer activityId);
    // 新增根据标题获取活动的方法
    Activity getActivityByTitle(String title);
    // 新增编辑（更新）方法
    void updateActivity(Activity activity);

}