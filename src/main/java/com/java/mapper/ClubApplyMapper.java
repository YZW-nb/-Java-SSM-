package com.java.mapper;


import com.java.pojo.Club;
import com.java.pojo.ClubApply;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.Date;
import java.util.List;

@Mapper
public interface ClubApplyMapper {
    //提交申请
    void insertApply(ClubApply clubApply);

    //审核申请a更新状态和审核时间
    void updateApplyStatus(@Param("id") Integer id, @Param("status") String status, @Param("reviewTime") Date reviewTime);

    //根据申请ID查询
    ClubApply selectById(Integer id);

    //根据社团ID查询待审核申请
    List<ClubApply> selectPendingByClubId(Integer clubId);

    //根据用户ID查询我的申请记录
    List<ClubApply> selectByUserId(Integer userId);

    //检查是否已经申请
    int checkExist(@Param("clubId") Integer clubId,@Param("userId") Integer userId);

    /**
     * 统计指定社团的待审核申请数量
     * @param clubId 社团ID
     * @return 待审核申请数量
     */
    int countPendingByClubId(Integer clubId);


    // 查询社团的所有申请
    List<ClubApply> selectByClubId(Integer clubId);



    // 更新申请
    int reviewById(ClubApply apply);
}
