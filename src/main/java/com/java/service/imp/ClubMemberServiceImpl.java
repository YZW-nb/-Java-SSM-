package com.java.service.imp;

import com.java.mapper.ClubMemberMapper;
import com.java.pojo.Club;
import com.java.pojo.ClubMember;
import com.java.service.ClubMemberService;
import com.java.service.ClubService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

/**
 * 社团成员服务实现类
 * 处理用户加入、退出社团，以及社团成员相关的查询操作
 */
@Service
@Transactional
public class ClubMemberServiceImpl implements ClubMemberService {

    @Autowired
    private ClubMemberMapper clubMemberMapper;

    @Autowired
    private ClubService clubService;  // 用于验证社团状态是否正常

    /**
     * 用户加入社团
     * 先检查社团是否存在且状态正常（状态值1表示正常），
     * 再检查用户是否已加入该社团，都通过后添加成员记录
     */
    @Override
    public void joinClub(Integer clubId, Integer userId) {
        // 验证社团状态：不存在或已解散（非1状态）则抛出异常
        Club club = clubService.getClubById(clubId);
        if (club == null || club.getStatus() != 1) {
            throw new RuntimeException("社团不存在或已解散");
        }

        // 检查用户是否已加入，已加入则抛出异常
        if (isMember(clubId, userId)) {
            throw new RuntimeException("您已加入该社团");
        }

        // 创建成员记录并添加到社团
        ClubMember member = new ClubMember();
        member.setClubId(clubId);
        member.setUserId(userId);
        clubMemberMapper.addMember(member);
    }

    /**
     * 用户退出社团
     * 先检查用户是否为该社团成员，不是则抛出异常，是则删除成员记录
     */
    @Override
    public void exitClub(Integer clubId, Integer userId) {
        // 非社团成员无法退出，抛出异常
        if (!isMember(clubId, userId)) {
            throw new RuntimeException("您不是该社团成员");
        }

        // 执行退出操作，删除成员记录
        clubMemberMapper.deleteMember(clubId, userId);
    }

    /**
     * 获取指定社团的所有成员ID
     * 返回该社团下所有用户的ID列表，无成员时返回空列表
     */
    @Override
    public List<Integer> getClubMembers(Integer clubId) {
        return clubMemberMapper.selectUserIdsByClubId(clubId);
    }

    /**
     * 获取指定用户加入的所有社团ID
     * 返回该用户加入的所有社团ID列表，未加入任何社团时返回空列表
     */
    @Override
    public List<Integer> getUserClubs(Integer userId) {
        return clubMemberMapper.selectClubIdsByUserId(userId);
    }

    /**
     * 检查用户是否为指定社团的成员
     * 通过查询成员记录的数量判断，大于0则表示是成员
     */
    @Override
    public boolean isMember(Integer clubId, Integer userId) {
        return clubMemberMapper.checkMember(clubId, userId) > 0;
    }

    /**
     * 获取指定社团的成员总数
     * 返回该社团当前的成员数量，无成员时返回0
     */
    @Override
    public int getMemberCount(Integer clubId) {
        return clubMemberMapper.countMembersByClubId(clubId);
    }
}