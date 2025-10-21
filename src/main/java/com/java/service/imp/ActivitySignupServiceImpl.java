package com.java.service.imp;

import com.java.mapper.ActivitySignupMapper;
import com.java.pojo.ActivitySignup;
import com.java.service.ActivitySignupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 活动报名服务实现类
 * 负责处理活动报名相关的业务逻辑
 */
@Service
public class ActivitySignupServiceImpl implements ActivitySignupService {
    @Autowired
    private ActivitySignupMapper signupMapper;
    @Autowired
    private  ActivitySignupMapper mapper;
    @Autowired
    private ActivitySignupMapper activitySignupMapper;

    // 构造函数注入活动报名数据访问层
    public ActivitySignupServiceImpl(ActivitySignupMapper mapper) {
        this.mapper = mapper;
    }
    // 用户报名活动
    @Override
    public boolean signup(int userId, int activityId) {
        // 调用Mapper执行报名操作
        int result = signupMapper.signup(userId, activityId);
        // 返回操作是否成功(影响行数>0)
        return result > 0;
    }

    // 根据ID删除活动报名记录
    // 返回删除操作是否成功
    @Override
    public boolean deleteSignup(Integer id) {
        return mapper.deleteById(id) > 0;
    }

    // 更新报名备注信息
    // 返回更新操作是否成功
    @Override
    public boolean updateRemark(ActivitySignup signup) {
        return mapper.updateRemark(signup) > 0;
    }

    // 根据ID获取报名记录
    // 若记录不存在则返回null
    @Override
    public ActivitySignup getSignup(Integer id) {
        return mapper.selectById(id);
    }

    // 获取指定用户的所有报名记录
    // 若无记录则返回空列表
    @Override
    public List<ActivitySignup> getByUserId(Integer userId) {
        return mapper.selectByUserId(userId);
    }

    // 获取指定活动的所有报名记录
    // 若无记录则返回空列表
    @Override
    public List<ActivitySignup> getByActivityId(Integer activityId) {
        return mapper.selectByActivityId(activityId);
    }

    // 检查用户是否已报名指定活动
    // 已报名返回true，未报名返回false
    @Override
    public boolean isSignedUp(Integer userId, Integer activityId) {
        return mapper.checkSignup(userId, activityId) != null;
    }

    // 添加报名记录，返回是否成功
    @Override
    public boolean addSignup(ActivitySignup signup) {
        int result = activitySignupMapper.addSignup(signup);
        return result > 0;
    }

    // 获取所有报名记录
    @Override
    public List<ActivitySignup> getAllSignups() {
        return mapper.selectAllSignups();
    }

    // 更新报名信息，返回是否成功
    @Override
    public boolean updateSignup(ActivitySignup signup) {
        return mapper.updateSignup(signup) > 0;
    }
}