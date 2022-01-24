<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>collection</title>
	<link rel="stylesheet" href="resources/css/admin_bar.css">
	<link rel="stylesheet" href="resources/css/insertProduct.css">
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="resources/ckeditor/ckeditor.js"></script>
    <script>
    	function doInsertJournal() {
    		var formData = new FormData($("#fileForm")[0]);
    		formData.append('jour_explain', CKEDITOR.instances.jour_explain.getData());
    		
    		$.ajax({
    			type: "POST",
    			url : "insertJournal",
    			data : formData,
    			processData : false,
    			contentType : false,
    			success : function(data) {
    				swal("","컬렉션이 등록되었습니다", "success")
    				.then(function(isConfirm) {
    					location.href="journal";
    				});
    			}, error : function(error) {
    				swal("왜!", jour_no, "error");
    			}
    		});
    	}
    </script>
</head>
<body>
	<!-- navigation -->
	<%@ include file="../admin/admin_bar.jsp" %>
	
	<!-- collection section -->
	<section class="insert_section">
		<div class="insert_div">
			<h2 align="center">COLLECTION REGISTRATION</h2>
			<form id="fileForm" name="form1" method="post" enctype="multipart/form-data">
				<table class="insert_table">
					<tr>
						<th>관리자번호</th>
						<td><input type="text" id="m_no" name="m_no" value="${member.m_no}">
					</tr>
					<tr>
						<th>컬렉션명</th>
						<td><input type="text" id="jour_name" name="jour_name"></td>
					</tr>
					<tr>
						<th>메인이미지</th>
						<td><input type="file" id="file1" name="file1">
					</tr>
					<tr>
						<th>컬렉션설명</th>
						<td>
                        <textarea name="jour_explain" id="jour_explain" cols="88" rows="80"></textarea>
                        <script>
							CKEDITOR.replace( 'jour_explain', {
								filebrowserUploadUrl : "imageUpload.do"
							});
						</script>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<input type="button" value="컬렉션 등록" onclick="doInsertJournal()">
						</td>
					</tr>
				</table>
			</form>
		</div>
	</section>
</body>
</html>

