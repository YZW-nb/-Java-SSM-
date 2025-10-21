package com.java.service.imp;

import com.java.mapper.ActivityMapper;
import com.java.mapper.UserMapper;
import com.java.pojo.Activity;
import com.java.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 活动业务实现
 */
@Service
public class ActivityServiceImpl implements ActivityService {
    @Autowired
    private  ActivityMapper activityMapper;
    @Autowired
    private UserMapper userMapper;
    // 构造方法，传入活动Mapper
    public ActivityServiceImpl(ActivityMapper activityMapper) {
        this.activityMapper = activityMapper;
    }

    // 创建活动，返回活动ID
    @Override
    public Integer createActivity(Activity activity) {
        activity.setStatus(1); // 1表示正常状态
        activityMapper.insertActivity(activity);
        return activity.getId();
    }

    // 检查用户是否可以报名活动
    @Override
    public boolean signup(Integer activityId, Integer userId) {
        Activity activity = activityMapper.selectById(activityId);
        return activity != null && activity.getStatus() == 1;
    }

    // 修改活动时间和地点
    @Override
    public boolean adjustTimeAndLocation(Integer activityId, LocalDateTime newTime, String newLocation) {
        Map<String, Object> params = new HashMap<>();
        params.put("id", activityId);
        params.put("newStartTime", newTime);
        params.put("newLocation", newLocation);
        return activityMapper.updateTimeAndLocation(params) > 0;
    }

    // 取消活动
    @Override
    public boolean cancelActivity(Integer activityId, String reason) {
        Map<String, Object> params = new HashMap<>();
        params.put("id", activityId);
        params.put("status", 0); // 0表示已取消
        return activityMapper.updateStatus(params) > 0;
    }

    // 获取活动列表
    @Override
    public List<Activity> getActivities(Integer clubId, int timeType) {
        Map<String, Object> params = new HashMap<>();
        params.put("clubId", clubId);
        params.put("status", 1); // 只查正常活动
        params.put("timeType", timeType);
        return activityMapper.selectByCondition(params);
    }

    // 获取活动报名人数（待实现）
    @Override
    public int countSignup(Integer activityId) {
        return 0; // 需要完善
    }

    // 根据ID获取单个活动
    @Override
    public Activity getActivityById(Integer id) {
        return activityMapper.selectById(id);
    }
    /**
     * 检查用户是否为活动管理员（简化版）
     * @param userId 用户ID
     * @param activityId 活动ID
     * @return true-是管理员，false-不是管理员
     */
    @Override
    public boolean checkAdmin(Integer userId, Integer activityId) {
        // 假设：社团管理员可以管理其社团下的所有活动
        // 通过活动ID查询所属社团ID
        Integer clubId = activityMapper.getClubIdByActivityId(activityId);

        // 查询该用户是否为该社团的管理员（角色ID=2表示管理员）
        Integer count = userMapper.countUserRoleInClub(userId, clubId, 2);

        return count != null && count > 0;
    }

    // 根据标题查询活动
    @Override
    public Activity getActivityByTitle(String title) {
        return activityMapper.getActivityByTitle(title);
    }

    // 更新活动信息
    @Override
    public void updateActivity(Activity activity) {
        activityMapper.updateById(activity); // 直接执行更新操作
    }

}