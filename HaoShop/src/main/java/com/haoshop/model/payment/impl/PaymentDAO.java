package com.haoshop.model.payment.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.haoshop.model.member.MemberVO;
import com.haoshop.model.payment.PaymentVO;


@Repository
public class PaymentDAO {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	// 물품 구매
	public List<PaymentVO> getPaymentProduct(PaymentVO vo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("payment", vo);
		return mybatis.selectList("PaymentDAO.paymentProduct", map);
	}
	
	// 장바구니 물품 구매
	public List<PaymentVO> cartPaymentProduct(PaymentVO vo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("payment", vo);
		return mybatis.selectList("PaymentDAO.cartPaymentProduct", map);
	}
	
	// 결제
	public void insertPayment(PaymentVO vo) {
		mybatis.insert("PaymentDAO.insertPayment", vo);
	}
	
	// 결제 후 장바구니 비우기
	public void deleteCartPayment(PaymentVO vo) {
		mybatis.delete("PaymentDAO.deleteCartPayment", vo);
	}
	
	// 주문내역 - 관리자
	public List<PaymentVO> getOrderListAll(String sPrd, int start, int end) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sPrd", sPrd);
		map.put("start", start);
		map.put("end", end);
		return mybatis.selectList("PaymentDAO.orderMemberAll", map);
	}

	// 주문내역 갯수 - 관리자
	public int getCountOrderAll(String sPrd) {
		return mybatis.selectOne("PaymentDAO.orderCountAll", sPrd);
	}

	//주문 상태 변경 - 관리자
	public void updateState(PaymentVO vo) {
		mybatis.update("PaymentDAO.updateState", vo);
	}

	public List<PaymentVO> getOrderListNow(PaymentVO vo, int start, int end) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		return mybatis.selectList("PaymentDAO.orderMemberNow", map);
	}

	public int getCountOrderNow() {
		return mybatis.selectOne("PaymentDAO.orderCountNow");
	}

	public int getCountWait() {
		return mybatis.selectOne("PaymentDAO.getCountWait");
	}

	public List<Integer> paymentMonth() {
		return mybatis.selectList("PaymentDAO.paymentMonth");
	}
	
	public List<Long> paymentMonthPrice() {
		return mybatis.selectList("PaymentDAO.paymentMonthPrice");
	}
}