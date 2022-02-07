package com.treview.t_board.service;


import com.treview.t_board.dao.T_boardDAO;
import com.treview.t_board.vo.T_boardVO;

public class T_boardWriteService {

	public int service(T_boardVO vo) throws Exception {
		T_boardDAO dao = new T_boardDAO();
		return dao.write(vo);
	}
}
