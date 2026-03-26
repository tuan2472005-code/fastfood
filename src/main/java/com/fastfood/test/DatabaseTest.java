package com.fastfood.test;

import java.sql.Connection;
import java.sql.SQLException;
import com.fastfood.util.DBUtil;

public class DatabaseTest {
    public static void main(String[] args) {
        System.out.println("Testing database connection...");
        
        try {
            Connection conn = DBUtil.getConnection();
            if (conn != null) {
                System.out.println("Database connection successful!");
                System.out.println("Connection URL: " + conn.getMetaData().getURL());
                System.out.println("Database Product: " + conn.getMetaData().getDatabaseProductName());
                System.out.println("Database Version: " + conn.getMetaData().getDatabaseProductVersion());
                conn.close();
            } else {
                System.out.println("Failed to create database connection!");
            }
        } catch (SQLException e) {
            System.out.println("Database connection failed!");
            System.out.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}