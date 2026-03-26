package com.fastfood.model;

import java.sql.Timestamp;

public class Review {
    private int id;
    private int sanPhamId;
    private Integer nguoiDungId;
    private String hoTen;
    private String email;
    private int rating;
    private String binhLuan;
    private Timestamp ngayTao;
    private String trangThai;
    
    // Constructors
    public Review() {}
    
    public Review(int sanPhamId, String hoTen, String email, int rating, String binhLuan) {
        this.sanPhamId = sanPhamId;
        this.hoTen = hoTen;
        this.email = email;
        this.rating = rating;
        this.binhLuan = binhLuan;
        this.trangThai = "pending";
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getSanPhamId() {
        return sanPhamId;
    }
    
    public void setSanPhamId(int sanPhamId) {
        this.sanPhamId = sanPhamId;
    }
    
    public Integer getNguoiDungId() {
        return nguoiDungId;
    }
    
    public void setNguoiDungId(Integer nguoiDungId) {
        this.nguoiDungId = nguoiDungId;
    }
    
    public String getHoTen() {
        return hoTen;
    }
    
    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public int getRating() {
        return rating;
    }
    
    public void setRating(int rating) {
        this.rating = rating;
    }
    
    public String getBinhLuan() {
        return binhLuan;
    }
    
    public void setBinhLuan(String binhLuan) {
        this.binhLuan = binhLuan;
    }
    
    public Timestamp getNgayTao() {
        return ngayTao;
    }
    
    public void setNgayTao(Timestamp ngayTao) {
        this.ngayTao = ngayTao;
    }
    
    public String getTrangThai() {
        return trangThai;
    }
    
    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }
    
    @Override
    public String toString() {
        return "Review{" +
                "id=" + id +
                ", sanPhamId=" + sanPhamId +
                ", nguoiDungId=" + nguoiDungId +
                ", hoTen='" + hoTen + '\'' +
                ", email='" + email + '\'' +
                ", rating=" + rating +
                ", binhLuan='" + binhLuan + '\'' +
                ", ngayTao=" + ngayTao +
                ", trangThai='" + trangThai + '\'' +
                '}';
    }
}