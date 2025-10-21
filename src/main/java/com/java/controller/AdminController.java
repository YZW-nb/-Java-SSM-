package com.java.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {
    // 管理员主页
    @GetMapping("/home")
    public String adminHome() {
        return "admin/home"; // 对应/WEB-INF/views/admin/home.jsp
    }
}