package reply;

import java.sql.*;
import java.util.ArrayList;

public class replycon {

	private static Connection conn;
	private static ResultSet rs;
	
	public replycon() {
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
	
	public ArrayList<Reply> getList(int bID){
		String SQL="select * from reply where replyAvailable=1 AND bID=? order by replyID DESC";
		ArrayList<Reply> list=new ArrayList<Reply>();
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, bID);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Reply reply = new Reply();
				reply.setUserID(rs.getString(1));
				reply.setReplyID(rs.getInt(2));
				reply.setReplyContent(rs.getString(3));
				reply.setbID(rs.getInt(4));
				reply.setrDate(rs.getString(5));
				reply.setReplyAvailable(rs.getInt(6));
				list.add(reply);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
		e.printStackTrace();
		}
		return "";
	}

	public int getNext() {
		String SQL="select replyID FROM REPLY ORDER BY replyID DESC";
		try {
		
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				System.out.println(rs.getInt(1)); // select문에서 첫번째 값
				return rs.getInt(1)+1;  // 현재 인덱스(현재 게시글 개수) +1 반환
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int write(int bID,String replyContent,String userID) {
		String SQL="insert into reply values(?, ?, ?, ?, ?, ?)";
		
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			String uid = new String(userID.getBytes("UTF-8"));
			String rcontent = new String(replyContent.getBytes("UTF-8"));
			pstmt.setString(1,uid);
			pstmt.setInt(2, getNext());
			pstmt.setString(3, rcontent);
			pstmt.setInt(4,bID);
			pstmt.setString(5, getDate());
			pstmt.setInt(6,1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete(int replyID) {
		String SQL = "delete from reply where replyID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, replyID);
			return pstmt.executeUpdate();
			
			} catch (Exception e) {
				e.printStackTrace();
			}
		return -1;
		}
}