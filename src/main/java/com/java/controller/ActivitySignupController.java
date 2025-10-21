
// 活动报名表控制器
package com.java.controller;

import com.java.pojo.Activity;
import com.java.pojo.ActivitySignup;
import com.java.pojo.User;
import com.java.service.ActivityService;
import com.java.service.ActivitySignupService;
import com.java.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/activitysignup")  // 统一URL前缀为/activity
public class ActivitySignupController {

    @Autowired // 自动注入活动报名服务，用于处理活动报名相关业务逻辑
    private ActivitySignupService signupService;
    @Autowired
    private UserService userService;
    @Autowired
    private ActivityService activityService;

    @RequestMapping("/signup")  // 映射请求到/signup路径（支持所有HTTP方法）
    public String toSignupPage(
            @RequestParam String title,  // 必须提供的请求参数，活动标题
            HttpSession session          // HTTP会话对象，用于跨请求存储数据
    ) {
        // 1. 根据活动标题查询完整的活动信息
        Activity activity = activityService.getActivityByTitle(title);

        // 2. 将活动对象存入会话，供后续报名流程使用
        //    （避免在报名表单中传递过多隐藏字段）
        session.setAttribute("activity", activity);

        return "activitysignup/signup";
    }


    // 2. 处理活动报名请求
    @PostMapping("/signup/add")
    public String signupActivity(@RequestParam Integer activityId,
                                 @RequestParam(required = false) String remark,
                                 HttpSession session) {         // 获取当前用户会话
        User user = (User) session.getAttribute("user");
        // 1. 检查用户登录状态
        if (user == null) {
            return "redirect:/login";
        }
        // 2. 构建报名实体对象
        ActivitySignup signup = new ActivitySignup();
        signup.setUserId(user.getId());      // 设置报名用户ID
        signup.setActivityId(activityId);    // 设置活动ID
        signup.setRemark(remark);            // 设置用户备注（可能为null）
        // 3. 调用服务层处理报名逻辑
        boolean success = signupService.addSignup(signup);
        // 统一重定向到 /activitysignup/detail
        if (success) {
            return "/activitysignup/detail";
        } else {
          return "/activitysignup/detail" ;
        }
    }

    // 6. 修改报名备注
    @PostMapping("/signup/updateRemark")  // 限定POST方法，确保数据修改安全
    public String updateRemark(
            @RequestParam Integer id,      // 报名记录的主键ID
            @RequestParam String remark,   // 用户提交的新备注内容
            HttpSession session            // 获取当前用户会话
    ) {
        // 1. 用户登录检查
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";  // 未登录用户跳转登录页
        }

        // 2. 权限验证
        ActivitySignup signup = signupService.getSignup(id);
        // 验证报名记录存在且属于当前用户
        if (signup == null || !signup.getUserId().equals(user.getId())) {
            return "redirect:/error/403";  // 无权限访问
        }

        // 3. 更新备注信息
        signup.setRemark(remark);          // 设置新备注内容
        signupService.updateRemark(signup); // 调用服务层持久化

        // 4. 操作成功后重定向到我的报名列表
        return "redirect:/activity/signup/my";
    }


        // 7. 查看活动详情
        @GetMapping("/detail/{id}")  // URL，{id}为路径变量
        public String showActivityDetail(
                @PathVariable Integer id,  // 从URL路径中提取活动ID
                Model model                // 用于向视图传递数据的模型对象
        ) {
            // 1. 根据ID查询活动完整信息
            Activity activity = activityService.getActivityById(id);

            // 2. 将活动对象添加到模型
            //    - 属性名："activity"
            //    - 属性值：查询到的活动对象
            model.addAttribute("activity", activity);

            return "activitysignup/detail";
        }


    // 审批活动报名（表单提交处理）
    @GetMapping("/signup/approve/{id}")  // URL
    public String approveSignup(
            @PathVariable Integer id,                // 报名记录ID
            @RequestParam boolean approved,          // 审批结果
            @RequestParam(required = false) String reason,  // 拒绝原因（可选）
            RedirectAttributes redirectAttributes    // 重定向消息传递
    ) {
        try {
            //  获取报名记录
            ActivitySignup signup = signupService.getSignup(id);

            if (signup != null) {
                //  更新审批状态
                signup.setApproved(approved);

                //  保存更新
                signupService.updateSignup(signup);

                //  设置成功反馈
                redirectAttributes.addFlashAttribute("message",
                        approved ? "审批通过" : "已拒绝");
                redirectAttributes.addFlashAttribute("messageType", "success");
            } else {
                // 报名记录不存在
                redirectAttributes.addFlashAttribute("message", "未找到该报名记录");
                redirectAttributes.addFlashAttribute("messageType", "error");
            }
        } catch (Exception e) {
            // 异常处理
            redirectAttributes.addFlashAttribute("message",
                    "操作失败：" + e.getMessage());
            redirectAttributes.addFlashAttribute("messageType", "error");
        }

        // 7. 添加页面刷新标识
        redirectAttributes.addAttribute("refresh", "true");

        // 8. 重定向到报名列表（PRG模式防重复提交）
        return "redirect:/activitysignup/signup/list/all";
    }

    // ============== 管理员页面活动管理相关接口 ==============

    @GetMapping("/signup/list/all")
    public String handleActivityOperations(
            @RequestParam(required = false) String action,  // 操作类型
            @RequestParam(required = false) Integer id,     // 活动ID
            @RequestParam(required = false) String title,   // 活动标题
            @RequestParam(required = false) Integer clubId, // 所属社团ID
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startTime,  // 开始时间
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endTime,    // 结束时间
            @RequestParam(required = false) String location,  // 活动地点
            @RequestParam(required = false) Integer status,   // 活动状态
            @RequestParam(required = false) String keyword,   // 综合关键词
            Model model                                       // 数据模型
    ) {
        // 1.===============处理添加活动操作==============
        if ("add".equals(action) && title != null && clubId != null
                && startTime != null && location != null) {
            Activity activity = new Activity();
            activity.setTitle(title);
            activity.setClubId(clubId);
            activity.setStartTime(startTime);
            activity.setLocation(location);
            activity.setStatus(1);    // 设置默认状态为1（正常）

            // 调用服务层创建活动
            activityService.createActivity(activity);

            // 返回活动审批管理页面
            return "/activitysignup/admin-activity-approval";
        }

            // ================ 编辑活动====================
        if ("edit".equals(action) && id != null) {
            // 获取现有活动实体
            Activity existingActivity = activityService.getActivityById(id);

            // 确保活动存在
            if (existingActivity != null) {
                // 增量更新模式：只更新非空字段
                if (title != null) existingActivity.setTitle(title);
                if (clubId != null) existingActivity.setClubId(clubId);
                if (startTime != null) existingActivity.setStartTime(startTime);
                if (location != null) existingActivity.setLocation(location);
                if (status != null) existingActivity.setStatus(status);

                // 调用服务层更新方法（非create方法）
                activityService.updateActivity(existingActivity);
            }
            // 重定向到列表页（防止表单重复提交）
            return "redirect:/activitysignup/signup/list/all?action=list";
        }

            // 3. =================删除活动===============
            if ("delete".equals(action) && id != null) {
                // 调用取消活动方法（实际更新状态为0）
                activityService.cancelActivity(id, "管理员删除");
                return "redirect:/activitysignup/signup/list/all?action=list";
            }

            // 4. ==============搜索活动=============
        if ("search".equals(action) && keyword != null) {
            // 1. 获取所有活动数据（null和0表示不筛选社团和时间）
            List<Activity> allActivities = activityService.getActivities(null, 0);

            // 2. 创建结果集合
            List<Activity> result = new ArrayList<>();

            // 3. 遍历匹配关键词（当前为精确包含匹配）
            for (Activity activity : allActivities) {
                if (activity.getTitle().contains(keyword)) {
                    result.add(activity);
                }
            }
            // 4. 将结果存入模型
            model.addAttribute("activities", result);
            // 5. 返回审批管理页面
            return "/activitysignup/admin-activity-approval";
        }

        // 5. 显示活动列表
        if ("list".equals(action)) {
            // 获取活动列表
            List<Activity> activities = activityService.getActivities(null, 0);
            //存入模型
            model.addAttribute("activities", activities);
            return "/activitysignup/admin-activity-approval";
        }


            // 6. ================默认显示报名列表================
        // 1. 获取所有报名记录（基础数据）
        List<ActivitySignup> signups = signupService.getAllSignups();

      // 2. 创建前端展示用的DTO列表
        List<Map<String, Object>> signupList = new ArrayList<>();

      // 3. 数据转换处理
        for (ActivitySignup signup : signups) {
            //  获取关联活动信息（跳过无效活动）
            Activity activity = activityService.getActivityById(signup.getActivityId());
            if (activity == null) continue;  // 活动不存在则跳过当前记录

            //  构建前端需要的键值对结构
            Map<String, Object> item = new HashMap<>();
            // 基础报名信息
            item.put("id", signup.getId());
            item.put("activityId", activity.getId());
            item.put("activityTitle", activity.getTitle());
            item.put("clubId", activity.getClubId());

            // 审批状态（带空值保护）
            Boolean approved = signup.getApproved();
            item.put("approvalStatus", approved != null ?
                    (approved ? "已通过" : "待审批") : "待审批");

            // 用户信息
            item.put("userId", signup.getUserId());
            item.put("remark", signup.getRemark());

            // 活动状态（1=正常，其他=已取消）
            item.put("activityStatus", activity.getStatus() == 1 ? "正常" : "已取消");

            signupList.add(item);
        }
          //  将处理后的数据放入模型
        model.addAttribute("signupList", signupList);
           //  返回审批管理页面
        return "/activitysignup/admin-activity-approval";

    }
}