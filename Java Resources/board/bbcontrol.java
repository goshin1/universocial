package board;

import java.sql.*;
import java.util.ArrayList;

public class bbcontrol {
	
	private static Connection conn;
	private static ResultSet rs;
	
	public bbcontrol() {
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
	
	public static int getNext() {
		String SQL = "Select bID from board order by bID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //첫번째 게시글
		} catch (Exception e) {
		e.printStackTrace();
		}
		return -1; //오류 시
	}
	
	public int write(String bTitle, String userID, String bContent) {
		
		String SQL = "insert into board values (?, ?, ?, ?, ?, ?)";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			String title = new String(bTitle.getBytes("UTF-8"));
			String uid = new String(userID.getBytes("UTF-8"));
			String content = new String(bContent.getBytes("UTF-8"));
			pstmt.setInt(1, getNext());
			pstmt.setString(2, title);
			pstmt.setString(3, uid);
			pstmt.setString(4, getDate());
			pstmt.setString(5, content);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
		e.printStackTrace();
		}
		return -1; //오류 시
	}
	
	public ArrayList<bboard> getList(int pageNumber) {
			String SQL = "select * from board where bID < ? and bAvailable = 1 order by bID DESC LIMIT 8";
			ArrayList<bboard> list = new ArrayList<bboard>();
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					bboard board = new bboard();
					board.setbID(rs.getInt(1));
					board.setbTitle(rs.getString(2));
					board.setUserID(rs.getString(3));
					board.setbDate(rs.getString(4));
					board.setbContent(rs.getString(5));
					board.setbAvailable(rs.getInt(6));
					list.add(board);
					}
			} catch (Exception e) {
			e.printStackTrace();
			}
			return list; //오류 시
		}
	
	static public boolean nextPage(int pageNumber) {
		String SQL = "select * from board where bID < ? and bAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; //오류 시
	}
	
	public bboard getboard(int bID) {
		String SQL = "select * from board where bID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bboard board = new bboard();
				board.setbID(rs.getInt(1));
				board.setbTitle(rs.getString(2));
				board.setUserID(rs.getString(3));
				board.setbDate(rs.getString(4));
				board.setbContent(rs.getString(5));
				board.setbAvailable(rs.getInt(6));
				return board;
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; //오류 시
	}
	
	public int update(int bID, String bTitle, String bContent) {
		String SQL = "update board set bTitle = ?, bContent = ? where bID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bTitle);
			pstmt.setString(2, bContent);
			pstmt.setInt(3, bID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
		e.printStackTrace();
	}
		return -1;
	}
	
	public int delete(int bID) {
		String SQL = "delete from board where bID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
		e.printStackTrace();
	}
		return -1;
	}
	
	public ArrayList<bboard> getSearch(String searchField, String searchText){
	      ArrayList<bboard> list = new ArrayList<bboard>();
	      
	      String SQL ="select * from board where "+searchField.trim();
	      try {
	            if(searchText != null && !searchText.equals("") ){
	                SQL +=" LIKE '%"+searchText.trim()+"%' order by bID desc";
	            }

				PreparedStatement pstmt=conn.prepareStatement(SQL);
				rs=pstmt.executeQuery();
				
	         while(rs.next()) {
	            bboard board = new bboard();
	            board.setbID(rs.getInt(1));
	            board.setbTitle(rs.getString(2));
	            board.setUserID(rs.getString(3));
	            board.setbDate(rs.getString(4));
	            board.setbContent(rs.getString(5));
	            board.setbAvailable(rs.getInt(6));
	            list.add(board);
	         }         
	      } catch(Exception e) {
	         e.printStackTrace();
	      }
	      return list;
	   }
}
	