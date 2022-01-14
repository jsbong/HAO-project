<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" type="text/css" href="resources/css/productpage.css">
		<script type="text/javascript" src="resources/js/cart.js" charset="UTF-8"></script>
		<script type="text/javascript" src="resources/js/product.js" charset="UTF-8"></script>
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
		<script src="http://code.jquery.com/jquery-latest.js"></script>
		<title>HAOSHOP-PRODUCT</title>
		<script>
		    $(function() {
				$("#pay_quantity").keyup(function(e){
					var regNumber = /^([0-9]{2})$/;
					var str = $(this).val();
					if(!regNumber.test(str)) {
						var res = str.substring(0, str.length-1);
						$(this).val(res);
					}
				});
				
				// 사이즈 클릭 시 수량 선택
				$(".p_select_size").click(function() {
					var p_select_size = $(this).val();
					$("#p_size").val(p_select_size);
					
					if($(".select_quantity").css("display") == "none" || $("#p_size").val() != null) {
						$(".select_quantity").show();
					} else {
						$(".select_quantity").hide();
					}
				});
				
				$(".shipping_info").click(function() {
					if($(this).find("div").css("display") == "none") {
						$(this).find("div").slideDown();
						$(this).find("span").css("transform", "rotate(45deg)");
					} else {
						$(this).find("div").slideUp();
						$(this).find("span").css("transform", "none");
					}
				});
				
				$(".product_explain").click(function() {
					if($(this).find("div").css("display") == "none") {
						$(this).find("span").css("transform", "rotate(45deg)");
						$(this).find("div").slideDown();
					} else {
						$(this).find("div").slideUp();
						$(this).find("span").css("transform", "none");
					}
				});
				
				$("#decreaseQuantity").click(function() {
					
					var stat = $("#pay_quantity").val();
					var num = parseInt(stat, 10); // 10진수로 변환
					num--;
					
					if(num < 1) {
						alert("더 이상 줄일 수 없습니다.");
						num = 1;
					}
					
					$("#pay_quantity").val(num);
				});
				
				$("#increaseQuantity").click(function() {

					var stat = $("#pay_quantity").val();
					var num = parseInt(stat, 10);
					num++;
					
					$("#pay_quantity").val(num);
				});
				
		    });
		</script>
	</head>
	<body>
	
		<!-- header -->
		<%@ include file="../include/header.jsp" %>
		
		<!-- 상품 상세 페이지 -->
		<div class="product-content">
			<article class="product_detail">
				<div>
					<ul>
					<li class="product_left">
						<ul>
							<li><img src="${fn:split(product.p_img, '*')[0]}"></li>
							<li><img src="${fn:split(product.p_img, '*')[1]}"></li>
						</ul>
					</li>
					</ul>
				</div>
				<div class="product_right">
					<input type="hidden" name="p_img" id="p_img" value="${product.p_img}" />
					<input type="hidden" name="m_no" id="m_no" value="${member.m_no}" />
					<input type="hidden" name="p_no" id="p_no" value="${product.p_no}" />
					<input type="hidden" name="hiddenbtn" id="hiddenbtn" value="prdpage" />
					
					<ul>
						<li><h2>${product.p_name}</h2></li>
						<li style="text-transform: lowercase;">color  ${product.p_color}</li>
						<li>price <fmt:formatNumber value="${product.p_price}" pattern="\#,###"/></li>
						<li> 
							<c:forEach items="${fn:split(product.p_size, ',')}" var="opt">
								<input type="button" id="p_select_size" class="p_select_size" value="${opt}">
							</c:forEach>
						</li>
						<li class="select_quantity">
							<ul>
								<li>
									<span style="font-weight:bold">${product.p_name}</span> / ${product.p_price} - <input type="text" id="p_size" size="2" disabled>
								</li>
								<li class="select_quantity_detail">
									<span id="decreaseQuantity" style="cursor:pointer">-</span> 
									<input type="text" id="pay_quantity" min="1" max="99" value="1" />
									<span type="button" id="increaseQuantity" style="cursor:pointer">+</span>
								</li>
							</ul>
						</li>
						<li>
							<input type="button" id="buy_btn" onclick="buyProduct()" value="BUY NOW" />
							<input type="button" id="cart_btn" onclick="insertCart()" value="TO CART" />
						</li>
						<li class="product_explain">DESCRIPTION<span style="float:right">+</span>
							<div class="product_explain_detail">
								${product.p_explain}
							</div>
						</li>
						<li class="shipping_info">SHIPPING / RETURNS<span style="float: right">+</span>
							<div class="shipping_info_detail">
								<p class="shiping_info_title">배송</p>
								<p>
									로젠택배 / CJ대한통운<br>
									배송 전국지역<br>
									비용 \3,0000
									영업일 기준 3일 ~ 7일 소요됩니다.
								</p>
								<p class="shiping_info_title">취소</p>
								<p>
									주문 후 상품준비 중 상태에서만 직접 취소 가능합니다.<br>
								</p>
								<p class="shiping_info_title">교환/반품</p>
								<p>
									상품을 받으신 날로부터 7일 이내에 가능합니다
								</p>
							</div>
						</li>
					</ul>
				</div>
			</article>
		</div>
		
		<!-- footer -->
		<%@ include file="../include/footer.jsp" %>
	</body>
</html>		<meta charset="UTF-8">
		<link rel="stylesheet" type="text/css" href="resources/css/productpage.css">
