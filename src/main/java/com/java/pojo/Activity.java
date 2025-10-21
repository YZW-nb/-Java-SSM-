package com.java.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.bind.annotation.RequestMapping;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Activity {
    private Integer id;
    private String title;
    private Integer clubId;
    private LocalDateTime startTime;
    private String location;
    private Integer status;// 1-正常，0-取消



}
