package com.java.controller;

import com.java.pojo.User;
import com.java.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/admin/users")
public class UserManagementController {

    @Autowired
    private UserService userService;

    /**
     * 显示所有普通用户列表页面
     */
    @GetMapping("/user/list")
    public String showAllStudents(Model model) {
        List<User> students = userService.getAllStudents();
        model.addAttribute("students", students);
        return "/usermanagement/user-list";
    }

    /**
     * 显示添加用户页面
     */
    @GetMapping("/user/add")
    public String showAddStudentPage() {
        return "usermanagement/add-user";
    }
    /**
     * 处理添加用户请求
     */
    @PostMapping("/user/add")
    public String handleAddStudent(
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
            return "usermanagement/add-user";
        }

        // 创建用户对象
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setName(name);
        user.setStudentId(studentId);

        // 调用添加服务
        if (userService.addStudent(user)) {
            model.addAttribute("message", "添加用户成功！");
            return "/usermanagement/user-list";
        } else {
            model.addAttribute("error", "添加用户失败，请检查信息！");
            return "usermanagement/add-user";
        }
    }

    /**
     * 显示编辑用户页面
     */
    @GetMapping("/user/edit/{id}")
    public String showEditStudentPage(@PathVariable("id") Integer id, Model model) {
        User student = userService.getStudentById(id);
        model.addAttribute("student", student);
        return "usermanagement/edit-user";
    }

    /**
     * 处理编辑用户请求
     */
    @PostMapping("/user/edit/{id}")
    public String handleEditStudent(
            @PathVariable("id") Integer id,
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
            User student = new User();
            student.setId(id);
            student.setUsername(username);
            student.setPassword(password);
            student.setName(name);
            student.setStudentId(studentId);

            model.addAttribute("student", student);
            return "usermanagement/edit-user";
        }
// 从数据库查询原始用户信息，获取角色
        User originalUser = userService.getStudentById(id); // 确保正确获取原始用户
        // 创建用户对象
        User user = new User();
        user.setId(id);
        user.setUsername(username);
        user.setPassword(password);
        user.setName(name);
        user.setStudentId(studentId);
// 关键：设置角色，避免 null
        user.setRole(originalUser.getRole());
        // 调用更新服务
        if (userService.updateStudent(user)) {
            model.addAttribute("message", "更新用户信息成功！");
            return "/usermanagement/user-list";
        } else {
            model.addAttribute("error", "更新用户信息失败，请检查信息！");
            User student = userService.getStudentById(id);
            model.addAttribute("student", student);
            return "usermanagement/edit-user";
        }
    }
    /**
     * 处理删除用户请求
     */
    @GetMapping("/user/delete/{id}")
    public String handleDeleteStudent(@PathVariable("id") Integer id, Model model) {
        if (userService.deleteStudent(id)) {
            model.addAttribute("message", "删除用户成功！");
        } else {
            model.addAttribute("error", "删除用户失败，请稍后再试！");
        }
        return "/usermanagement/user-list";
    }
}