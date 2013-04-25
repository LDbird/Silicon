package silicon.cms.common.factory;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import silicon.ark.dao.DataBaseConn;
import silicon.cms.common.dao.PostDAO;
import silicon.cms.common.entity.GoodsEntity;
import silicon.common.SCLog;

public class ImpPostDAO implements PostDAO
{
	public ImpPostDAO()
	{
		
	}

	@Override
	public void savePost(GoodsEntity m_post) {
		// TODO Auto-generated method stub
		String _sql = "insert into st_goods values(" 
		+ "'" + m_post.getId() + "'" + 
		"'" + m_post.getTitle() + "'" +
		"'" + m_post.getSummary() + "'" +
		"'" + m_post.getPrice() + "'" +
		"'" + m_post.getPhotoURL() + "'" +
		"'" + m_post.getCreateTime() + "'" +
		"'" + m_post.getUpdateTime() + "'" +
		"'" + m_post.getOrderId() + "'" +
		"'" + m_post.getCategoryId() + "'" +
		"'" + m_post.getSubcategoryId() + "'" +
		"'" + m_post.getPublisher() + "'" +
		"'" + m_post.getContentText() + "'" +
		")";
		
		Connection _conn;
		try {
			_conn = DataBaseConn.getConnection();
			if(_conn == null)
			{
				SCLog.info("GoodsEntity 获取数据库连接失败： 连接为空   T_T");
			}
			Statement _statement = _conn.createStatement();
			if(_statement.execute(_sql))
			{
				SCLog.info("post save succeed!");
			}
			else
			{
				SCLog.info("post save failed!");
			}
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}

	@Override
	public GoodsEntity selectById(String m_postId) {
		// TODO Auto-generated method stub
		String _sql = "select * from st_goods where ST_CATEGORY_GOOD_ID = " + "'" + m_postId + "'";
		GoodsEntity _goods = new GoodsEntity();
		try {
			Connection _conn = DataBaseConn.getConnection();
			if(_conn == null)
			{
				SCLog.info("GoodsEntity 获取数据库连接失败： 连接为空   T_T");
				return null;
			}
			Statement _statement = _conn.createStatement();
			ResultSet _rs = _statement.executeQuery(_sql);
			if(_rs == null)
				return null;
			
			_rs.next();
			_goods.setId(_rs.getString("GOODS_ID"));
			_goods.setTitle(_rs.getString("TITLE"));
			_goods.setSummary(_rs.getString("SUMMARY"));
			_goods.setPrice(_rs.getString("PRICE"));
			_goods.setPhotoURL(_rs.getString("PHOTO_URL"));
			_goods.setPublisher(_rs.getString("PUBLISHER"));
			_goods.setTitle(_rs.getString("CONTEXT"));
			_goods.setCategoryId(_rs.getString("ST_CATEGORY_GOOD_ID"));
			_goods.setSubcategoryId(_rs.getString("ST_SUBCATEGORY_ID"));
			_goods.setOrderId(_rs.getString("ST_ORDER_INFO_GOODS_ID"));
			_goods.setCreateTime(_rs.getDate("CREATE_TIME"));
			_goods.setUpdateTime(_rs.getTimestamp("UPDATE_TIME"));
			_rs.close();
			DataBaseConn.closeConn();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return _goods;
	}

	@Override
	public List<GoodsEntity> query(String m_sql) {
		// TODO Auto-generated method stub
		List<GoodsEntity> _list = new ArrayList<GoodsEntity>();
		try {
			Connection _conn = DataBaseConn.getConnection();
			if(_conn == null)
			{
				SCLog.info("GoodsEntity 获取数据库连接失败： 连接为空   ：（");
				return null;
			}
			Statement _statement = _conn.createStatement();
			ResultSet _rs = _statement.executeQuery(m_sql);
			while(_rs.next())
			{
				GoodsEntity _goods = new GoodsEntity();
				_goods.setId(_rs.getString("GOODS_ID"));
				_goods.setTitle(_rs.getString("TITLE"));
				_goods.setSummary(_rs.getString("SUMMARY"));
				_goods.setPrice(_rs.getString("PRICE"));
				_goods.setPhotoURL(_rs.getString("PHOTO_URL"));
				_goods.setPublisher(_rs.getString("PUBLISHER"));
				_goods.setTitle(_rs.getString("CONTEXT"));
				_goods.setCategoryId(_rs.getString("ST_CATEGORY_GOOD_ID"));
				_goods.setSubcategoryId(_rs.getString("ST_SUBCATEGORY_ID"));
				_goods.setOrderId(_rs.getString("ST_ORDER_INFO_GOODS_ID"));
				_goods.setCreateTime(_rs.getDate("CREATE_TIME"));
				_goods.setUpdateTime(_rs.getTimestamp("UPDATE_TIME"));
				_list.add(_goods);
			}
			_rs.close();
			DataBaseConn.closeConn();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return _list;
	}

	@Override
	public void update(GoodsEntity m_post) {
		// TODO Auto-generated method stub
		String _sql = "update st_goods set " +
		"GOODS_ID = " + "'" + m_post.getId() + "'" +
		"TITLE = " + "'" + m_post.getTitle() + "'" +
		"SUMMARY = " + "'" + m_post.getSummary() + "'" +
		"PRICE = " + "'" + m_post.getPrice() + "'" +
		"PHOTO_URL = " + "'" + m_post.getPhotoURL() + "'" +
		"CREATE_TIME = " + "'" + m_post.getCreateTime() + "'" +
		"UPDATE_TIME = " + "'" + m_post.getUpdateTime() + "'" +
		"ST_ORDER_INFO_GOODS_ID = " + "'" + m_post.getOrderId() + "'" +
		"ST_CATEGORY_GOOD_ID = " + "'" + m_post.getCategoryId() + "'" +
		"ST_SUBCATEGORY_ID = " + "'" + m_post.getSubcategoryId() + "'" +
		"PUBLISHER = " + "'" + m_post.getPublisher() + "'" +
		"CONTEXT = " + "'" + m_post.getContentText() + "'" +
		"where GOODS_ID = " + "'" + m_post.getId() + "'";
		try {
			Connection _conn = DataBaseConn.getConnection();
			if(_conn == null)
			{
				SCLog.info("GoodsEntity 获取数据库连接失败： 连接为空   T_T");
			}
			Statement _statement = _conn.createStatement();
			if(_statement.execute(_sql))
			{
				SCLog.info("post save succeed!");
			}
			else
			{
				SCLog.info("post save failed!");
			}
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}

	@Override
	public void deleteById(String m_id) {
		// TODO Auto-generated method stub
		String _sql = "delete from st_goods where GOODS_ID = " + "'" + m_id + "'";
		try {
			Connection _conn = DataBaseConn.getConnection();
			Statement _statement = _conn.createStatement();
			if(_statement.execute(_sql))
			{
				SCLog.info("post delete succeed!");
			}
			else
			{
				SCLog.info("post delete failed!");
			}
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
