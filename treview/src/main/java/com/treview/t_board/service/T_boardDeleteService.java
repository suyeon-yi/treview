package com.treview.t_board.service;

import com.treview.t_board.dao.T_boardDAO;

public class T_boardDeleteService {

	public int service(long no)throws Exception{
		T_boardDAO dao = new T_boardDAO();
		return dao.delete(no);
	}
}
