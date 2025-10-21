package com.java.controller;

import com.java.pojo.Club;
import com.java.pojo.User;
import com.java.service.ClubService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/student")
public class StudentController {

    @GetMapping("/home")
    public String studentHome() {
        return "student/home"; // 对应/WEB-INF/views/student/home.jsp
    }
}