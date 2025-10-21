package com.java.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Fund {
    private Integer id;             // 经费记录ID
    private Integer clubId;        // 所属社团ID
    private Integer type;          // 类型：1-收入，2-支出
    private BigDecimal amount;     // 金额（保留2位小数）
    private String sourceOrPurpose;// 来源/用途
    private Integer operatorId;    // 操作人ID
    private String proofDesc;      // 凭证说明
    private Date createTime;       // 记录时间（自动生成）

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date fundDate; // 经费发生日期（关键属性）

    // 2. 添加表单中的 remark 属性（必须有，否则参数绑定会警告）
    private String remark;          // 备注（对应表单的 name="remark"）
}
