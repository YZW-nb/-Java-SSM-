package com.java.mapper;

import com.java.pojo.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;


@Mapper
public interface UserMapper {

    /**
     * 根据用户名查询用户
     *
     * @param username 用户名
     * @return 用户对象
     */
    User selectByUsername(String username);


    /**
     * 根据学号查询用户（用于注册时校验学号唯一性）
     *
     * @param studentId 学号
     * @return 用户对象，若不存在则返回null
     */
    User selectByStudentId(String studentId);

    /**
     * 插入新用户
     *
     * @param user 用户对象
     * @return 插入行数
     */
    int insert(User user);

    // 新增：根据用户ID查询用户（关键方法）
    User selectById(Integer id);

    // 根据用户ID查询用户
    User getUserById(Integer userId);

    //检查用户是否为管理员
    Integer countUserRoleInClub(@Param("userId") Integer userId,
                                @Param("clubId") Integer clubId,
                                @Param("roleId") Integer roleId);


        /**
         * 查询所有普通学生
         *
         * @return 普通学生列表
         */
        List<User> selectAllStudents();

        /**
         * 根据ID更新用户信息
         *
         * @param user 用户对象
         * @return 更新行数
         */
        int update(User user);

        /**
         * 根据ID删除用户
         *
         * @param id 用户ID
         * @return 删除行数
         */
        int deleteById(Integer id);

}

