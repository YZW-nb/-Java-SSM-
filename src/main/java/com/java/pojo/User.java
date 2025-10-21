package com.java.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Date;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private Integer id;
    private String username;
    private String password;
    private String name;
    private Integer role;  // 1-学生，2-社团管理员
    private Date createTime;
    private String studentId; // 新增：学号
    public static final int ROLE_STUDENT = 1;
    public static final int ROLE_ADMIN = 2;
}
