package com.fastfood.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class LoyaltyReward {
    private int id;
    private int userId;
    private BigDecimal thresholdAmount;
    private BigDecimal discountRate;
    private BigDecimal accumulatedTotalAtEarn;
    private int maxUses;
    private int remainingUses;
    private String status;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public BigDecimal getThresholdAmount() {
        return thresholdAmount;
    }

    public void setThresholdAmount(BigDecimal thresholdAmount) {
        this.thresholdAmount = thresholdAmount;
    }

    public BigDecimal getDiscountRate() {
        return discountRate;
    }

    public void setDiscountRate(BigDecimal discountRate) {
        this.discountRate = discountRate;
    }

    public BigDecimal getAccumulatedTotalAtEarn() {
        return accumulatedTotalAtEarn;
    }

    public void setAccumulatedTotalAtEarn(BigDecimal accumulatedTotalAtEarn) {
        this.accumulatedTotalAtEarn = accumulatedTotalAtEarn;
    }

    public int getMaxUses() {
        return maxUses;
    }

    public void setMaxUses(int maxUses) {
        this.maxUses = maxUses;
    }

    public int getRemainingUses() {
        return remainingUses;
    }

    public void setRemainingUses(int remainingUses) {
        this.remainingUses = remainingUses;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getDisplayLabel() {
        String threshold = thresholdAmount != null ? String.format("%,.0f", thresholdAmount) : "0";
        String rate = discountRate != null ? discountRate.stripTrailingZeros().toPlainString() : "0";
        return "Tich luy " + threshold + "d giam " + rate + "%, con " + remainingUses + "/" + maxUses + " luot";
    }
}
