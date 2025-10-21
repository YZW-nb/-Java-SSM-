package com.java.controller;

import com.java.pojo.Club;
import com.java.pojo.ClubApply;
import com.java.pojo.User;
import com.java.service.ClubApplyService;
import com.java.service.ClubMemberService;
import com.java.service.ClubService;
import org.mybatis.spring.batch.MyBatisBatchItemWriter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/club")
public class ClubController {
    @Autowired
    private ClubService clubService;
    @Autowired
    private ClubApplyService clubApplyService;
    @Autowired
    private ClubMemberService clubMemberService;
    // 1. 跳转到新增社团页面
    @GetMapping("/add")
    public String toaddPage() {
        return "club/add";// WEB-INF/views/club/add.jsp
    }

    // 2. 处理新增社团请求
    @PostMapping("/add")
    public String addClub(Club club, HttpSession session) {
        User loginUser = (User) session.getAttribute("user");
        club.setFounderId(loginUser.getId());
        clubService.addClub(club);
        club.setStatus(1); // 设置状态为"正常"
        // 打印日志，检查参数
        System.out.println("创建社团: " + club);

        return "redirect:/club/manage"; // 重定向到社团管理页面
    }

    // 3. 社团列表页面
    @GetMapping("/list")
    public String showAllClubs(Model model) {
        List<Club> clubs = clubService.getAllClubs();
        model.addAttribute("clubs", clubs);
        return "club/list";
    }

    // 4. 创建人社团
    @GetMapping("/my")
    public String showMyClubs(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("user");
        List<Club> myclubs = clubService.getMyClubs(loginUser.getId());
        model.addAttribute("clubs", myclubs);
        return "club/my";
    }

    // 5. 社团详细
    @GetMapping("/detail/{id}")
    public String showDetail(@PathVariable("id") Integer id, Model model) {
        Club club = clubService.getClubById(id);
        model.addAttribute("club", club);
        return "club/detail";
    }

    // 6. 跳转到编辑页面
    @GetMapping("/edit/{id}")
    public String toEditPage(@PathVariable("id")Integer id, Model model) {
        model.addAttribute("club", clubService.getClubById(id));
        return "club/edit";
    }

    // 7. 处理编辑请求
    @PostMapping("/edit")
    public String editClub(Club club, HttpSession session) {
        clubService.editClub(club);
        // 存储成功提示到Session
        session.setAttribute("successMsg", "社团信息修改成功！");
        return "redirect:/club/detail/" + club.getId();
    }

    // 8. 删除社团
    @GetMapping("/delete/{id}")
    public String deleteClub(@PathVariable("id") Integer id) {
        clubService.removeClub(id);
        return "redirect:/club/manage";
    }

    @GetMapping("/success")
    public String showSuccessPage(@RequestParam("message") String message, Model model) {
        model.addAttribute("message", message);
        return "club/success";
    }


@GetMapping("/manage")
public String toManagePage(HttpSession session, Model model) {
    User loginUser = (User) session.getAttribute("user");
    if (loginUser == null) {
        return "redirect:/login";
    }

    List<Club> myClubs = clubService.getMyClubs(loginUser.getId());
    Map<Integer, Integer> applyCountMap = new HashMap<>();
    Map<Integer, List<ClubApply>> clubAppliesMap = new HashMap<>();
    // 新增：合并所有申请的扁平列表
    List<ClubApply> allApplies = new ArrayList<>();

    for (Club club : myClubs) {
        // 1. 统计待审核数量
        int applyCount = clubApplyService.getPendingApplyCount(club.getId());
        applyCountMap.put(club.getId(), applyCount);

        // 2. 获取该社团所有申请
        List<ClubApply> applies = clubApplyService.getAppliesByClubId(club.getId());
        clubAppliesMap.put(club.getId(), applies);

        // 3. 合并到扁平列表
        allApplies.addAll(applies);
    }

    // 传递数据给前端：保留原 Map，新增扁平列表
    model.addAttribute("clubs", myClubs);
    model.addAttribute("applyCountMap", applyCountMap);
    model.addAttribute("clubAppliesMap", clubAppliesMap);
    model.addAttribute("applies", allApplies);

    return "club/manage";
}
}