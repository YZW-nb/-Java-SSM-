//活动表
package com.java.controller;

import com.java.pojo.Activity;
import com.java.pojo.User;
import com.java.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 活动管理控制器
 */
@Controller
@RequestMapping("/activity")
public class ActivityController {

    @Autowired
    private ActivityService activityService;


    // 3. 活动列表页面
    @GetMapping("/list")  // 映射HTTP GET请求到/list路径
    public String showAllActivities(
            @RequestParam(required = false) Integer clubId,  // 可选的请求参数，不必须提供
            @RequestParam(defaultValue = "0") int timeType,  // 请求参数，默认值为0
            Model model  // Spring MVC模型对象，用于控制器和视图间传递数据
    ) {
        // 调用服务层方法，根据参数获取活动列表
        List<Activity> activities = activityService.getActivities(clubId, timeType);

        // 将活动列表添加到模型中，供视图使用
        model.addAttribute("activities", activities);

        return "activity/list";
    }



//     4. "我的活动"列表（
@GetMapping("/my")  // 映射HTTP GET请求到/my路径
public String showMyActivities(Model model) {
    // 调用服务层方法获取当前用户的所有活动
    // 参数设置为null和0表示不筛选特定社团和所有时间范围的活动
    List<Activity> myActivities = activityService.getActivities(null, 0);

    // 将活动列表添加到模型中，供视图使用
    // 使用"activities"作为属性名保持与列表页面一致
    model.addAttribute("activities", myActivities);

    return "activity/my";
}


    // 5. 活动详情页面
    @GetMapping("/detail")  // 映射GET请求到/detail路径
    public String showDetail(
            @RequestParam String title,  // 必须提供的请求参数，活动标题
            Model model                  // 用于向视图传递数据的模型对象
    ) {
        // 1. 通过活动标题查询活动详情
        Activity activity = activityService.getActivityByTitle(title);

        // 2. 统计该活动的报名人数（通过活动ID）
        int signupCount = activityService.countSignup(activity.getId());

        // 3. 将活动详情和报名人数添加到模型
        model.addAttribute("activity", activity);      // 活动详情对象
        model.addAttribute("signupCount", signupCount); // 报名人数统计

        return "activity/detail";
    }


    // 8. 活动报名
    @GetMapping("/signup/{id}")  // RESTful风格URL，{id}为路径变量
    public String signup(
            @PathVariable("id") Integer activityId,  // 从URL路径中提取活动ID
            HttpSession session                     // 获取HTTP会话以检查用户登录状态
    ) {
        // 1. 从会话中获取当前登录用户信息
        User loginUser = (User) session.getAttribute("user");

        // 2. 调用服务层方法完成报名逻辑
        //    - 参数1：要报名的活动ID
        //    - 参数2：报名用户的ID
        activityService.signup(activityId, loginUser.getId());

        // 3. 报名成功后重定向到活动详情页
        return "redirect:/activity/detail/" + activityId;
    }



}