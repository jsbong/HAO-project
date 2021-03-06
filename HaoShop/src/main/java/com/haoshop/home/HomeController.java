package com.haoshop.home;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.haoshop.model.member.MemberService;
import com.haoshop.model.member.MemberVO;
import com.haoshop.model.payment.PaymentService;
import com.haoshop.model.payment.PaymentVO;
import com.haoshop.model.product.ProductService;

@Controller
public class HomeController {
	int cntToday = 0;
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private PaymentService paymentService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private ProductService productService;

	@RequestMapping(value = {"/","/main"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) {
		  Cookie[] getCookie = request.getCookies(); // 모든 쿠키 가져오기
	      if(getCookie == null){ // 만약 쿠키가 없으면 쿠키 생성
	    	  Cookie setCookie = new Cookie("name", "count"); // 쿠키 이름을 name으로 생성
	    	  setCookie.setMaxAge(60*60*24); // 기간을 하루로 지정(60초 * 60분 * 24시간)
	    	  response.addCookie(setCookie); // response에 Cookie 추가
	    	  cntToday+=1;
		}
		logger.info("Welcome home! The client locale is {}.", locale);
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate);
		return "main";
	}
	
	@RequestMapping(value = "/about", method = RequestMethod.GET)
	public String about() {
		return "common/about";
	}
	
	@RequestMapping(value = "/member", method = RequestMethod.GET)
	public String member() {
		return "admin/member";
	}
	
	
	@RequestMapping(value = "/journal", method = RequestMethod.GET)
	public String collection() {
		return "admin/journal";
	}
	
	//관리자 페이지
	@RequestMapping(value = "/adminpage", method = RequestMethod.GET)
	public String adminpage(@RequestParam(defaultValue = "1") int curPage,@RequestParam(defaultValue = "30") String pCnt, PaymentVO vo, Model model) {
		int count = paymentService.getCountOrderNow();
		int newMemberCnt = memberService.getCountMemberNow();
		int waitDelCnt = paymentService.getCountWait();
		int p_Cnt = productService.getAdminCountProduct(pCnt);
		Pager pager = new Pager(count, curPage);
		int start = pager.getPageBegin(); 
		int end = pager.getPageEnd();
		List<Integer> pay_M = paymentService.paymentMonth();
		List<Long> pay_M_P = paymentService.paymentMonthPrice();
		List<MemberVO> m_list = memberService.getMemberNow();
		
		List<PaymentVO> list = paymentService.getOrderListNow(vo, start, end);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("pay_M", pay_M);
		map.put("pay_M_P", pay_M_P);
		map.put("list", list);
		map.put("m_list", m_list);
		map.put("count", count);
		map.put("newMemberCnt", newMemberCnt);
		map.put("waitDelCnt", waitDelCnt);
		map.put("p_Cnt", p_Cnt);
		map.put("cntToday", cntToday);
		map.put("pager", pager);
		model.addAttribute("map", map);
		return "admin/adminpage";
	}
	@RequestMapping(value = "/asd", method = RequestMethod.GET)
	public String asd() {
		return "admin/asd";
	}
}