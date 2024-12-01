package score;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class scorecon {
	
	private static Connection conn;
	private static ResultSet rs;
	
	public scorecon() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String JDBC_URL = "jdbc:mysql://localhost:3306/jspdb?useUnicode=true&characterEncoding=utf8";
			String USER = "root";
			String PASS = "3040";
			conn = DriverManager.getConnection(JDBC_URL, USER, PASS);
		} catch(Exception e) {
			 e.printStackTrace();
		}
	}
	
	public ArrayList<Score> getList(int scoreID, String userID){
		String SQL="select * from score where userID= ? order by scoreID DESC";
		ArrayList<Score> list = new ArrayList<Score>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Score score = new Score();
				score.setUserID(rs.getString(1));
				score.setScoreID(rs.getInt(2));
				score.setSubname(rs.getString(3));
				score.setCredit(rs.getInt(4));
				score.setGscore(rs.getInt(5));
				list.add(score);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public int getNext() {
		String SQL="select scoreID FROM score ORDER BY scoreID DESC";
		try {
		
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				System.out.println(rs.getInt(1));
				return rs.getInt(1)+1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int getrank(int scoreID) {
		String SQL="select subrank from (select *, rank() over (partition by subname order by gscore desc) as subrank from score) as s where s.scoreID = ?";
		
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
	
			pstmt.setInt(1, scoreID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				System.out.println(rs.getInt(1));
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public float getgave(String userID) {
		String SQL="SELECT *, sum((CASE WHEN gscore>= 95 THEN 4.5 WHEN (gscore>= 90 AND gscore < 95) THEN 4 WHEN (gscore>= 85 AND gscore < 90) THEN 3.5 WHEN (gscore>= 80 AND gscore < 85) THEN 3  WHEN (gscore>= 75 AND gscore < 80) THEN 2.5 WHEN (gscore>= 70 AND gscore < 75) THEN 2 WHEN (gscore>= 65 AND gscore < 70) THEN 1.5 WHEN (gscore>= 60 AND gscore < 65) THEN 1 ELSE 0 END)*credit)/sum(credit) as save FROM score where userID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				System.out.println(rs.getFloat(6));
				return rs.getFloat(6);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public int write(int scoreID,String subname,int credit,int gscore,String userID) {
		String SQL="insert into score values(?, ?, ?, ?, ?)";
		
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			String uid = new String(userID.getBytes("UTF-8"));
			String sname = new String(subname.getBytes("UTF-8"));
			
			pstmt.setString(1,uid);
			pstmt.setInt(2, getNext());
			pstmt.setString(3, sname);
			pstmt.setInt(4,credit);
			pstmt.setInt(5, gscore);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete(int scoreID) {
		String SQL = "delete from score where scoreID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, scoreID);
			return pstmt.executeUpdate();
			
			} catch (Exception e) {
				e.printStackTrace();
			}
		return -1;
		}
}
