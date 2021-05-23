package helpers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import net.minidev.json.JSONObject;

public class DBHandler {
    private static String connectionUrl = "jdbc:sqlserver://localhost:14330;database=Pubs;user=sa;password=PaSSw0rd";
    public static void addNewJobWithName(String jobName){
        try(Connection connect = DriverManager.getConnection(connectionUrl)){
            connect.createStatement().execute("INSERT INTO [pubs].[dbo].[jobs] (job_desc,min_lvl,max_lvl VALUES('"+jobName+"', 50, 100)");
        }catch (SQLException e){
            e.printStackTrace();
        }
    }

    public static JSONObject getMinAndMaxLevelsForJob(String jobName){
        JSONObject json = new JSONObject();
        try(Connection connect = DriverManager.getConnection(connectionUrl)){
           ResultSet rs = connect.createStatement().executeQuery("SELECT * FROM [pubs].[dbo].[jobs] WHERE job_desc = '"+jobName+"'");
           rs.next();
           json.put("minLvl", rs.getString("min_lvl"));
           json.put("maxLvl", rs.getString("max_lvl"));
        }catch (SQLException e){
            e.printStackTrace();
        }
        return json;

    }

}