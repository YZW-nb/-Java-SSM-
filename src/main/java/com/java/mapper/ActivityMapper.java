package com.java.mapper;

import com.java.pojo.Activity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 活动数据访问接口
 */
@Mapper
public interface ActivityMapper {
   Integer insertActivity(Activity activity);                   // 插入活动数据，返回影响行数。

    Activity selectById(Integer id);                            //根据活动 ID 查询活动对象。

    int updateTimeAndLocation(Map<String, Object> params);      //更新活动时间和地点，返回影响行数。

    int updateStatus(Map<String, Object> params);               //更新活动状态，返回影响行数。

    List<Activity> selectByCondition(Map<String, Object> params);//根据条件查询活动列表 。

    Integer getClubIdByActivityId(Integer activityId);           //检查该用户是否为该社团的管理员

    List<Integer> getManagedActivityIds(Integer userId);         //获取用户管理的活动ID列表

 Activity getActivityByTitle(String title);                      // 根据活动标题查询活动信息

 int updateById(Activity activity);                              // 更新方法
}