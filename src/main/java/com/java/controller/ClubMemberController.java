//社团成员表
package com.java.controller;

import com.java.service.ClubMemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller  // 改为Controller，支持JSP视图
@RequestMapping("/club/member")
public class ClubMemberController {

    @Autowired
    private ClubMemberService clubMemberService;

    // 1. 显示加入社团页面（选择社团或确认加入）
    @GetMapping("/join/{clubId}")
    public String showJoinPage(@PathVariable Integer clubId, Model model) {
        model.addAttribute("clubId", clubId);
        return "club/member/join";  // 对应/WEB-INF/jsp/club/member/join.jsp
    }

    // 处理加入社团请求
    @PostMapping("/join/{clubId}")
    public String join(@PathVariable Integer clubId, HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            model.addAttribute("error", "请先登录");
            return "/login";  // 跳转到登录页
        }
        try {
            clubMemberService.joinClub(clubId, userId);
            model.addAttribute("message", "加入成功");
            return "redirect:/club/member/my";  // 跳转到"我的社团"页面
        } catch (Exception e) {
            model.addAttribute("error", "加入失败：" + e.getMessage());
            model.addAttribute("clubId", clubId);
            return "club/member/join";  // 回到加入页面
        }
    }

    // 2. 显示退出社团确认页
    @GetMapping("/exit/{clubId}")
    public String showExitPage(@PathVariable Integer clubId, Model model) {
        model.addAttribute("clubId", clubId);
        return "club/member/exit";  // 对应/WEB-INF/jsp/club/member/exit.jsp
    }

    // 处理退出社团请求
    @PostMapping("/exit/{clubId}")
    public String exit(@PathVariable Integer clubId, HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            model.addAttribute("error", "请先登录");
            return "/login";
        }
        try {
            clubMemberService.exitClub(clubId, userId);
            model.addAttribute("message", "退出成功");
            return "redirect:/club/member/my";  // 跳转到"我的社团"页面
        } catch (Exception e) {
            model.addAttribute("error", "退出失败：" + e.getMessage());
            model.addAttribute("clubId", clubId);
            return "club/member/exit";  // 回到退出确认页
        }
    }

    // 3. 显示社团成员列表页面
    @GetMapping("/list/{clubId}")
    public String showMemberList(@PathVariable Integer clubId, Model model) {
        List<Integer> memberIds = clubMemberService.getClubMembers(clubId);
        model.addAttribute("clubId", clubId);
        model.addAttribute("memberIds", memberIds);
        return "club/member/list";  // 对应/WEB-INF/jsp/club/member/list.jsp
    }

    // 4. 显示"我的社团"列表页面
    @GetMapping("/my")
    public String showMyClubs(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            model.addAttribute("error", "请先登录");
            return "/login";
        }
        List<Integer> myClubIds = clubMemberService.getUserClubs(userId);
        model.addAttribute("myClubIds", myClubIds);
        return "club/member/my";  // 对应/WEB-INF/jsp/club/member/my.jsp
    }

    // 5. 检查是否为成员（AJAX接口，返回JSON供前端判断）
    @GetMapping("/check/{clubId}")
    @ResponseBody  // 保留JSON返回，供前端异步校验
    public boolean check(@PathVariable Integer clubId, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        return userId != null && clubMemberService.isMember(clubId, userId);
    }

    // 6. 显示社团成员数量页面（或嵌入其他页面）
    @GetMapping("/count/{clubId}")
    public String showMemberCount(@PathVariable Integer clubId, Model model) {
        int count = clubMemberService.getMemberCount(clubId);
        model.addAttribute("clubId", clubId);
        model.addAttribute("count", count);
        return "club/member/count";  // 对应/WEB-INF/jsp/club/member/count.jsp
    }
}