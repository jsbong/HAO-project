<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE>
<html>
<head>
	<meta charset="UTF-8">
	<title>cart</title>
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script type="text/javascript" src="resources/js/cart.js" charset="UTF-8"></script>
	<link rel="stylesheet" type="text/css" href="resources/css/member/cart.css">
	<script>
		$(document).ready(function() {	// 최상단 체크박스 클릭
			$("#checkAll").click(function() {	// 클릭
				if ($("#checkAll").prop("checked")) {	// input tag name="chk" checked=true
					$("input[name=chk]").prop("checked", true);
				} else {
					$("input[name=chk]").prop("checked", false);
				}
			})
			
			$("input[name=chk]").click(function() {
				if ($("input[name=chk]").length == $("input[name=chk]:checkbox:checked").length) {
					$("#checkAll").prop("checked", true);
				} else {
					$("#checkAll").prop("checked", false);
				}
			})
		})
		
	</script>
</head>
<body>
	<!-- header -->
	<%@ include file="../include/header.jsp" %>
	<!-- cart section -->
	<section class="cart_section">
		<div class="cart-content">
			<c:set var="priceSum" value="0" />
			<h2>CART</h2>
			<ul class="cart_product">
				<li>
					<input id="checkAll" type="checkbox" checked />
					<span>SELECT ALL</span>
				</li>
				<c:forEach items="${cartPrd}" var="cartprd">
					<li class="cart_product_name">
						<input type="checkbox" name="chk" onclick="calCart()" value="${cartprd.p_no}" checked>
						<span>${cartprd.p_name}</span>
						<input type="hidden" name = "m_no" id="m_no" value="${member.m_no}">
						<input type="hidden" name = "c_no" id="c_no" value="${cartprd.c_no}"/>
						<input type="hidden" name = "p_sum" id="p_sum" value="${cartprd.p_sum}"/>
					</li>
					<li class="cart_product_info">
						<div class="product_info_buy">
							<div class="img"><a href="productpage?p_no=${cartprd.p_no}"><img src="${fn:split(cartprd.p_img, '*')[0]}"></a></div>
							<div class="buy_detail">
								<span>SIZE : ${cartprd.p_size} X <fmt:formatNumber value="${cartprd.pay_quantity}" pattern="#,###"/></span>
								<span><fmt:formatNumber value="${cartprd.p_price - cartprd.p_discount}" pattern="\#,###"/></span>
								<span style="text-transform:uppercase;">COLOR : ${cartprd.p_color}</span>
							</div>
						</div>
						<div class="product_info_change">
							<span>합계</span>
							<span><fmt:formatNumber value="${cartprd.p_sum}" pattern="\#,###"/></span>
							<input type="button" id="delCart" onClick="delCart('${cartprd.p_no}', '${member.m_no}', '${cartprd.p_size}')" value="삭제" />
							<input type="hidden" id="p_no" value="${cartprd.p_no}" />
						</div>
						
						<c:set var="priceSum" value="${priceSum + cartprd.p_sum}" />
					</li>
				</c:forEach>
				<li class="sum_detail">
					<span>총계</span>
					<div><span>\</span><span id="total"><fmt:formatNumber value="${priceSum}" pattern="#,###" /></span></div>
				</li>
				<li>
					<input type="hidden" name = "m_no" id="m_no" value="${member.m_no}"/>
					<input type="hidden" name = "c_no" id="c_no" value="${cartprd.c_no}"/>
					<input type="button" name="cartClear" id="cartClear" onclick="cartClear()" value="상품 비우기" />
				</li>
			</ul>
			<div class="pay_detail">
				<input type="button" onclick="payCart()" class="payCart" value="주문하기">
				<input type="hidden" name="hiddenbtn" id="hiddenbtn" value="cartpage" />
				<input type="button" class="goshopping" onclick="location.href='main'" value="쇼핑 계속하기">
			</div>
		</div>
	</section>
	<!-- footer -->
	<%@ include file="../include/footer.jsp" %>
</body>
</html>