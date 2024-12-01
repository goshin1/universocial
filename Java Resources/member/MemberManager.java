package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import sql.JDBCVar;

public class MemberManager {
	
	public MemberManager() {
		try {
			Class.forName(JDBCVar.JDBC_DRIVER);
		} catch(Exception e) {
			System.out.println("Error : " + e.getMessage());
		}
	}
	
	public void insertMember(MemberBean bean) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DriverManager.getConnection(JDBCVar.JDBC_URL, JDBCVar.USER, JDBCVar.PASS);
			pstmt = conn.prepareStatement("insert into members values (?, ?, ?, ?)");
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getPassword());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getEmail());
			
			pstmt.executeUpdate();
		} catch(Exception ex) {
			System.out.println(ex.getMessage());
		} finally {
			if(rs != null) try { rs.close(); } catch(SQLException e) { System.out.println(e.getMessage()); }
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { System.out.println(e.getMessage()); }
			if(conn != null) try { conn.close(); } catch(SQLException e) { System.out.println(e.getMessage()); }
		}
	}

}
