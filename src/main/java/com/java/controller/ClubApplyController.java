package com.java.controller;

import com.java.mapper.ClubApplyMapper;
import com.java.mapper.ClubMapper;
import com.java.pojo.Club;
import com.java.pojo.ClubApply;
import com.java.service.ClubApplyService;
import com.java.service.ClubService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/club/apply")
public class ClubApplyController {
    @Autowired
    private ClubApplyService clubApplyService;
    @Autowired
    private ClubApplyMapper clubApplyMapper;
    @Autowired
    private ClubMapper clubMapper;
    @Autowired
    private ClubService clubService;
@Autowired
private ClubApplyService applyService;
    // 1. 跳转到申请页面（显示所有可申请的社团，支持直接访问或带社团ID访问）
    @GetMapping({"/toApplyPage", "/toApplyPage/{clubId}"})
    public String toApplyPage(
            @PathVariable(required = false) Integer clubId,  // 恢复PathVariable方式
            Model model
    ) {
        // 查询所有正常状态的社团，传递到页面
        List<Club> clubList = clubMapper.selectAllNormalClubs();
        model.addAttribute("clubList", clubList);

        // 如果带了clubId，传递到页面（用于预填表单）
        if (clubId != null) {
            model.addAttribute("clubId", clubId);
        }

        return "club/apply";  // 统一返回申请页面
    }

    // 2. 提交申请
    @PostMapping("/submit")
    public String submitApply(
            Integer clubId,
            String reason,
            HttpSession session,
            Model model
    ) {
        // 1. 从 session 获取 userId（登录时已存储）
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            model.addAttribute("error", "请先登录再提交申请");
            // 重新查询社团列表，避免页面无数据
            List<Club> clubList = clubMapper.selectAllNormalClubs();
            model.addAttribute("clubList", clubList);
            return "club/apply";
        }

        // 2. 提交申请
        try {
            clubApplyService.submitApply(clubId, userId, reason);
            model.addAttribute("message", "申请提交成功，请等待审核");
            return "redirect:/club/success";  // 跳转到成功页面
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            // 出错时重新查询社团列表
            List<Club> clubList = clubMapper.selectAllNormalClubs();
            model.addAttribute("clubList", clubList);
            return "club/apply";
        }
    }

    // 3. 管理员查看待审核列表 - 修改为使用clubId作为参数
    @GetMapping("/pending")
    public String pendingApplies(@RequestParam Integer clubId, Model model) {
        List<ClubApply> applies = clubApplyService.getPendingApplies(clubId);
        model.addAttribute("applies", applies);
        model.addAttribute("clubId", clubId);


        // 获取社团名称
        Club club = clubService.getClubById(clubId);
        if (club != null) {
            model.addAttribute("clubName", club.getName());
        }

        return "club/admin/pendingApplies";
    }

    // 4. 用户查看我的申请记录
    @GetMapping("/my")
    public String myApplies(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");
        List<ClubApply> myApplies = clubApplyService.getMyApplies(userId);
        model.addAttribute("myApplies", myApplies);
        return "club/myApplies";
    }

    // 5. 审核申请 - 修复重定向语法
    @GetMapping("/review/{applyId}/{status}")
    public String reviewApply(
            @PathVariable Integer applyId,
            @PathVariable String status,
            HttpSession session
    ) {
        try {
            Integer adminId = (Integer) session.getAttribute("userId");
            clubApplyService.reviewApply(applyId, status, adminId);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 获取申请对应的社团ID
        ClubApply apply = clubApplyMapper.selectById(applyId);
        if (apply != null) {
            return "redirect:/club/apply/pending?clubId=" + apply.getClubId();
        } else {
            return "redirect:/club/list";  // 申请不存在，跳转到安全页面
        }
    }

    // 处理“通过”申请
    @GetMapping("/approve/{applyId}")
    public String approveApply(@PathVariable Integer applyId) {
        // 直接调用Service更新状态
        clubApplyService.reviewStatus(applyId, "approved");
        // 重定向回管理页面（假设路径为/club/manage）
        return "redirect:/club/manage";
    }

    // 处理“拒绝”申请
    @GetMapping("/reject/{applyId}")
    public String rejectApply(@PathVariable Integer applyId) {
        // 直接调用Service更新状态
        clubApplyService.reviewStatus(applyId, "rejected");
        // 重定向回管理页面
        return "redirect:/club/manage";
    }
}