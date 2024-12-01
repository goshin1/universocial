package message;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;

import sql.JDBCVar;

public class MsgManager {
	
	private static Connection conn;
	private static ResultSet rs;
	
	public MsgManager() {
		try {
			Class.forName(JDBCVar.JDBC_DRIVER);
			conn = DriverManager.getConnection(JDBCVar.JDBC_URL, JDBCVar.USER, JDBCVar.PASS);
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
	
	public int getNextMsgID() {
		String SQL = "SELECT * FROM message ORDER BY messageID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
		} catch (Exception e) {
		e.printStackTrace();
		}
		return 1;
	}
	
	public HashMap<String, List<MessageInfo>> getMessages(String id){
		String sql = "SELECT * FROM message WHERE senderID = ? or receiverID = ? ORDER BY messageID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			
			HashMap<String, List<MessageInfo>> hash = new HashMap<String, List<MessageInfo>>();
			while (rs.next()) {
				
				MessageInfo mi = createMessageInfo();
				
				String target = mi.getSenderID().equals(id) ? mi.getReceiverID() : mi.getSenderID();
				List<MessageInfo> list;
				if(hash.containsKey(target))
					list = hash.get(target);
				else {
					list = new ArrayList<MessageInfo>();
					hash.put(target, list);
				}
				list.add(mi);
			}
			
			return hash;
		} catch(SQLException io) {
			io.printStackTrace();
		}
		return null;
	}
	
	public List<MessageInfo> getChattingLog(String id, String target){
		List<MessageInfo> list = new ArrayList<MessageInfo>();
		String sql = "SELECT * FROM message WHERE senderID = ? and receiverID = ? ORDER BY messageID DESC";
		String sql2 = "SELECT * FROM message WHERE senderID = ? and receiverID = ? ORDER BY messageID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, target);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MessageInfo mi = createMessageInfo();
				list.add(mi);
			}
			
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setString(1, target);
			pstmt2.setString(2, id);
			rs = pstmt2.executeQuery();
			while(rs.next()) {
				MessageInfo mi = createMessageInfo();
				list.add(mi);
			}
			
			sort(list);
			return list;
			
		} catch(SQLException io) {
			io.printStackTrace();
		}
		return null;
	}
	
	public List<String> getChattingIDList(String id){
		List<String> list = new ArrayList<String>();
		String sql = "SELECT * FROM message WHERE senderID = ? or receiverID = ? ORDER BY messageID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String senderID = rs.getString(2);
				String receiverID = rs.getString(3);
				
				String target = senderID.equals(id) ? receiverID : senderID;
				if(!list.contains(target))
					list.add(target);
			}
		} catch(SQLException io) {
			io.printStackTrace();
		}
		return list;
	}
	
	public List<String> getMemberList(){
		List<String> list = new ArrayList<String>();
		String sql = "select * from members";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list.add(rs.getString(1));
			}
		} catch(SQLException io) {
			io.printStackTrace();
		}
		return list;
	}
	
	public void send(String senderID, String recvID, String content) {
		String sDate = getDate();
		int messageID = getNextMsgID();
		
		String sql = "INSERT INTO message values (?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, messageID);
			pstmt.setString(2, senderID);
			pstmt.setString(3, recvID);
			pstmt.setString(4, content);
			pstmt.setString(5, sDate);
			
			pstmt.executeUpdate();
		} catch(SQLException io) {
			io.printStackTrace();
		}
	}
	
	private MessageInfo createMessageInfo() {
		try {
			int messageID = rs.getInt(1);
			String senderID = rs.getString(2);
			String receiverID = rs.getString(3);
			String content = rs.getString(4);
			String sDate = rs.getString(5);
			
			MessageInfo mi = new MessageInfo();
			mi.setMessageID(messageID);
			mi.setSenderID(senderID);
			mi.setReceiverID(receiverID);
			mi.setContent(content);
			mi.setsDate(sDate);
			return mi;
		} catch(SQLException io) {
			io.printStackTrace();
		}
		return null;
	}
	
	public void close() {
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void sort(List<MessageInfo> milist) {
		Comparator<MessageInfo> comp = new Comparator<MessageInfo>() {
			@Override
			public int compare(MessageInfo mi1, MessageInfo mi2) {
				return mi1.getMessageID() - mi2.getMessageID();
			}
		};
		
		Collections.sort(milist, comp);
	}

}
