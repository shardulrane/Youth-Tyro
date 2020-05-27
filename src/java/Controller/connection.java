package Controller;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author Shardul Rane
 */
public class connection {

    public Connection getcon() throws Exception {
        Connection con;
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver").newInstance();
        con = DriverManager.getConnection("jdbc:sqlserver://SHARK;databaseName=tyro;user=tyro;password=tyro123");
        return con;

    }

}
