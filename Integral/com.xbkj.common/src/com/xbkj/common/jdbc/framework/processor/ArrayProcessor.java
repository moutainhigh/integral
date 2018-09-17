package com.xbkj.common.jdbc.framework.processor;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 */
public class ArrayProcessor extends  BaseProcessor {
	
    /**
	 * <code>serialVersionUID</code> ��ע��
	 */
	private static final long serialVersionUID = 2544096068863958453L;

	public Object processResultSet(ResultSet rs) throws SQLException {
        return rs.next() ? ProcessorUtils.toArray(rs) : null;     
    }
}
