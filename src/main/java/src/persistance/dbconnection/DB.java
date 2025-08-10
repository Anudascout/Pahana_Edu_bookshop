package src.persistance.dbconnection;

import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Connection;

public class DB {

    private static final String URL = "jdbc:mysql://localhost:3306/Bookshop";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    private static DB instance;
    private Connection connection;


    private DB() {
        try {
            Class.forName(DRIVER);
            this.connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException("Error initializing DBConnection", e);
        }
    }


    public static synchronized DB getInstance() {
        if (instance == null) {
            instance = new DB();
        }
        return instance;
    }


    public Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                this.connection = DriverManager.getConnection(URL, USER, PASSWORD);
            } catch (SQLException e) {
                throw new SQLException("Failed to create database connection", e);
            }
        }
        return connection;
    }

}