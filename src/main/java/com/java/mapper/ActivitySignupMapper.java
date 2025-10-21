package com.java.mapper;

import com.java.pojo.ActivitySignup;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ActivitySignupMapper {
    // 新增报名
    // 报名方法
    int signup(@Param("userId") int userId, @Param("activityId") int activityId);

    // 删除报名
    int deleteById(Integer id);

    // 修改备注
    int updateRemark(ActivitySignup signup);

    // 查询单个报名
    ActivitySignup selectById(Integer id);

    // 查询用户所有报名
    List<ActivitySignup> selectByUserId(Integer userId);

    // 查询活动所有报名
    List<ActivitySignup> selectByActivityId(Integer activityId);

    // 检查是否已报名
    ActivitySignup checkSignup(Integer userId, Integer activityId);

//    新增报名记录
    @Insert("INSERT INTO activity_signup (user_id, activity_id, remark) VALUES (#{userId}, #{activityId}, #{remark})")
    @Options(useGeneratedKeys = true, keyProperty = "id")  //生成自增主键赋给id值
    int addSignup(ActivitySignup signup);

//    查询所有报名记录
    List<ActivitySignup> selectAllSignups();
//    更新报名记录
    int updateSignup(ActivitySignup signup);
}