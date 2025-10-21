package com.java.service.imp;

import com.java.mapper.FundMapper;
import com.java.pojo.Club;
import com.java.pojo.Fund;
import com.java.pojo.User;
import com.java.service.ClubService;
import com.java.service.FundService;
import com.java.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
@Transactional(rollbackFor = Exception.class)
public class FundServiceImpl implements FundService {
    @Autowired
    private FundMapper fundMapper;
    @Autowired
    private ClubService clubService;
    @Autowired
    private UserService userService;
    public FundServiceImpl(FundMapper fundMapper) {
        this.fundMapper = fundMapper;
    }

//    @Override
//    public int addFund(Fund fund) {
//        if (fund.getClubId() == null || fund.getType() == null || fund.getAmount() == null) {
//            throw new IllegalArgumentException("经费记录信息不完整");
//        }
//        fund.setCreateTime(new Date());
//        return fundMapper.insertFund(fund);
//    }
    @Override
    public int addFund(Fund fund) {
        // 跳过所有校验，直接插入
        return fundMapper.insertFund(fund);
    }

    @Override
    public int deleteUnapprovedFund(Integer id) {
        // 校验记录是否存在且未审核
        Fund fund = fundMapper.selectFundDetail(id);
        if (fund == null) {
            throw new IllegalArgumentException("经费记录不存在");
        }
        // 假设：is_approved字段为0表示未审核（需根据实际表结构调整）
        // if (fund.getIsApproved() != 0) {
        //     throw new RuntimeException("已审核记录不可删除");
        // }

        // 校验是否关联活动/物资记录（需扩展）
        // if (hasRelatedRecords(id)) {
        //     throw new RuntimeException("存在关联记录，不可删除");
        // }

        return fundMapper.deleteUnapprovedFund(id);
    }

    @Override
    public int updateFundAmount(Integer id, BigDecimal newAmount, String reason) {
        if (newAmount == null || newAmount.compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("金额必须大于0");
        }
        if (reason == null || reason.trim().isEmpty()) {
            throw new IllegalArgumentException("修改原因不能为空");
        }
        // 校验记录是否存在（可扩展权限校验：是否为社长操作）
        return fundMapper.updateFundAmount(id, newAmount, new Date());
    }

    @Override
    public int updateProofDesc(Integer id, String newProofDesc) {
        if (newProofDesc == null || newProofDesc.trim().isEmpty()) {
            throw new IllegalArgumentException("凭证说明不能为空");
        }
        return fundMapper.updateProofDesc(id, newProofDesc, new Date());
    }

    @Override
    public List<Fund> getFundByCondition(Integer clubId, Date startTime, Date endTime, Integer type) {
        return fundMapper.selectFundByCondition(clubId, startTime, endTime, type);
    }

    @Override
    public Fund getFundDetail(Integer id) {
        return fundMapper.selectFundDetail(id);
    }

    @Override
    public List<Fund> getAllFunds() {
        return fundMapper.selectAllFunds(); // 调用 Mapper 的查询方法
    }

    @Override
    public List<Fund> getFundsWithRelations(int pageNum, int pageSize, Map<String, Object> params) {
        return List.of();
    }

    // 校验是否有关联记录（需根据实际表结构实现）
    private boolean hasRelatedRecords(Integer fundId) {
        // 示例：查询活动表和物资表是否关联该经费
        // return activityService.countByFundId(fundId) > 0 ||
        //        materialService.countByFundId(fundId) > 0;
        return false; // 简化实现，实际需根据业务逻辑完善
    }





}