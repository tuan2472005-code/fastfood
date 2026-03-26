package com.fastfood.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

public class Order {
    private int id;
    private int userId;
    private BigDecimal totalAmount;
    private String status;
    private String paymentMethod;
    private String paymentStatus;
    private String shippingAddress;
    private String shippingPhone;
    private String shippingName;
    private String note;
    private String customerName;
    private String customerPhone;
    private String customerAddress;
    private String notes;
    private Timestamp orderDate;
    private List<OrderItem> orderItems;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Product voucher related fields
    private Integer voucherId;
    private String voucherCode;
    private BigDecimal discountAmount;
    
    // Shipping voucher related fields
    private Integer shippingVoucherId;
    private String shippingVoucherCode;
    private BigDecimal shippingDiscountAmount;
    
    // Shipping fee
    private BigDecimal shippingFee;
    
    public Order() {
    }
    
    public Order(int id, int userId, BigDecimal totalAmount, String status, String paymentMethod,
                String shippingAddress, String shippingPhone, String shippingName, String note) {
        this.id = id;
        this.userId = userId;
        this.totalAmount = totalAmount;
        this.status = status;
        this.paymentMethod = paymentMethod;
        this.shippingAddress = shippingAddress;
        this.shippingPhone = shippingPhone;
        this.shippingName = shippingName;
        this.note = note;
    }

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

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public String getShippingPhone() {
        return shippingPhone;
    }

    public void setShippingPhone(String shippingPhone) {
        this.shippingPhone = shippingPhone;
    }

    public String getShippingName() {
        return shippingName;
    }

    public void setShippingName(String shippingName) {
        this.shippingName = shippingName;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
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
    
    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public String getCustomerAddress() {
        return customerAddress;
    }

    public void setCustomerAddress(String customerAddress) {
        this.customerAddress = customerAddress;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }
    
    // Voucher getters and setters
    public Integer getVoucherId() {
        return voucherId;
    }

    public void setVoucherId(Integer voucherId) {
        this.voucherId = voucherId;
    }

    public String getVoucherCode() {
        return voucherCode;
    }

    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }
    
    // Shipping voucher getters and setters
    public Integer getShippingVoucherId() {
        return shippingVoucherId;
    }

    public void setShippingVoucherId(Integer shippingVoucherId) {
        this.shippingVoucherId = shippingVoucherId;
    }

    public String getShippingVoucherCode() {
        return shippingVoucherCode;
    }

    public void setShippingVoucherCode(String shippingVoucherCode) {
        this.shippingVoucherCode = shippingVoucherCode;
    }

    public BigDecimal getShippingDiscountAmount() {
        return shippingDiscountAmount;
    }

    public void setShippingDiscountAmount(BigDecimal shippingDiscountAmount) {
        this.shippingDiscountAmount = shippingDiscountAmount;
    }
    
    public BigDecimal getShippingFee() {
        return shippingFee;
    }

    public void setShippingFee(BigDecimal shippingFee) {
        this.shippingFee = shippingFee;
    }
}