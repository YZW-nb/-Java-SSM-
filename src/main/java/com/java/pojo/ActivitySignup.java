package com.java.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ActivitySignup {
    private Integer id;
    private Integer userId;
    private Integer activityId;
    private LocalDateTime signupTime;
    private String remark;      // 报名备注（如特殊需求、留言等）
    // 新增 User 属性，用于关联用户信息
    private User user;
    private Boolean approved; // 审批状态，例如：true（通过）、false（拒绝）、null（待审批）
}
