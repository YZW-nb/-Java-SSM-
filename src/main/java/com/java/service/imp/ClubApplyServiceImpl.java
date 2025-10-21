package com.java.service.imp;


import com.java.mapper.ClubApplyMapper;
import com.java.mapper.ClubMapper;
import com.java.mapper.ClubMemberMapper;
import com.java.pojo.Club;
import com.java.pojo.ClubApply;
import com.java.pojo.ClubMember;
import com.java.service.ClubApplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
@Transactional
public class ClubApplyServiceImpl implements ClubApplyService {
    @Autowired
    private ClubApplyMapper clubApplyMapper;

    @Autowired
    private ClubMapper clubMapper;//社团状态

    @Autowired
    private ClubMemberMapper clubMemberMapper;//加入社团

    @Override
    public void submitApply(Integer clubId, Integer userId, String reason) {
        // 1. 检查社团是否存在且正常运行
        Club club = clubMapper.selectClubById(clubId);
        if (club == null || club.getStatus() != 1) {
            throw new RuntimeException("社团不存在或已解散,无法申请了哦!");
        }
        // 2. 检查是否已申请过
        if (clubApplyMapper.checkExist(clubId, userId) > 0) {
            throw new RuntimeException("您已经申请了该社团，不要重复申请!");
        }
        // 3. 检查是否已加入社团
        if (clubMemberMapper.checkMember(clubId, userId) > 0) {
            throw new RuntimeException("您已经加入该社团，无需申请");
        }
        // 4. 创建申请对象并设置必填字段
        ClubApply apply = new ClubApply();
        apply.setClubId(clubId);   // 设置社团ID
        apply.setUserId(userId);   // 设置用户ID
        apply.setReason(reason);   // 设置申请理由
        apply.setStatus("pending");// 必须设置状态为 pending

        // 5. 执行插入（数据库会自动填充 applyTime）
        clubApplyMapper.insertApply(apply);

        // 6. 插入后，实体类会自动获取数据库生成的 applyTime（需 MyBatis 配置 useGeneratedKeys）
        System.out.println("自动生成的申请时间：" + apply.getApplyTime());
    }


    //提交完，是不是管理员该操作审核了！！
    @Override
    public void reviewApply(Integer applyId,String status,Integer adminId) {
        //1申请存不存在
        ClubApply apply = clubApplyMapper.selectById(applyId);
        if (apply == null) {
            throw new RuntimeException("申请记录不存在");
        }
        //2审核是不是管理员
        Club club = clubMapper.selectClubById(apply.getClubId());
        if (!club.getFounderId().equals(adminId)) {
            throw new RuntimeException("无权限审核，仅社团管理员才能操作");
        }
        //3检查申请状态是否为待审核
        if (!"pending".equals(apply.getStatus())) {
            throw new RuntimeException("该申请已经审核，无需重复审核");
        }
        //4执行审核
        clubApplyMapper.updateApplyStatus(applyId, status, new Date());
        //5审核通过，加入社团 club_member
        if ("approved".equals(status)) {
            ClubMember member = new ClubMember(apply.getClubId(), apply.getUserId());
            clubMemberMapper.addMember(member);
        }
    }

    //管理员查看待审核申请
        @Override
        public List<ClubApply> getPendingApplies(Integer clubId){
            return clubApplyMapper.selectPendingByClubId(clubId);
        }

    //用户查询我的申请记录
        @Override
        public List<ClubApply> getMyApplies(Integer userId){
            return clubApplyMapper.selectByUserId(userId);
        }

    @Override
    public int getPendingApplyCount(Integer clubId) {
        return clubApplyMapper.countPendingByClubId(clubId);
    }

    @Override
    public List<ClubApply> getAppliesByClubId(Integer clubId) {
        return clubApplyMapper.selectByClubId(clubId);
    }


    @Override
    @Transactional
    public void reviewStatus(Integer applyId, String status) {
        // 查询申请
        ClubApply apply = clubApplyMapper.selectById(applyId);
        if (apply != null) {
            // 更新状态
            apply.setStatus(status);
            apply.setReviewTime(new Date()); // 记录更新时间
            clubApplyMapper.reviewById(apply);
        }
    }
}



