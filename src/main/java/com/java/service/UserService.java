package com.java.service;

import com.java.pojo.User;

import java.util.List;

/**
 * 用户服务接口
 */

public interface UserService {
        /**
         * 用户注册
         * @param user 用户对象
         * @return 注册结果，true表示成功，false表示失败
         */
        boolean register(User user);

        /**
         * 用户登录
         * @param username 用户名
         * @param password 密码
         * @return 登录成功返回用户对象，失败返回null
         */
        User login(String username, String password);
       User getUserById(Integer userId);

    /**
     * 查询所有普通用户
     * @return 普通用户列表
     */
    List<User> getAllStudents();

    /**
     * 根据ID查询普通用户
     * @param id 用户ID
     * @return 用户对象
     */
    User getStudentById(Integer id);

    /**
     * 添加普通用户
     *
     * @param user 用户对象
     * @return 插入结果
     */
    boolean addStudent(User user);

    /**
     * 更新普通用户信息
     *
     * @param user 用户对象
     * @return 更新结果
     */
    boolean updateStudent(User user);

    /**
     * 根据ID删除普通用户
     *
     * @param id 用户ID
     * @return 删除结果
     */
    boolean deleteStudent(Integer id);
}



