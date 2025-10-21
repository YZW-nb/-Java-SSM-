//经费管理表
package com.java.controller;

import com.java.mapper.FundMapper;
import com.java.pojo.Club;
import com.java.pojo.Fund;
import com.java.pojo.User;
import com.java.service.ClubService;
import com.java.service.FundService;
import com.java.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.*;
import java.util.List;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


@Controller  // 改为 Controller，支持返回视图
@RequestMapping("/fund")
public class FundController {
    @Autowired
    private  FundService fundService;

    @Autowired
    private ClubService clubService; // 假设存在社团服务

    @Autowired
    private UserService userService;
    public FundController(FundService fundService) {
        this.fundService = fundService;
    }

    // 1. 显示经费列表页面（JSP 视图）
    @GetMapping("/list")
    public String showFundList(Model model,
                               @RequestParam(required = false) Integer clubId,
                               @RequestParam(required = false) Date startTime,
                               @RequestParam(required = false) Date endTime,
                               @RequestParam(required = false) Integer type) {
        // 查询所有社团
        List<Club> clubs = clubService.getAllClubs();
        model.addAttribute("clubs", clubService.getAllClubs());
        // 查询数据并传递到 JSP

        List<Fund> funds = fundService.getAllFunds(); // 获取经费列表
        System.out.println("查询到的经费数量：" + funds.size()); // 打印数量
        System.out.println("第一条经费：" + funds.stream().findFirst()); // 打印第一条数据
        model.addAttribute("funds", funds);


        // 返回 JSP 视图路径（对应 /WEB-INF/jsp/fund/list.jsp）
        return "fund/list";
    }

    // 2. 显示添加经费表单页面
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("clubs", clubService.getAllClubs());
        return "fund/add";
    }

    // 处理提交（跳过校验，直接保存）
    @PostMapping("/add")
    public String addFund(@ModelAttribute Fund fund, Model model, HttpSession session, HttpServletRequest request) {
        // 打印参数，用于调试
        System.out.println("接收到的club_id: " + request.getParameter("club_id"));

        // 手动设置club_id（如果@ModelAttribute未自动绑定）
        if (fund.getClubId() == null) {
            String clubIdParam = request.getParameter("clubId");
            if (clubIdParam != null && !clubIdParam.isEmpty()) {
                fund.setClubId(Integer.valueOf(clubIdParam));
            }
        }
        try {
            // 从 Session 获取当前用户（确保登录时存了 user 对象）
            User user = (User) session.getAttribute("user");
            if (user != null) {
                fund.setOperatorId(user.getId()); // 设置操作人 ID
            } else {
                throw new RuntimeException("用户未登录，无法获取操作人信息");
            }
            // 补全其他必要字段
            fund.setCreateTime(new Date());
            // 调用 Service 保存
            fundService.addFund(fund);
            // 保存成功，跳转列表页
            return "redirect:/fund/list";

        } catch (Exception e) {
            // 保存失败，回显错误
            model.addAttribute("error", "提交失败：" + e.getMessage());
            model.addAttribute("clubs", clubService.getAllClubs());
            return "fund/add";
        }
    }



    // 4. 用户显示修改金额表单页面
    @GetMapping("/update/amount/{id}")
    public String showUpdateAmountForm(@PathVariable Integer id, Model model) {
        Fund fund = fundService.getFundDetail(id);

   // 通过 clubId 获取 Club 对象
        Club club = clubService.getClubById(fund.getClubId());

        // 将 Fund 对象和社团名称分别添加到模型中
        model.addAttribute("fund", fund);
        model.addAttribute("clubName", club != null ? club.getName() : "未知社团");
        return "fund/updateAmount";  // 对应 /WEB-INF/jsp/fund/updateAmount.jsp
    }

  //返回按钮
    @GetMapping("/update/amount")
    public String returnupdateAmount() {
        return "fund/list";
    }
    // 5. 用户处理修改金额请求
    @PostMapping("/update/amount")
    public String updateAmount(@RequestParam Integer id,
                               @RequestParam BigDecimal newAmount,
                               @RequestParam String reason,
                               Model model) {
        try {
            fundService.updateFundAmount(id, newAmount, reason);
            return "redirect:/fund/list";  // 成功后跳转到列表页
        } catch (Exception e) {
            model.addAttribute("error", "修改失败：" + e.getMessage());
            // 失败时回显当前数据
            model.addAttribute("fund", fundService.getFundDetail(id));
            return "fund/list";  // 回到修改表单页
        }
    }

    // 用户处理删除请求
    @GetMapping("/delete/{id}")  // JSP 表单通常用 GET 处理删除（需确认提示）
    public String deleteFund(@PathVariable Integer id, Model model) {
        try {
            fundService.deleteUnapprovedFund(id);
            return "redirect:/fund/list";
        } catch (Exception e) {
            // 删除失败时，在列表页显示错误
            model.addAttribute("error", "删除失败：" + e.getMessage());
            // 重新查询列表数据（避免删除失败后列表不刷新）
            List<Fund> funds = fundService.getFundByCondition(null, null, null, null);
            model.addAttribute("funds", funds);
            return "fund/list";
        }
    }


    // 4. 管理员显示修改金额表单页面
    @GetMapping("admin/update/amount/{id}")
    public String adminshowUpdateAmountForm(@PathVariable Integer id, Model model) {
        Fund fund = fundService.getFundDetail(id);

        // 通过 clubId 获取 Club 对象
        Club club = clubService.getClubById(fund.getClubId());

        // 将 Fund 对象和社团名称分别添加到模型中
        model.addAttribute("fund", fund);
        model.addAttribute("clubName", club != null ? club.getName() : "未知社团");
        return "fund/adminupdateAmount";
    }

    // 5. 管理员处理修改金额请求
    @PostMapping("admin/update/amount")
    public String adminupdateAmount(@RequestParam Integer id,
                               @RequestParam BigDecimal newAmount,
                               @RequestParam String reason,
                               Model model) {
        try {
            fundService.updateFundAmount(id, newAmount, reason);
            return "/fund/fundManagement";  // 成功后跳转到列表页
        } catch (Exception e) {
            model.addAttribute("error", "修改失败：" + e.getMessage());
            // 失败时回显当前数据
            model.addAttribute("fund", fundService.getFundDetail(id));
            return "fund/fundManagement";  // 回到修改表单页
        }
    }
    // 管理员处理删除请求
    @GetMapping("admin/delete/{id}")  // JSP 表单通常用 GET 处理删除（需确认提示）
    public String admindeleteFund(@PathVariable Integer id, Model model) {
        try {
            fundService.deleteUnapprovedFund(id);
            return "redirect:/fund/management";
        } catch (Exception e) {
            // 删除失败时，在列表页显示错误
            model.addAttribute("error", "删除失败：" + e.getMessage());
            // 重新查询列表数据（避免删除失败后列表不刷新）
            List<Fund> funds = fundService.getFundByCondition(null, null, null, null);
            model.addAttribute("funds", funds);
            return "fund/fundManagement";
        }
    }



    // 9. 显示单条经费详情页面
    @GetMapping("/detail/{id}")
    public String showFundDetail(@PathVariable Integer id, Model model) {
        Fund fund = fundService.getFundDetail(id);
        // 获取社团信息
        Club club = clubService.getClubById(fund.getClubId());
        String clubName = club != null ? club.getName() : "未知社团";
        // 获取操作人信息（假设你有一个UserService）
        User operator = userService.getUserById(fund.getOperatorId());
        String operatorName = operator != null ? operator.getUsername() : "未知用户";
        // 将社团名称添加到模型
        model.addAttribute("clubName", clubName);
        model.addAttribute("fund", fund);
        model.addAttribute("operatorName", operatorName);
        return "fund/detail";  // 对应 /WEB-INF/jsp/fund/detail.jsp
    }

//管理员经费管理页面
    @GetMapping("/management")
    public String FundList(Model model,
                               @RequestParam(required = false) Integer clubId,
                               @RequestParam(required = false) Date startTime,
                               @RequestParam(required = false) Date endTime,
                               @RequestParam(required = false) Integer type) {
        // 查询所有社团
        List<Club> clubs = clubService.getAllClubs();
        model.addAttribute("clubs", clubs);

        // 查询数据并传递到 JSP
        List<Fund> funds = fundService.getFundByCondition(clubId, startTime, endTime, type);
        model.addAttribute("funds", funds);

        // 返回 JSP 视图路径（对应 /WEB-INF/jsp/fund/list.jsp）
        return "/fund/fundManagement";
    }

    // 管理员显示添加经费表单
    @GetMapping("/fund/add")
    public String showAddForm(Model model, HttpSession session) {
        // 验证用户权限
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != User.ROLE_ADMIN) {
            return "redirect:/login";
        }

        // 添加社团列表到模型（用于下拉选择框）
        model.addAttribute("clubs", clubService.getAllClubs());
        model.addAttribute("fund", new Fund()); // 创建空的Fund对象

        return "fund/managementadd"; // 返回表单页面
    }

    // 管理员处理表单提交
    @PostMapping("/fund/add")
    public String processAddForm(
            @ModelAttribute Fund fund,
            HttpSession session,
            RedirectAttributes redirectAttributes
    ) {
        try {
            // 验证用户权限
            User user = (User) session.getAttribute("user");
            if (user == null || user.getRole() != User.ROLE_ADMIN) {
                throw new RuntimeException("权限不足");
            }

            // 设置操作人ID和创建时间
            fund.setOperatorId(user.getId());
            fund.setCreateTime(new Date());

            // 保存经费记录
            fundService.addFund(fund);

            // 添加成功消息
            redirectAttributes.addFlashAttribute("success", "经费记录添加成功");
            return "redirect:/fund/management"; // 重定向到列表页

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "操作失败: " + e.getMessage());
            return "redirect:/fund/add"; // 重新显示表单
        }
    }
}