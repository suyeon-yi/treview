package com.treview.t_board.service;

import com.treview.t_board.dao.T_boardDAO;
import com.treview.t_board.vo.T_boardVO;

public class T_boardViewService {

	public T_boardVO service(long no, long inc) throws Exception {
		T_boardDAO dao = new T_boardDAO();
		if(inc == 1) dao.increase(no);
		return dao.view(no);
	}
}
