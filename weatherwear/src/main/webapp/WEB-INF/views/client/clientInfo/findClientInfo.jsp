<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>WeatherWear 사용자</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<!-- Google Fonts -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=EB+Garamond:wght@400;500&amp;family=Inter:wght@400;500&amp;family=Playfair+Display:ital,wght@0,400;0,700;1,400;1,700&amp;display=swap" rel="stylesheet">
	<!-- Theme style -->
	<link rel="stylesheet" href="resources/admin/AdminLTE/dist/css/adminlte.min.css">
	<!-- Vendor CSS Files -->
	<link href="resources/client/ZenBlog/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="resources/client/ZenBlog/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
	<!-- Swiper -->
	<link href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css" rel="stylesheet"/>
	<!-- Template Main CSS Files -->
	<link href="resources/client/ZenBlog/assets/css/main.css" rel="stylesheet">
	<link href="resources/client/ZenBlog/assets/css/variables.css" rel="stylesheet">
	<style>
		radio { vertical-align: 4px; }
		.find-body { width: 30%; margin: 30px auto; }
	</style>
</head>
<body class="hold-transition sidebar-collapse layout-top-nav">
	<div class="wrapper">
		<%@ include file="../header.jsp" %>
		
		<main id="main">
			<section id="contact" class="contact mb-5">
				<div class="container aos-init aos-animate" data-aos="fade-up">
					<div class="row justify-content-center mt-5">
						<div class="col-lg-12 text-center">
						
							<c:if test="${findType == 'clientId'}">
								<h3 id="" class="comment-title">아이디 찾기</h3>
							</c:if>
							
							<c:if test="${findType == 'clientPwd'}">
								<h3 id="title" class="comment-title">비밀번호 찾기</h3>
							</c:if>
							
							<div id="findResult"></div>
							<form id="findInfoForm" action="findInfoProc.do" method="post">
								<div class="row text-center">
									<div class="find-body">
										<div style="float: left; width: 50%;">
											<input type="radio" id="radioEmail" name="findKey" value="clientEmail" checked>
											<label for="clientEmail" class="form-check-label">이메일</label>
										</div>
										<div style="float: right; width: 50%; margin-bottom: 30px;">
											<input type="radio" id="radioNum" name="findKey" value="clientNum">
											<label for="clientNum" class="form-check-label">휴대폰번호</label>
										</div>
										
										<c:if test="${findType == 'clientPwd'}">
											<div class="input-group mb-3">
												<div class="input-group-prepend">
													<span class="input-group-text" style="display: inline-block; width: 100px;">아이디</span>
												</div>
												<input type="text" class="form-control" id="clientId" name="clientId">
											</div>
										</c:if>
										
										<div class="input-group mb-3">
											<div class="input-group-prepend">
												<span class="input-group-text" style="display: inline-block; width: 100px;">이름</span>
											</div>
											<input type="text" class="form-control" id="clientName" name="clientName">
										</div>
										<div class="input-group mb-3" id="inputEmail">
											<div class="input-group-prepend">
												<span class="input-group-text" style="display: inline-block; width: 100px;">이메일</span>
											</div>
											<input type="text" class="form-control" id="clientEmail" name="clientEmail">
										</div>
										<div class="input-group mb-3" id="inputPhone" style="display: none;">
											<div class="input-group-prepend">
												<span class="input-group-text" style="display: inline-block; width: 100px;">휴대폰번호</span>
											</div>
											<input type="hidden" id="clientNum" name="clientNum">
											<input type="text" class="form-control" id="clientNum1" name="clientNum1" maxlength="3" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
											<input type="text" class="form-control" id="clientNum2" name="clientNum2" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
											<input type="text" class="form-control" id="clientNum3" name="clientNum3" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
										</div>
										<button type="submit" class="btn btn-block btn-dark pd-1 mg-2">확인</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</section>
		</main>
		
		<%@ include file="../footer.jsp" %>
	</div>

	<script src="resources/client/ZenBlog/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script  src="resources/util/plugins/sweetalert/jquery-lates.min.js"></script>
	<script src="resources/util/plugins/sweetalert/sweetalert2.js"></script>
	<!-- Template Main JS File -->
	<script src="resources/client/ZenBlog/assets/js/main.js"></script>
	<!-- sweetAlert (alert/confirm/toast) -->
	<script src="resources/util/js/sweetalert.js"></script>
	<!-- AdminLTE App -->
	<script src="resources/admin/AdminLTE/dist/js/adminlte.js"></script>
	<!-- jQuery-validation -->
	<script src="resources/admin/AdminLTE/plugins/jquery-validation/jquery.validate.min.js"></script>
	<script src="resources/admin/AdminLTE/plugins/jquery-validation/additional-methods.min.js"></script>
	<script>
		$(document).ready(function() {
			<c:if test="${msg != '' && msg != null}">
				playAlert('${msg}', 'success', '로그인 페이지로 이동합니다.', 'login.do');
			</c:if>	
			
		 	var findType = '${findType}';
		 
			$('input[type="radio"][id="radioEmail"]').on('click', function() {
				var sel = $('input[type="radio"][id="radioEmail"]').is(':checked');
				if(sel) {
					$('#inputPhone').hide();
					$('#inputEmail').show();
					formClear();
				}
			});
			$('input[type="radio"][id="radioNum"]').on('click', function() {
				var sel = $('input[type="radio"][id="radioNum"]').is(':checked');
				if(sel) {
					$('#inputEmail').hide();
					$('#inputPhone').show();
					formClear();
				}
			});
			
			function formClear() {
				$('#findInfoForm').validate().resetForm();
				textInput = document.querySelectorAll('input[type="text"]');
				textInput.forEach(input => input.value = '');
				hiddenInput = document.querySelectorAll('input[type="hidden"]');
				hiddenInput.forEach(input => input.value = '');
			}
			
			$('#findInfoForm').validate({
				rules: {
					clientId: {
						required: true
					},
					clientName: {
						required: true
					},
					clientEmail: {
						required: true
					},
					clientNum1: {
						required: true
					},
					clientNum2: {
						required: true,
						minlength: 4
					},
					clientNum3: {
						required: true,
						minlength: 4
					}
				},
				messages: {
					clientId: {
						required: "아이디를 입력해주세요."
					},
					clientName: {
						required: "이름을 입력해주세요."
					},
					clientEmail: {
						required: "이메일을 입력해주세요.",
					},
					clientNum1: {
						required: "휴대폰번호를 입력해주세요.",
					},
					clientNum2: {
						required: "휴대폰번호를 입력해주세요.",
		                minlength: "휴대폰번호는 4자 입력해주세요!",
					},
					clientNum3: {
						required: "휴대폰번호를 입력해주세요.",
		                minlength: "휴대폰번호는 4자 입력해주세요!",
					}
				},
				errorElement: 'span',
				errorPlacement: function(error, element) {
					error.addClass('invalid-feedback');
					element.closest('.input-group div').append(error);
				},
				highlight: function(element, errorClass, validClass) {
					$(element).addClass('is-invalid');
				},
				unhighlight: function(element, errorClass, validClass) {
					$(element).removeClass('is-invalid');
				},
				submitHandler: function(form) {
					var keyType = $('input[name=findKey]:checked').val();
					$.ajax({
						url: 'findInfoProc.do',
						type: 'post',
						dataType: 'json',
						data: {
							clientId: $('#clientId').val(),
							clientName: $('#clientName').val(),
							clientEmail: $('#clientEmail').val(),
							clientNum: $('#clientNum1').val() + $('#clientNum2').val() + $('#clientNum3').val(),
							searchType: findType,
							keyType: keyType
						},
						success: function(res) {
							if(res.code == -1) {
								if(findType == 'clientId') {
									playToast('입력하신 정보로 가입 된 회원 아이디는 존재하지 않습니다.', 'error');
								} else if (findType == 'clientPwd') {
									playToast('입력하신 정보로 가입 된 회원은 존재하지 않습니다.', 'error');
								}
							} else {
								if(findType == 'clientId') {
									var htmlDummy = '<div style="width: 50%; margin: 0 auto;">'
												+ '<div class="card">'
												+ '<div class="card-header">고객님의 아이디찾기가 완료되었습니다.</div>'
												+ '<div class="card-body"><span>저희 쇼핑몰을 이용해주셔서 감사합니다.<br/>다음 정보로 가입된 아이디입니다.</span></div></div>'
												+ '<div class="card"><div class="col-lg-12 text-center"><div class="card-body"><div class="row"><div class="col-sm-6 text-right">이름:</div><div class="col-sm-6 text-left">'
												+ res.data.clientName
												+ '</div></div><div class="row">';
									if(keyType == 'clientEmail') {
										htmlDummy += '<div class="col-sm-6 text-right">이메일:</div><div class="col-sm-6 text-left">'
												+ res.data.clientEmail;
									} else if(keyType == 'clientNum') {
										var numData = res.data.clientNum;
										htmlDummy += '<div class="col-sm-6 text-right">휴대폰번호:</div><div class="col-sm-6 text-left">'
												+ numData.substring(0, 3) + "-" + numData.substring(3, 7) + "-" + numData.substring(7, 12);
									}
									htmlDummy += '</div></div><div class="row"><div class="col-sm-6 text-right">아이디:</div><div class="col-sm-6 text-left">'
											+ '<b>' + res.data.clientId.substring(0, res.data.clientId.length - 3) + '***</b>'
											+ '</div></div></div></div></div></div></div>';
									
									htmlDummy += '<div><div class="row justify-content-center"><div class="col-sm-2"><button type="button" class="btn btn-block btn-dark" onclick="location.href=&#39;login.do&#39;">로그인</button></div>'
											+ '<div class="col-sm-2"><button type="button" class="btn btn-block btn-outline-dark" onclick="location.href=&#39;findClientPwd.do&#39;">비밀번호찾기</button></div></div></div></div>'
									
								} else if(findType == 'clientPwd') {
									var htmlDummy = '<form action="tempPwd.do" method="post"><div style="width: 50%; margin: 0 auto;">'
												+ '<input type="hidden" name="clientId" value="' + res.data.clientId + '">'
												+ '<div class="card">'
												+ '<div class="card-body"><div class="row"><div class="col-sm-6 text-right">임시비밀번호</div><div class="col-sm-6 text-left">';
									if(keyType == 'clientEmail') {
										htmlDummy += "<input type='hidden' name='clientEmail' value='" + res.data.clientEmail + "'>"
												+ '<input type="radio" name="keyType" value="clientEmail" checked>이메일</div></div>'
												+ '<div class="row"><div class="col-sm-6 text-right">이메일</div><div class="col-sm-6 text-left">'
												+ res.data.clientEmail;
									} else if(keyType == 'clientNum') {
										var numData = res.data.clientNum;
										htmlDummy += "<input type='hidden' name='clientNum' value='" + res.data.clientNum + "'>"
												+ '<input type="radio" name="keyType" value="clientNum" checked>휴대폰 번호</div></div>'
												+ '<div class="row"><div class="col-sm-6 text-right">휴대폰 번호</div><div class="col-sm-6 text-left">'
												+ numData.substring(0, 3) + "-" + numData.substring(3, 7) + "-" + numData.substring(7, 12);
									}
									
									htmlDummy += '</div></div></div></div></div>';
									htmlDummy += '<div><div class="row justify-content-center"><div class="col-sm-3"><button type="submit" class="btn btn-block btn-dark">임시 비밀번호 전송</button></div>'
											+ '<div class="col-sm-3"><button type="button" class="btn btn-block btn-outline-dark" onclick="location.href=&#39;main.do&#39;">취소</button></div></div></div></div></form>'
								}
								
								$(form).remove();
								const innerH = document.getElementById('findResult');
								innerH.innerHTML = htmlDummy;
							}
						},
						error: function(request, status, error) {
							console.log("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
						}
					});
					
				}
			});
		});
	</script>
</body>
</html>