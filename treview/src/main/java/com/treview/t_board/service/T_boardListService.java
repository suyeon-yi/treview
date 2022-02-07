package com.treview.t_board.service;

import java.util.List;

import com.treview.t_board.dao.T_boardDAO;
import com.treview.t_board.vo.T_boardVO;
import com.webjjang.util.PageObject;


public class T_boardListService {

	public List<T_boardVO> service(PageObject pageObject) throws Exception{
		T_boardDAO dao = new T_boardDAO();
		pageObject.setTotalRow(dao.getTotalRow(pageObject));
		return dao.list(pageObject);
	}
}
