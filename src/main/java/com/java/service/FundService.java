package com.java.service;

import com.java.pojo.Fund;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

public interface FundService {
    // 增：录入经费记录
    int addFund(Fund fund);

    // 删：删除未审核记录
    int deleteUnapprovedFund(Integer id);

    // 改：修改支出金额
    int updateFundAmount(Integer id, BigDecimal newAmount, String reason);

    // 改：补充凭证说明
    int updateProofDesc(Integer id, String newProofDesc);

    // 查：按条件统计经费
    List<Fund> getFundByCondition(Integer clubId, Date startTime, Date endTime, Integer type);

    // 查：单条经费详情
    Fund getFundDetail(Integer id);

    List<Fund> getAllFunds();

    List<Fund> getFundsWithRelations(int pageNum, int pageSize, Map<String, Object> params);

}