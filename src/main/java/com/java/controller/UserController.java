package com.java.controller;

import com.java.pojo.User;
import com.java.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/register")
    public String showRegisterPage() {
        return "register";
    }

    /**
     * 处理注册请求
     */
    @PostMapping("/register")
    public String handleRegister(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            @RequestParam("name") String name,
            @RequestParam("studentId") String studentId,
            Model model
    ) {
        // 参数校验（所有字段均不能为空）
        if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                name == null || name.trim().isEmpty() ||
                studentId == null || studentId.trim().isEmpty()) {
            model.addAttribute("error", "所有字段（含学号）均不能为空！");
            return "register";
        }

        // 创建用户对象
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setName(name);
        user.setStudentId(studentId);

        // 调用注册服务
        if (userService.register(user)) {
            model.addAttribute("message", "注册成功，请登录！");
            return "login";
        } else {
            model.addAttribute("error", "用户名或学号已存在！");
            return "register";
        }
    }
   @GetMapping("/login")
   public String showLoginPage() {
        return "login";
   }
    /**
     * 处理登录请求（核心修改：存储 userId 到 session）
     */
    @PostMapping("/login")
    public String handleLogin(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            @RequestParam("role") Integer selectedRole, // 角色选择（1=学生，2=管理员）
            Model model,
            HttpSession session
    ) {
        // 1. 验证账号密码
        User user = userService.login(username, password);
        if (user == null) {
            model.addAttribute("error", "用户名或密码错误");
            return "login";
        }

        // 2. 校验角色权限
        if (!user.getRole().equals(selectedRole)) {
            String roleName = selectedRole == 2 ? "管理员" : "学生";
            model.addAttribute("error", "您没有" + roleName + "权限，请选择正确角色登录");
            return "login";
        }

        // 3. 登录成功：存储完整用户对象 + 单独存储 userId（关键修改）
        session.setAttribute("user", user);          // 存储完整用户信息
        session.setAttribute("userId", user.getId()); // 单独存储 userId，供后续业务使用

        // 4. 根据角色跳转对应主页
        return user.getRole() == 1 ? "redirect:/student/home" : "redirect:/admin/home";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("user");
        session.removeAttribute("userId"); // 同步移除 userId
        session.invalidate();
        return "redirect:/login";
    }
}
