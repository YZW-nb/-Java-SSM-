package com.java.service.imp;


import com.java.mapper.UserMapper;
import com.java.pojo.User;
import com.java.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 用户服务实现类
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    @Override
    @Transactional
    public boolean register(User user) {
        //检查用户名是否已经存在
        User existingUser = userMapper.selectByUsername(user.getUsername());
        if (existingUser != null) {
            return false;//用户名已存在
        }
        // 2. 校验学号是否已存在（学生必填字段，非空时才校验）
        String studentId = user.getStudentId();
        if (studentId != null && !studentId.trim().isEmpty()) {
            User existingUserByStudentId = userMapper.selectByStudentId(studentId);
            if (existingUserByStudentId != null) {
                return false; // 学号已被注册
            }
        }
        //设置默认角色为学生
        if(user.getRole() == null){
            user.setRole(1);//1-学生
        }
        //插入新用户
        int result = userMapper.insert(user);
        return result > 0;
    }
    @Override
    public User login(String username, String password) {
        User user = userMapper.selectByUsername(username);
        if(user != null && user.getPassword().equals(password)){
            return user;
        }
        return null;
    }
    @Override
    public User getUserById(Integer userId) {
        // 调用Mapper方法，根据userId查询用户信息
        return userMapper.getUserById(userId);
    }

    @Override
    public List<User> getAllStudents() {
        // 假设角色为1表示普通学生
        // 这里可以根据实际情况修改查询条件
        // 由于没有直接查询所有学生的方法，可以遍历查询
        // 或者在Mapper中添加相应的方法
        // 这里简单示例直接查询所有用户，实际应用中可根据角色筛选
        return userMapper.selectAllStudents();
    }

    @Override
    public User getStudentById(Integer id) {
        return userMapper.selectById(id);
    }

    @Override
    public boolean addStudent(User user) {
        // 设置用户角色为普通学生
        user.setRole(User.ROLE_STUDENT);
        int result = userMapper.insert(user);
        return result > 0;
    }

    @Override
    public boolean updateStudent(User user) {
        int result = userMapper.update(user);
        // 如果 role 为空，从数据库查询原始用户信息获取角色
        if (user.getRole() == null) {
            User originalUser = getStudentById(user.getId());
            user.setRole(originalUser.getRole());
        }
        return result > 0;
    }

    @Override
    public boolean deleteStudent(Integer id) {
        int result = userMapper.deleteById(id);
        return result > 0;
    }
}
