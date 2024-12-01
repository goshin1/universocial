package manager;
import java.sql.*;

public class BasicMgr {
	private String root = "jdbc:mysql://localhost:3306/jspdb?useUnicode=true&characterEncoding=utf8";
	private String user = "root";
	private String pwd = "3040";
	Connection conn = null;
	ResultSet rs;
	
	
	public BasicMgr() {
		// 생성자
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(root, user, pwd);
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	public void createConnection() {
		// 연결
		try {
			conn = DriverManager.getConnection(root, user, pwd);
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	public Connection getConnection() {
		return conn;
	}
	
	public String getType(String id, ProfileType pt) {
		createConnection();
		PreparedStatement pstmt = null;
		String result = null;
		try {
			pstmt = conn.prepareStatement("select * from members where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getString(pt.getColumnName());
			}
			
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally{
			if(pstmt != null)try{pstmt.close();}catch(SQLException e){}
			if(conn != null)try{conn.close();}catch(SQLException e){}
		}
		return result;
	}
	
	public String management(String id) {
		// 관리자 구분
		createConnection();
		Statement stmt = null;
		String check = "no";
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from membersMgr");
			while(rs.next()) {
				if(rs.getString("id").equals(id)) {
					check = "yes";
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			try {
				if(stmt != null) stmt.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return check;
	}
	
	public enum ProfileType {
		ID("id", "아이디"),
		NAME("name", "이름"),
		EMAIL("email", "이메일"),
		PWD("pwd", "비밀번호");
		
		private String columnName;
		private String name;
		
		ProfileType(String columnName, String name){
			this.columnName = columnName;
			this.name = name;
		}
		
		public String getColumnName() { return this.columnName; }
		public String getName() { return this.name; }
	}
	
	public boolean changeProfile(String target, String id, String pwd, String name, String email) {
		createConnection();
		PreparedStatement pstmt = null;
		try {
			String query = "update members set id=?, pwd=?, name=?, email=? where id = ?";
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			pstmt.setString(3, name);
			pstmt.setString(4, email);
			pstmt.setString(5, target);
			
			int result = pstmt.executeUpdate();
			return result == 1; // update 문은 성공 시 1 반환.
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}finally{
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			}catch(Exception e) {
				e.printStackTrace();
				return false;
			}
		}
	}
	
}
