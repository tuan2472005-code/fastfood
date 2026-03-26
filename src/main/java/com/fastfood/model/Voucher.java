package com.fastfood.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Voucher {
    private int id;
    private String code;
    private String name;
    private String description;
    private String discountType; // PERCENTAGE hoặc FIXED_AMOUNT
    private BigDecimal discountValue;
    private BigDecimal minOrderAmount;
    private BigDecimal maxDiscountAmount;
    private int usageLimit;
    private int usedCount;
    private Timestamp startDate;
    private Timestamp endDate;
    private boolean isActive;
    private String voucherType; // PRODUCT hoặc SHIPPING
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Constructor mặc định
    public Voucher() {}

    // Constructor đầy đủ
    public Voucher(int id, String code, String name, String description, String discountType,
                   BigDecimal discountValue, BigDecimal minOrderAmount, BigDecimal maxDiscountAmount,
                   int usageLimit, int usedCount, Timestamp startDate, Timestamp endDate,
                   boolean isActive, String voucherType, Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.code = code;
        this.name = name;
        this.description = description;
        this.discountType = discountType;
        this.discountValue = discountValue;
        this.minOrderAmount = minOrderAmount;
        this.maxDiscountAmount = maxDiscountAmount;
        this.usageLimit = usageLimit;
        this.usedCount = usedCount;
        this.startDate = startDate;
        this.endDate = endDate;
        this.isActive = isActive;
        this.voucherType = voucherType;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters và Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDiscountType() {
        return discountType;
    }

    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }

    public BigDecimal getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(BigDecimal discountValue) {
        this.discountValue = discountValue;
    }

    public BigDecimal getMinOrderAmount() {
        return minOrderAmount;
    }

    public void setMinOrderAmount(BigDecimal minOrderAmount) {
        this.minOrderAmount = minOrderAmount;
    }

    public BigDecimal getMaxDiscountAmount() {
        return maxDiscountAmount;
    }

    public void setMaxDiscountAmount(BigDecimal maxDiscountAmount) {
        this.maxDiscountAmount = maxDiscountAmount;
    }

    public int getUsageLimit() {
        return usageLimit;
    }

    public void setUsageLimit(int usageLimit) {
        this.usageLimit = usageLimit;
    }

    public int getUsedCount() {
        return usedCount;
    }

    public void setUsedCount(int usedCount) {
        this.usedCount = usedCount;
    }

    public Timestamp getStartDate() {
        return startDate;
    }

    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }

    public Timestamp getEndDate() {
        return endDate;
    }

    public void setEndDate(Timestamp endDate) {
        this.endDate = endDate;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public String getVoucherType() {
        return voucherType;
    }

    public void setVoucherType(String voucherType) {
        this.voucherType = voucherType;
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

    // Phương thức kiểm tra voucher có hợp lệ không
    public boolean isValid() {
        Timestamp now = new Timestamp(System.currentTimeMillis());
        return isActive && 
               now.after(startDate) && 
               now.before(endDate) &&
               (usageLimit == 0 || usedCount < usageLimit);
    }

    // Phương thức tính toán số tiền giảm giá
    public BigDecimal calculateDiscount(BigDecimal orderAmount) {
        if (!isValid() || orderAmount.compareTo(minOrderAmount) < 0) {
            return BigDecimal.ZERO;
        }

        BigDecimal discount;
        if ("PERCENTAGE".equals(discountType)) {
            discount = orderAmount.multiply(discountValue).divide(new BigDecimal(100));
            if (maxDiscountAmount != null && discount.compareTo(maxDiscountAmount) > 0) {
                discount = maxDiscountAmount;
            }
        } else if ("FIXED_AMOUNT".equals(discountType)) {
            discount = discountValue;
        } else {
            // Trường hợp không xác định, trả về 0
            discount = BigDecimal.ZERO;
        }

        return discount;
    }

    @Override
    public String toString() {
        return "Voucher{" +
                "id=" + id +
                ", code='" + code + '\'' +
                ", name='" + name + '\'' +
                ", discountType='" + discountType + '\'' +
                ", discountValue=" + discountValue +
                ", isActive=" + isActive +
                '}';
    }
}