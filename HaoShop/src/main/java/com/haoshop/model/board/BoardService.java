package com.haoshop.model.board;

import java.util.List;

import javax.servlet.http.HttpSession;

public interface BoardService {
	
	void createBoard(BoardVO vo) throws Exception;					// 게시글 쓰기 
	void updateBoard(BoardVO vo) throws Exception;					// 게시글 수정
	void deleteBoard(int b_no) throws Exception;						// 게시글 삭제
	int checkBoard(int b_no) throws Exception;						// 게시글 삭제 체크, 숨김
	BoardVO readBoard(int b_no) throws Exception;					// 게시글 읽기
	void b_viewCnt(int b_no, HttpSession session) throws Exception;	// 조회수
	BoardVO previousB(int b_no) throws Exception;					// 이전글
	BoardVO nextB(int b_no) throws Exception;						// 다음글
	List<BoardVO> listAllBoard(String searchOption,String keyword,int start, int end) throws Exception;	// 게시글 목록
	int getCountBoard(String searchOption,String keyword) throws Exception;	// 게시글 갯수
	
}