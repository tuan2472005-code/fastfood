package com.fastfood.dao;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import com.fastfood.model.LoyaltyReward;
import com.fastfood.util.DBUtil;

public class LoyaltyRewardDAO {
    private static final int DEFAULT_USES = 3;

    private static final BigDecimal[] THRESHOLDS = {
        new BigDecimal("500000"),
        new BigDecimal("1000000"),
        new BigDecimal("2000000"),
        new BigDecimal("5000000"),
        new BigDecimal("10000000")
    };

    private static final BigDecimal[] RATES = {
        new BigDecimal("3"),
        new BigDecimal("5"),
        new BigDecimal("7"),
        new BigDecimal("10"),
        new BigDecimal("15")
    };

    public LoyaltyReward findBestAvailableReward(int userId) throws SQLException {
        String sql = "SELECT * FROM tich_luy_uu_dai " +
                     "WHERE nguoi_dung_id = ? AND trang_thai = 'ACTIVE' AND so_lan_con_lai > 0 " +
                     "ORDER BY ty_le_giam DESC, moc_tich_luy DESC, created_at ASC LIMIT 1";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapReward(rs);
                }
            }
        }

        return null;
    }

    public BigDecimal calculateDiscount(LoyaltyReward reward, BigDecimal subtotal) {
        if (reward == null || subtotal == null || subtotal.compareTo(BigDecimal.ZERO) <= 0) {
            return BigDecimal.ZERO;
        }

        return subtotal.multiply(reward.getDiscountRate())
                .divide(new BigDecimal("100"), 0, RoundingMode.HALF_UP);
    }

    public boolean consumeReward(int rewardId) throws SQLException {
        String sql = "UPDATE tich_luy_uu_dai " +
                     "SET so_lan_con_lai = so_lan_con_lai - 1, " +
                     "    trang_thai = CASE WHEN so_lan_con_lai - 1 <= 0 THEN 'USED' ELSE 'ACTIVE' END, " +
                     "    updated_at = CURRENT_TIMESTAMP " +
                     "WHERE id = ? AND so_lan_con_lai > 0";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, rewardId);
            return stmt.executeUpdate() > 0;
        }
    }

    public void grantEligibleRewards(int userId) throws SQLException {
        BigDecimal deliveredTotal = getDeliveredTotalByUserId(userId);
        if (deliveredTotal.compareTo(BigDecimal.ZERO) <= 0) {
            return;
        }

        for (int i = 0; i < THRESHOLDS.length; i++) {
            BigDecimal threshold = THRESHOLDS[i];
            if (deliveredTotal.compareTo(threshold) >= 0 && !hasRewardForThreshold(userId, threshold)) {
                createReward(userId, threshold, RATES[i], deliveredTotal);
            }
        }
    }

    public BigDecimal getDeliveredTotalByUserId(int userId) throws SQLException {
        String sql = "SELECT COALESCE(SUM(tong_tien), 0) FROM don_hang WHERE nguoi_dung_id = ? AND trang_thai = 'DA_GIAO'";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getBigDecimal(1);
                }
            }
        }

        return BigDecimal.ZERO;
    }

    private boolean hasRewardForThreshold(int userId, BigDecimal threshold) throws SQLException {
        String sql = "SELECT COUNT(*) FROM tich_luy_uu_dai WHERE nguoi_dung_id = ? AND moc_tich_luy = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setBigDecimal(2, threshold);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }

        return false;
    }

    private void createReward(int userId, BigDecimal threshold, BigDecimal rate, BigDecimal deliveredTotal) throws SQLException {
        String sql = "INSERT INTO tich_luy_uu_dai " +
                     "(nguoi_dung_id, moc_tich_luy, ty_le_giam, tong_tich_luy_khi_dat, so_lan_toi_da, so_lan_con_lai, trang_thai, created_at, updated_at) " +
                     "VALUES (?, ?, ?, ?, ?, ?, 'ACTIVE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setBigDecimal(2, threshold);
            stmt.setBigDecimal(3, rate);
            stmt.setBigDecimal(4, deliveredTotal);
            stmt.setInt(5, DEFAULT_USES);
            stmt.setInt(6, DEFAULT_USES);
            stmt.executeUpdate();
        }
    }

    private LoyaltyReward mapReward(ResultSet rs) throws SQLException {
        LoyaltyReward reward = new LoyaltyReward();
        reward.setId(rs.getInt("id"));
        reward.setUserId(rs.getInt("nguoi_dung_id"));
        reward.setThresholdAmount(rs.getBigDecimal("moc_tich_luy"));
        reward.setDiscountRate(rs.getBigDecimal("ty_le_giam"));
        reward.setAccumulatedTotalAtEarn(rs.getBigDecimal("tong_tich_luy_khi_dat"));
        reward.setMaxUses(rs.getInt("so_lan_toi_da"));
        reward.setRemainingUses(rs.getInt("so_lan_con_lai"));
        reward.setStatus(rs.getString("trang_thai"));
        reward.setCreatedAt(rs.getTimestamp("created_at"));
        reward.setUpdatedAt(rs.getTimestamp("updated_at"));
        return reward;
    }
}
